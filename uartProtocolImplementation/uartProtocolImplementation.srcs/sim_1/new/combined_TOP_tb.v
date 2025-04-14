`timescale 1ns / 1ps

module combined_TOP_tb();

    // Testbench parameters
    localparam CLK_PERIOD = 10;  // 100 MHz clock
    localparam BAUD_PERIOD = 10416;  // 9600 baud (100MHz/9600)
    
    // DUT signals
    reg clk;
    reg reset;
    
    // RX interface
    reg rx;
    wire [7:0] led;
    wire data_valid;
    
    // TX interface
    reg send;
    wire tx;
    wire tx_busy;
    
    // Test variables
    reg [7:0] test_data = 8'hA5;
    reg [7:0] received_data;
    integer i;
    
    // Instantiate DUT
    combined_TOP dut (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .led(led),
        .data_valid(data_valid),
        .send(send),
        .tx(tx)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end
    
    // UART TX task (emulates a host sending data)
    task uart_send;
        input [7:0] data;
        begin
            rx = 1'b0;  // Start bit
            #(BAUD_PERIOD);
            
            for (i = 0; i < 8; i = i + 1) begin
                rx = data[i];  // LSB first
                #(BAUD_PERIOD);
            end
            
            rx = 1'b1;  // Stop bit
            #(BAUD_PERIOD);
        end
    endtask
    
    // Main test sequence
    initial begin
        // Initialize
        reset = 1;
        send = 0;
        rx = 1;  // Idle state
        #100;
        
        // Release reset
        reset = 0;
        #100;
        
        // Test 1: Verify reception
        $display("Testing UART RX...");
        uart_send(test_data);
        
        // Wait for data valid
        wait(data_valid);
        received_data = led;
        $display("Received data: 0x%h", received_data);
        if (received_data !== test_data)
            $error("RX Data mismatch! Expected 0x%h, got 0x%h", test_data, received_data);
        else
            $display("RX Test passed!");
        
        #1000;
        
        // Test 2: Verify transmission
        $display("\nTesting UART TX...");
        send = 1;
        #100;
        send = 0;
        
        // Monitor TX line
        wait(tx === 1'b0);  // Wait for start bit
        $display("Start bit detected");
        
        // Sample data bits (LSB first)
        #(BAUD_PERIOD * 1.5);  // Sample in middle of first bit
        for (i = 0; i < 8; i = i + 1) begin
            received_data[i] = tx;
            #(BAUD_PERIOD);
        end
        
        // Verify stop bit
        if (tx !== 1'b1)
            $error("Stop bit missing!");
        else
            $display("Stop bit verified");
        
        $display("TX Data: 0x%h", received_data);
        if (received_data !== 8'hAF)
            $error("TX Data mismatch! Expected 0xAF, got 0x%h", received_data);
        else
            $display("TX Test passed!");
        
        #1000;
        $display("\nAll tests completed");
        $finish;
    end
    
    // Monitoring
    initial begin
        $timeformat(-9, 0, " ns", 6);
        $monitor("At %t: TX=%b, RX=%b, Data=0x%h, Valid=%b, Busy=%b",
                 $time, tx, rx, led, data_valid, tx_busy);
    end
    
endmodule