`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.03.2025 14:14:54
// Design Name: 
// Module Name: clockDividerHB
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


module clockDividerHB #(parameter integer THRESHOLD = 3_333_333)(
input wire clk,
input wire enable,
input wire reset,
output reg dividedClk ,
output wire beat
    );
    
    reg [31:0] counter;
    
    always @(posedge clk) begin
        if (reset==1'b1 || counter >= THRESHOLD-1) begin
            counter <= 32'd0;
        end else if (enable == 1'b1) begin
            counter <= counter + 1'b1;
        end
    end
    
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            dividedClk <= 1'b0;
        end else if (counter >= THRESHOLD-1) begin
            dividedClk <= ~dividedClk;
        end
    end
    
    assign beat=(counter==THRESHOLD-1)&(dividedClk);
endmodule
