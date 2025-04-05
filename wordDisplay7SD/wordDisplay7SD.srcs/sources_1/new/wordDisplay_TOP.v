`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2025 23:44:12
// Design Name: 
// Module Name: wordDisplay_TOP
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


module wordDisplay_TOP(

input wire PS2_clk,
input wire PS2_data,
input wire clk,
input wire btn_E,
input wire btn_W,

output wire hi
    );

debouncer debounce_inst_E(
.clk(clk),
.reset(1'b0),
.switchIn(btn_E),
.debounceout(btn_E_deb)
);
debouncer debounce_inst_W(
.clk(clk),
.reset(1'b0),
.switchIn(btn_W),
.debounceout(btn_W_deb));

spot spot_inst_E (
.clk(clk),
.spot_in(btn_E_deb),
.spot_out(btn_E_spot)
);
spot spot_inst_W(
.clk(clk),
.spot_in(btn_W_deb),
.spot_out(btn_W_spot)
);



endmodule



