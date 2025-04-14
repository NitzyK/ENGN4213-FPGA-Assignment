`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2025 11:21:46
// Design Name: 
// Module Name: keyboardEncrypt_TOP
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


module keyboardEncrypt_TOP(
input wire clk,
input wire ps2_data,
input wire ps2_clk,
output wire [6:0] ssdAnode,
output wire[3:0]  ssdCathode
    );
    wire [10:0] ps2_data_out;
    wire [7:0] ps2_scancode;
    wire [31:0] currentWord;
    
    
    PS2_data_capture ps2_inst (
    .clk(clk),
    .PS2_data_in(ps2_data),
    .PS2_clk(ps2_clk),
    .PS2_data_out(ps2_data_out),
    .dv(dv)
    );
    
    ps2_decoder ps2_decode(
    .clk(clk),
    .dv(dv),
    .ps2_data_in(ps2_data_out),
    .is_extended(ext_flag),
    .is_break(break_flag),
    .dv_dec(dv_dec),
    .scan_code(ps2_scancode)
    );
    
    
    wordType word_inst (
    .clk(clk),
    .dv_dec(dv_dec),
    .reset(1'b0),
    .enable(1'b1),
    .ps2_scancode(ps2_scancode),
    .extended_flag(ext_flag),
    .break_flag(break_flag),
    .currentWord(currentWord)
    );
    
    
    displayDriver ssd_driver_inst(
    .clk(clk),
    .displayValues(currentWord),
    .ssdAnode(ssdAnode),
    .ssdCathode(ssdCathode)
    
    );
    
    
endmodule
