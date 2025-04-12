`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2025 17:52:58
// Design Name: 
// Module Name: TOP
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


module TOP(
   input       clk,
   input data_valid,
   output serial,
   output data_ready,
   output active
    );
    
    
 debouncer inst_deb(
 .clk(clk),
 .switchIn(data_valid),
 .reset(1'b0),
 .debounceout(data_valid_deb)
 );
 
 
 uart_tx uart_inst(
 .i_Clock(clk),
 .i_Tx_DV(data_valid_deb),
 .o_Tx_Done(data_ready),
 .o_Tx_Serial(serial),
 .o_Tx_Active(active)
 );
    
endmodule
