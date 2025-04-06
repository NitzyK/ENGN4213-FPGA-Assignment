`timescale 1ns / 1ps

module eastWestShifter_tb();
    // Inputs
    reg clk;
    reg reset;
    reg btn_E;
    reg btn_W;
    
    // Outputs
    wire [3:0] index;
    
    // Instantiate the Unit Under Test (UUT)
    eastWestShifter uut (
        .clk(clk),
        .reset(reset),
        .btn_E(btn_E),
        .btn_W(btn_W),
        .index(index)
    );
    
    // Clock generation - using a non-blocking approach
    always #5 clk = ~clk;
    
    // Test sequence
    initial begin
        // Initialize inputs
        reset = 1;
        btn_E = 0;
        btn_W = 0;
        reset = 0;
        
        // Wait for global reset
        #20;
        reset = 0;
        
        // Test case 1: Press East button, index should increment
        #10 btn_E = 1;
        $display (index);
        #10 btn_E = 0;
        $display (index);
        #10 btn_E = 1;
        $display (index);
        #10 btn_E = 0;
        $display (index);
        #10 btn_E = 1;
        $display (index);
        #10 btn_E = 0;
        
        $display (index);
        
        // Test case 2: Press West button, index should decrement
        #10 btn_W = 1;
        #10 btn_W = 0;
        #10 btn_W = 1;
        #10 btn_W = 0;
        
        $display (index);
        
        // Test case 3: Test reset
        #10 reset = 1;
        #10 reset = 0;
        
        // Test case 4: Test East button again after reset
        #10 btn_E = 1;
        #10 btn_E = 0;
        
        // Test case 5: Test conflicting East and West buttons (East has priority)
        #10 btn_E = 1; btn_W = 1;
        #10 btn_E = 0; btn_W = 0;
        
        // Test case 6: Neither button pressed, should reset to 0
        #10;
        
        // End simulation
        #20 $finish;
    end
    
    // Monitor changes
    initial begin
        $monitor("Time: %t, reset = %b, btn_E = %b, btn_W = %b, index = %b (%d)", 
                 $time, reset, btn_E, btn_W, index, index);
    end
    
endmodule