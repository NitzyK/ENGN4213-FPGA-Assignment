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


module RX_TOP(
input wire clk,
output wire ready,
input wire tx_out,
output wire [7:0] led
    );
    
wire beat;
wire reset = 0;
wire enable = 1;

clockDividerHB2 #(.THRESHOLD(10416), .ON_TIME(100)) baud_gen (
    .clk(clk),
    .reset(1'b0),
    .enable(1'b1),
    .dividedClk(),
    .beat(beat)
);


  
uart_rx rx_inst (
.clk(clk),
.beat(beat),                 // From clockDividerHB2
.rx(tx_out),
.data_out(led),
.data_ready(ready),
.reset(1'b0)
);


    
    
endmodule
