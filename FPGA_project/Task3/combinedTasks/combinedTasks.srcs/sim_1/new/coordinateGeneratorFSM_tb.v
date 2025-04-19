`timescale 1ns / 1ps

// Testbench for coordinateGeneratorFSM
module coordinateGeneratorFSM_tb();

    // Inputs
    reg clk;
    reg tap;
    reg reset;
    
    // Outputs
    wire [5:0] coordinates;
    wire [2:0] stateLED;
    wire error;
    
    // Clock period definition
    parameter CLK_PERIOD = 10; // 10ns = 100MHz  
    
    // Instantiate the Unit Under Test (UUT)
    coordinateGeneratorFSM uut (
        .clk(clk),
        .tap(tap),
        .reset(reset),
        .coordinates(coordinates),
        .stateLED(stateLED),
        .error(error)
    );
    
    // Abbreviated beat signal for testing
    // We'll use this instead of waiting for the actual beat from the clockDividerHB
    reg test_beat;
    integer beat_count = 0;
    
    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end
    
    // Task to simulate a tap
    task do_tap;
        begin
            tap = 1;
            #(CLK_PERIOD);
            tap = 0;
            #(CLK_PERIOD);
        end
    endtask
    
    // Task to print current state
    task print_state;
        input [2:0] state_val;
        begin
            case(state_val)
                3'b001: $display("Current state: IDLE");
                3'b010: $display("Current state: N_SET");
                3'b011: $display("Current state: M_SET");
                3'b100: $display("Current state: DISPLAY");
                3'b101: $display("Current state: ERROR");
                default: $display("Current state: UNKNOWN");
            endcase
        end
    endtask
    
    // Test sequence
    initial begin
        // Initialize inputs
        tap = 0;
        reset = 0;
        test_beat = 0;
        
        // Apply reset
        #100;
        $display("Applying reset...");
        reset = 1;
        #(CLK_PERIOD*2);
        reset = 0;
        #(CLK_PERIOD*5);
        
        // Wait for global reset
        #100;
        
        // Test Case 1: Set n=2, m=3
        $display("================ Test Case 1: Set n=2, m=3 ================");
        
        // Initial tap to go from IDLE to N_SET
        $display("Tapping to move from IDLE to N_SET");
        do_tap();
        #(CLK_PERIOD*5);
        print_state(stateLED);
       // $display("Current n value: %d", n);
        
        // Tap once more in N_SET to set n=2
        $display("Tapping once more to make n=2");
        do_tap();
        #(CLK_PERIOD*5);
       // $display("Current n value: %d", n);
        
        // Wait for the counter1 to reach 2 to advance to M_SET (simulate beat)
        $display("Waiting for transition to M_SET...");
        // Simulate 3 beats
        repeat (3) begin
            test_beat = 1;
            #(CLK_PERIOD);
            test_beat = 0;
            #(CLK_PERIOD*1000); // Long enough between beats
        end
        
        #(CLK_PERIOD*5);
        print_state(stateLED);
       // $display("Current m value: %d", m);
        
        // Tap 3 times in M_SET to set m=3
        $display("Tapping 3 times to make m=3");
        repeat (3) begin
            do_tap();
            #(CLK_PERIOD*5);
        end
      //  $display("Current m value: %d", m);
        
        // Wait for the counter2 to reach 2 to advance to DISPLAY
        $display("Waiting for transition to DISPLAY...");
        // Simulate 3 more beats
        repeat (3) begin
            test_beat = 1;
            #(CLK_PERIOD);
            test_beat = 0;
            #(CLK_PERIOD*1000);
        end
        
        #(CLK_PERIOD*5);
        print_state(stateLED);
       // $display("Final n = %d, m = %d", n, m);
        
        // Test Case 2: Check error condition (n > 5)
        $display("\n================ Test Case 2: Test error condition ================");
        
        // Tap to go back to N_SET
        $display("Tapping to move from DISPLAY to N_SET");
        do_tap();
        #(CLK_PERIOD*5);
        print_state(stateLED);
        
        // Tap 6 times to exceed n=5 limit
        $display("Tapping 6 times to trigger error condition");
        repeat (6) begin
            do_tap();
            #(CLK_PERIOD*5);
        end
        
        // Check if error is raised
        $display("Error flag: %b", error);
        print_state(stateLED);
        
        // Reset to clear error
        $display("\nApplying reset to clear error...");
        reset = 1;
        #(CLK_PERIOD*2);
        reset = 0;
        #(CLK_PERIOD*5);
        print_state(stateLED);
        
        // Test Case 3: Set n=4, m=1
        $display("\n================ Test Case 3: Set n=4, m=1 ================");
        
        // Initial tap to go from IDLE to N_SET
        $display("Tapping to move from IDLE to N_SET");
        do_tap();
        #(CLK_PERIOD*5);
        
        // Tap 3 more times in N_SET to set n=4
        $display("Tapping 3 more times to make n=4");
        repeat (3) begin
            do_tap();
            #(CLK_PERIOD*5);
        end
       // $display("Current n value: %d", n);
        
        // Wait for transition to M_SET
        $display("Waiting for transition to M_SET...");
        repeat (3) begin
            test_beat = 1;
            #(CLK_PERIOD);
            test_beat = 0;
            #(CLK_PERIOD*1000);
        end
        
        #(CLK_PERIOD*5);
        print_state(stateLED);
        
        // Tap once in M_SET to set m=1
        $display("Tapping once to make m=1");
        do_tap();
        #(CLK_PERIOD*5);
        //$display("Current m value: %d", m);
        
        // Wait for transition to DISPLAY
        $display("Waiting for transition to DISPLAY...");
        repeat (3) begin
            test_beat = 1;
            #(CLK_PERIOD);
            test_beat = 0;
            #(CLK_PERIOD*1000);
        end
        
        #(CLK_PERIOD*5);
        print_state(stateLED);
      //  $display("Final n = %d, m = %d", n, m);
        
        // End simulation
        #100;
        $display("Simulation completed successfully!");
        $finish;
    end
    
    // Monitor state changes
    always @(stateLED) begin
        case(stateLED)
            3'b001: $display("State changed to: IDLE");
            3'b010: $display("State changed to: N_SET");
            3'b011: $display("State changed to: M_SET");
            3'b100: $display("State changed to: DISPLAY");
            3'b101: $display("State changed to: ERROR");
            default: $display("State changed to: UNKNOWN");
        endcase
    end
    
    // Monitor for the beat (for debugging)
    reg beat_monitor;
    always @(posedge clk) begin
        beat_monitor <= uut.beat;
        if (beat_monitor == 1'b0 && uut.beat == 1'b1) begin
            $display("Beat detected at time %0t", $time);
        end
    end

endmodule