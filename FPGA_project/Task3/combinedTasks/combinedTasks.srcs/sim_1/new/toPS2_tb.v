`timescale 1ns / 1ps

module tb_toPS2();
    // Inputs
    reg [5:0] coordinates;
    
    // Outputs
    wire [15:0] PS2coordinates;
    
    // Instantiate the Unit Under Test (UUT)
    toPS2 uut (
        .coordinates(coordinates),
        .PS2coordinates(PS2coordinates)
    );
    
    // Test vectors
    initial begin
        // Initialize inputs
        coordinates = 6'b000000;
        
        // Display header
        $display("Time\tm\tn\tPS2coordinates");
        $display("----------------------------------");
        
        // Wait for global reset
        #10;
        
        // Test case 1: m=1, n=1
        coordinates = 6'b001001;
        #10;
        $display("%0t\t%0d\t%0d\t0x%h", $time, coordinates[5:3], coordinates[2:0], PS2coordinates);
        
        // Test case 2: m=2, n=3
        coordinates = 6'b010011;
        #10;
        $display("%0t\t%0d\t%0d\t0x%h", $time, coordinates[5:3], coordinates[2:0], PS2coordinates);
        
        // Test case 3: m=3, n=4
        coordinates = 6'b011100;
        #10;
        $display("%0t\t%0d\t%0d\t0x%h", $time, coordinates[5:3], coordinates[2:0], PS2coordinates);
        
        // Test case 4: m=4, n=5
        coordinates = 6'b100101;
        #10;
        $display("%0t\t%0d\t%0d\t0x%h", $time, coordinates[5:3], coordinates[2:0], PS2coordinates);
        
        // Test case 5: m=5, n=2
        coordinates = 6'b101010;
        #10;
        $display("%0t\t%0d\t%0d\t0x%h", $time, coordinates[5:3], coordinates[2:0], PS2coordinates);
        
        // Test case 6: Invalid m (0), valid n (3)
        coordinates = 6'b000011;
        #10;
        $display("%0t\t%0d\t%0d\t0x%h", $time, coordinates[5:3], coordinates[2:0], PS2coordinates);
        
        // Test case 7: Valid m (5), invalid n (0)
        coordinates = 6'b101000;
        #10;
        $display("%0t\t%0d\t%0d\t0x%h", $time, coordinates[5:3], coordinates[2:0], PS2coordinates);
        
        // Test case 8: Invalid m (6), invalid n (6)
        coordinates = 6'b110110;
        #10;
        $display("%0t\t%0d\t%0d\t0x%h", $time, coordinates[5:3], coordinates[2:0], PS2coordinates);
        
        // End simulation
        #10;
        $finish;
    end
    
    // Optional: Add waveform generation
    initial begin
        $dumpfile("tb_toPS2.vcd");
        $dumpvars(0, tb_toPS2);
    end
endmodule