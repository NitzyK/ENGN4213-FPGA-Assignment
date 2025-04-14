`timescale 1ns / 1ps

module uart_top_tb();

    // Testbench Parameters
    parameter CLK_PERIOD = 10;       // 100 MHz clock (10 ns period)
    parameter BAUD_RATE = 921600;    // 921,600 baud (100x faster than 9600)
    parameter BAUD_PERIOD = 1000000000 / BAUD_RATE;  // Baud period in ns
    parameter BIT_PERIOD = BAUD_PERIOD;              // Period per bit
    
    // Module Inputs
    reg clk;
    reg reset;
    reg rx;
    reg send;
    
    // Module Outputs
    wire tx;
    wire [7:0] led;
    wire data_valid_led;
    
    // Test Variables
    reg [7:0] test_data;
    integer i;
    
    // Internal signals for monitoring
    wire send_deb;
    wire [7:0] rx_data;
    wire rx_data_valid;
    wire busy;
    
    // VCD file dump for waveform viewing
    initial begin
        $dumpfile("uart_top_waveform.vcd");
        $dumpvars(0, uart_top_tb);  // Dump all variables
    end
    
    // Instantiate the Unit Under Test (UUT)
    uart_top uut (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .send(send),
        .tx(tx),
        .led(led),
        .data_valid_led(data_valid_led)
    );
    
    // For waveform debugging, connect internal signals
    assign send_deb = uut.send_deb;
    assign rx_data = uut.rx_data;
    assign rx_data_valid = uut.rx_data_valid;
    assign busy = uut.busy;
    
    // Clock Generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end
    
    // UART Receiver Task (simulates sending data to the DUT)
    task uart_send_byte;
        input [7:0] data;
        begin
            // Send Start Bit (0)
            rx = 1'b0;
            #(BIT_PERIOD);
            
            // Send Data Bits
            for (i = 0; i < 8; i = i + 1) begin
                rx = data[i];
                #(BIT_PERIOD);
            end
            
            // Send Stop Bit (1)
            rx = 1'b1;
            #(BIT_PERIOD);
        end
    endtask
    
    // Main Test Sequence
    initial begin
        // Initialize Inputs
        reset = 1;
        rx = 1;
        send = 0;
        test_data = 8'h00;
        
        // Apply Reset
        #100;
        reset = 0;
        #100;
        
        // Test 1: Send data to the receiver and verify LEDs
        $display("Test 1: Basic Receive Test");
        test_data = 8'h55;  // 01010101
        uart_send_byte(test_data);
        #(BIT_PERIOD * 2);
        
        // Verify LED output matches received data
        if (led !== test_data) begin
            $display("Error: LED output mismatch. Expected %h, got %h", test_data, led);
        end else begin
            $display("LED test passed. Received %h", led);
        end
        
        // Test 2: Verify data_valid_led
        #100;
        if (data_valid_led !== 1'b1) begin
            $display("Error: data_valid_led not asserted after reception");
        end else begin
            $display("data_valid_led test passed");
        end
        
        // Wait for data_valid to go low
        wait(data_valid_led == 0);
        
        // Test 3: Transmit test
        $display("Test 3: Transmit Test");
        send = 1;
        #(CLK_PERIOD * 20);  // Hold send signal long enough for debouncer
        send = 0;
        
        // Monitor TX line for transmission
        // Wait for start bit
        wait(tx === 1'b0);
        $display("Start bit detected");
        
        // Sample data bits
        #(BIT_PERIOD * 1.5);  // Sample in middle of first bit period
        for (i = 0; i < 8; i = i + 1) begin
            test_data[i] = tx;
            $display("Bit %d: %b", i, tx);
            #(BIT_PERIOD);
        end
        
        // Verify stop bit
        if (tx !== 1'b1) begin
            $display("Error: Stop bit not detected");
        end else begin
            $display("Stop bit detected");
        end
        
        // Verify transmitted data (should be 8'hAF as per your code)
        if (test_data !== 8'hAF) begin
            $display("Error: Transmitted data mismatch. Expected AF, got %h", test_data);
        end else begin
            $display("Transmit test passed. Sent %h", test_data);
        end
        
        // Test 4: Simultaneous receive and transmit
        $display("Test 4: Simultaneous operation test");
        fork
            begin
                test_data = 8'hAA;
                uart_send_byte(test_data);
            end
            begin
                #(BIT_PERIOD * 2);  // Small delay
                send = 1;
                #(CLK_PERIOD * 20);
                send = 0;
            end
        join
        
        // Wait for operations to complete
        #(BIT_PERIOD * 20);
        
        // Test 5: Reset test
        $display("Test 5: Reset Test");
        reset = 1;
        #100;
        if (led !== 8'h00 || data_valid_led !== 1'b0) begin
            $display("Error: Reset not working properly");
        end else begin
            $display("Reset test passed");
        end
        
        reset = 0;
        #100;
        
        $display("All tests completed");
        $finish;
    end
    
    // Monitor important signals for waveform viewing
    always @(posedge clk) begin
        $display("Time: %t, TX: %b, RX: %b, LED: %h, data_valid: %b, busy: %b, send_deb: %b",
               $time, tx, rx, led, data_valid_led, busy, send_deb);
    end
    
endmodule