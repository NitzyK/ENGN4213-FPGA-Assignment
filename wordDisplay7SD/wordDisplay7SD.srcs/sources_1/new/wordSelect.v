`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2025 00:14:42
// Design Name: 
// Module Name: wordSelect
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


module wordSelect(

input wire [3:0] displayWord,
output reg [31:0] whatWord

    );
    
    
wire [7:0] word1 = 32'h1C344D2B;
wire [7:0] word2 = 32'hFF242D1C; 
wire [7:0] word3 = 32'hFF44442C;
wire [7:0] word4 = 32'h232D1C33;
wire [7:0] word5 = 32'h4D4B2433;
wire [7:0] word6 = 32'hFF1B4B4D;

always @(*) begin
    case(displayWord)
        3'd0: whatWord = word1;
        3'd1: whatWord = word2;
        3'd2: whatWord = word3;
        3'd3: whatWord = word4;
        3'd4: whatWord = word5;
        3'd5: whatWord = word6;
        
        default: whatWord = 32'hAAAAAAAA;
        endcase
        
    end
  
endmodule


