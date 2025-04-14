`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2025 14:31:21
// Design Name: 
// Module Name: uart_tx_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////`timescale 1ns / 1ps

module uart_tx_tb;

    // Parameters
    localparam BAUD_DIVIDER =  10416; // Faster for simulation
    
    // Inputs
    reg clk;
    reg reset;
    reg [7:0] data_in;
    reg send;

    // Outputs
    wire tx;
    wire busy;

    // Clock generation: 50MHz clock (20ns period)
    always #5 clk = ~clk;

    // Instantiate the Unit Under Test (UUT)
    uart_tx #(.BAUD_DIVIDER(BAUD_DIVIDER)) uut (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .send(send),
        .tx(tx),
        .busy(busy)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;
        data_in = 8'b0;
        send = 0;

        // Wait for global reset
        #50;
        reset = 0;

        // Send byte 0xA5
        data_in = 8'hA5;
        send = 1;
        #50; // keep send high briefly
        send = 0;

        // Wait long enough for entire transmission
        #200;
        
        reset = 0;
        data_in = 8'hAF;
                send = 1;
        #50; // keep send high briefly
        send = 0;
       #2000;
        

        // Finish simulation
        $finish;
    end

    // Optional: monitor tx line
    initial begin
        $monitor("Time: %t | tx: %b", $time, tx);
    end

endmodule

