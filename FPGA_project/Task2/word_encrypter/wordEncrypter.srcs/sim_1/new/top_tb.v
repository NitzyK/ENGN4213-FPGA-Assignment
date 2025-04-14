`timescale 1ns / 1ps

module Encrypter_top_tb;

    // Inputs
    reg clk;
    reg reset;
    reg view;
    reg encrypt;
    reg btn_E;
    reg btn_W;
    reg encrypterSelector;

    // Outputs
    wire [6:0] ssdAnode;
    wire [3:0] ssdCathode;
    wire [3:0] index;
    wire [31:0] displayValues;

    // Instantiate the Unit Under Test (UUT)
    Encrypter_top uut (
        .clk(clk),
        .reset(reset),
        .view(view),
        .encrypt(encrypt),
        .btn_E(btn_E),
        .btn_W(btn_W),
        .encrypterSelector(encrypterSelector),
        .ssdAnode(ssdAnode),
        .ssdCathode(ssdCathode),
        .index(index),
        .displayValues(displayValues)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 100MHz clock (10ns period)
    end

    // Stimulus
    initial begin
        // Initialize inputs
        reset = 1;
        view = 0;
        encrypt = 0;
        btn_E = 0;
        btn_W = 0;
        encrypterSelector = 0;

        // Hold reset
        #20;
        reset = 0;

        // Wait a bit
        #50;

        // Test encrypting using selector 0
        encrypterSelector = 0;
        encrypt = 1;
        view = 1;
        #20;

        encrypt = 0;
        #40;

        // Toggle through indices using btn_E
        btn_E = 1;
        #10;
        btn_E = 0;
        #50;

        btn_E = 1;
        #10;
        btn_E = 0;
        #50;

        btn_E = 1;
        #10;
        btn_E = 0;
        #50;

        // Switch direction
        btn_W = 1;
        #10;
        btn_W = 0;
        #50;

        // Flip encryption selector and test
        encrypterSelector = 1;
        encrypt = 1;
        #20;
        encrypt = 0;
        #40;

        // Check different display states
        view = 0;
        #20;
        view = 1;
        #20;

        // End simulation
        $stop;
    end

endmodule
