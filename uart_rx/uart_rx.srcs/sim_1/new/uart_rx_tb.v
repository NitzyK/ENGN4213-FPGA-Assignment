`timescale 1ns / 1ps

module uart_rx_fsm_tb;

    // Faster clock parameters (10MHz instead of 100MHz)
    parameter CLK_FREQ = 10_000_000;  // 10 MHz
    parameter CLK_PERIOD = 10;        // 10ns → 100ns (10x slower)
    
    // Faster baud rate (115200 instead of 9600)
    parameter BAUD_RATE = 115200;
    parameter CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;  // ~87 cycles/bit
    parameter BIT_PERIOD = CLKS_PER_BIT * CLK_PERIOD;

    // Inputs
    reg clk;
    reg reset;
    reg rx;

    // Outputs
    wire [7:0] data;
    wire data_valid;

    // Instantiate the UUT with modified parameters
    uart_rx_fsm #(
        .CLKS_PER_BIT(CLKS_PER_BIT),
        .CLKS_PER_HALF_BIT(CLKS_PER_BIT/2)
    ) uut (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .data(data),
        .data_valid(data_valid)
    );

    // Clock generation (10MHz)
    always begin
        clk = 1'b0;
        #(CLK_PERIOD/2);
        clk = 1'b1;
        #(CLK_PERIOD/2);
    end

    // Task to send one UART byte (faster)
    task uart_send_byte;
        input [7:0] tx_byte;
        integer i;
        begin
            // Send Start Bit
            rx = 1'b0;
            #(BIT_PERIOD);

            // Send Data Bits
            for (i = 0; i < 8; i = i + 1) begin
                rx = tx_byte[i];
                #(BIT_PERIOD);
            end

            // Send Stop Bit
            rx = 1'b1;
            #(BIT_PERIOD);
        end
    endtask

    initial begin
        $timeformat(-6, 3, "us", 10);
        
        // Initialize
        reset = 1'b1;
        rx = 1'b1;
        #200;
        reset = 1'b0;
        #200;

        // Test cases (now run ~12x faster)
        $display("[%t] Test 1: 0x55", $time);
        uart_send_byte(8'h55);
        wait(data_valid);
        if (data !== 8'h55) $error("Expected 0x55");
        
        #(BIT_PERIOD);
        
        $display("[%t] Test 2: 0xAA", $time);
        uart_send_byte(8'hAA);
        wait(data_valid);
        if (data !== 8'hAA) $error("Expected 0xAA");
        
        #(BIT_PERIOD);
        
        $display("[%t] Test 3: Framing error", $time);
        rx = 1'b0; // Start
        #(BIT_PERIOD);
        rx = 1'b1; // Bit 0
        #(BIT_PERIOD);
        rx = 1'b0; // Bit 1
        #(BIT_PERIOD);
        // Missing stop
        #(BIT_PERIOD*2);
        if (data_valid) $error("Should not validate");
        rx = 1'b1;
        
        #(BIT_PERIOD*2);
        
        $display("[%t] Test 4: Sequence", $time);
        uart_send_byte(8'h12);
        wait(data_valid);
        uart_send_byte(8'h34);
        wait(data_valid);
        uart_send_byte(8'h56);
        wait(data_valid);
        
        $display("[%t] All tests completed", $time);
        $finish;
    end

    // Monitoring
    always @(posedge data_valid) begin
        $display("[%t] Received: 0x%h", $time, data);
    end

endmodule