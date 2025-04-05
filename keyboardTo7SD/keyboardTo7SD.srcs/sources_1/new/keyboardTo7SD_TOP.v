`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2025 19:13:33
// Design Name: 
// Module Name: keyboardTo7SD_TOP
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
//////////////////////////////////////////////////////////////////////////////////


module keyboardTo7SD_TOP(
    input wire clk,
    input wire PS2_data_in,
    input wire PS2_clk,
    
    output wire [6:0] ssdAnode, 
    output wire [3:0] ssdCathode,
    output wire [7:0] led
    );
    wire [10:0] PS2_data_out;

PS2_data_capture signaldecoder(
.clk(clk),
.PS2_data_in(PS2_data_in),
.PS2_clk(PS2_clk),
.PS2_data_out(PS2_data_out)

);

 assign led = PS2_data_out[8:1];


displayDriver displayDriver_inst (

.clk(clk),
.ssdAnode(ssdAnode), 
.ssdCathode(ssdCathode),
.displayValues(PS2_data_out[8:1])
);

endmodule

