`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.04.2025 11:00:41
// Design Name: 
// Module Name: TX_TOP
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


module TX_TOP(
input wire clk,
input wire send,
output wire tx_out,
output wire busy
    );
    
wire beat;
wire dividedClk;  // Optional, can be ignored
wire reset = 0;
wire enable = 1;

clockDividerHB #(.THRESHOLD(10416)) baud_gen (
    .clk(clk),
    .reset(1'b0),
    .enable(send),
    .dividedClk(),
    .beat(beat)
);


spot spot_inst(
.clk(clk),
.spot_in(send),
.spot_out(send_spot)
);
  
uart_tx tx_inst (
.clk(clk),
.beat(beat),                 // From clockDividerHB2
.data_in(8'hAF),
.send(send_spot),
.tx(tx_out),
.busy(busy)
);


    
    
endmodule
