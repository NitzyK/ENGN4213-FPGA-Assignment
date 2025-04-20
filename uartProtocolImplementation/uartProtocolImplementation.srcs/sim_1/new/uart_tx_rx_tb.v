`timescale 1ns / 1ps

module uart_top_tb;

    // Inputs
    reg clk;
    reg reset;
    reg rx;
    reg send;
    reg [31:0] data32;

    // Outputs
    wire tx;
    wire [7:0] led;
    wire data_valid_led;
    wire sending_led;
    
    // Testbench variables
    reg [7:0] rx_byte;
    integer i;
    
    // Instantiate the Unit Under Test (UUT)
    uart_top uut (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .send(send),
        .data32(data32),
        .tx(tx),
        .led(led),
        .data_valid_led(data_valid_led),
        .sending_led(sending_led)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock
    end
    
    // UART receiver simulation (baud rate = 9600)
  
    // Initialize Inputs and run test
    initial begin
        // Initialize Inputs
        reset = 1;
        rx = 1;
        send = 0;
        data32 = 32'hDEADBEEF;
        
        // Wait 100 ns for global reset to finish
        #100;
        reset = 0;
        #20
        
     
        // Test 2: Trigger 32-bit transmission
        send = 1;
        #1000;
        send = 0;
        
        // Wait for transmission to complete (4 bytes at 9600 baud)
        #7000000;
        
        // Test 3: Send another 32-bit value
        data32 = 32'h1C322123;
        send = 1;
        #1000;
        send = 0;
        
         #10000;
         #1000000;
                  send = 1;
        #10000;
                  send = 0;
        // Wait for transmission to complete
        #5000000;
        
        // End simulation
        $finish;
    end
    
    // Monitor TX output
    always @(negedge tx) begin
        $display("TX start bit detected at time %t", $time);
        
        // Wait for start bit to finish
        #104160;
        
        // Read 8 data bits
        for (i = 0; i < 8; i = i + 1) begin
            #104160;
            rx_byte[i] = tx;
        end
        
        // Wait for stop bit
        #104160;
        
        $display("Received byte via TX: %h", rx_byte);
    end
    
endmodule