`timescale 1ns / 1ps

module tb_clockDividerHB();

    // Parameters
    parameter CLK_PERIOD = 10;       // 100 MHz clock (10ns period)
    parameter TEST_THRESHOLD = 10;   // Smaller threshold for faster simulation
    parameter SIM_TIME = 1000;       // Simulation time in ns

    // Signals
    reg clk;
    reg enable;
    reg reset;
    wire dividedClk;
    wire beat;

    // Instantiate DUT
    clockDividerHB #(
        .THRESHOLD(TEST_THRESHOLD)
    ) dut (
        .clk(clk),
        .enable(enable),
        .reset(reset),
        .dividedClk(dividedClk),
        .beat(beat)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // Test stimulus
    initial begin
        // Initialize inputs
        enable = 0;
        reset = 1;
        
        // Reset phase
        #20 reset = 0;
        
        // Test 1: Check basic operation with enable
        enable = 1;
        #200;
        
        // Test 2: Check disable functionality
        enable = 0;
        #100;
        
        // Test 3: Re-enable and check operation
        enable = 1;
        #200;
        
        // Test 4: Reset during operation
        reset = 1;
        #20;
        reset = 0;
        #200;
        
        $finish;
    end

    // Monitoring
    initial begin
        $monitor("Time = %0t ns: clk=%b, enable=%b, reset=%b, dividedClk=%b, beat=%b, counter=%0d",
                 $time, clk, enable, reset, dividedClk, beat, dut.counter);
    end

    // VCD dump for waveform viewing
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_clockDividerHB);
    end

endmodule