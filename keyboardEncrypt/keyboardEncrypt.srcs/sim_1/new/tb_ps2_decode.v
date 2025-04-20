`timescale 1ns / 1ps

module tb_ps2_decoder();
    // Inputs
    reg clk;
    reg [10:0] ps2_data_in;
    reg dv;
    
    // Outputs
    wire [7:0] scan_code;
    wire is_extended;
    wire is_break;
    wire dv_dec;
    wire [7:0] leds;
    
    wire ledl = 1;
    wire led = 0;
    
    // Instantiate the Unit Under Test (UUT)
    ps2_decoder uut (
        .clk(clk),
        .ps2_data_in(ps2_data_in),
        .dv(dv),
        .scan_code(scan_code),
        .is_extended(is_extended),
        .is_break(is_break),
        .dv_dec(dv_dec),
        .leds(leds)
    );
    
        wordType uut1 (
    .clk(clk),
    .dv_dec(dv_dec),
    .reset(1'b0),
    .enable(1'b1),
    .ps2_scancode(scan_code),
    .extended_flag(is_extended),
    .break_flag(is_break),
    .led(led),
    .ledletter(ledl)
    );
    
    // Clock generation
    always begin
        clk = 0;
        #5;
        clk = 1;
        #5;
    end
    
    // Test cases
    initial begin
        // Initialize Inputs
        ps2_data_in = 0;
        dv = 0;
        
        // Wait for global reset
        #100;
        
        


        $display("Test Case 2: Break code (key release)");
        ps2_data_in = {1'b1,1'b1,8'h1C,1'b1}; // Start bit, 0x1C, parity, stop bit
        dv = 1;
        #10;
        dv = 0;
        #10;
        ps2_data_in ={1'b1,1'b1,8'hF0,1'b1}; // F0 break code
        dv = 1;
        #10;
        dv = 0;
        #10;
        ps2_data_in = {1'b1,1'b1,8'h1C,1'b1}; // 0x1C
        dv = 1;
        #10;
        dv = 0;
        #100;



        ps2_data_in = {1'b1,1'b1,8'hE0,1'b1}; // Start bit, 0x1C, parity, stop bit
        dv = 1;
        #10;
        dv = 0;
        #10;
        ps2_data_in = {1'b1,1'b1,8'h6b,1'b1}; // Start bit, 0x1C, parity, stop bit
        dv = 1;
        #10;
        dv = 0;
        #10;
        ps2_data_in ={1'b1,1'b1,8'hE0,1'b1}; // F0 break code
        dv = 1;
        #10;
        dv = 0;
        #10;
        ps2_data_in = {1'b1,1'b1,8'hf0,1'b1}; // 0x1C
        dv = 1;
        #10;
        dv = 0;
        #10;
         ps2_data_in ={1'b1,1'b1,8'h6b,1'b1}; // F0 break code
        dv = 1;
        #10;
        dv = 0;
        
        #100;
        $finish;
    end
    
    // Monitor to display changes
    initial begin
        $monitor("Time = %t, ps2_data_in = %b, scan_code = %h, is_extended = %b, is_break = %b, dv_dec = %b",
                 $time, ps2_data_in, scan_code, is_extended, is_break, dv_dec);
    end
endmodule