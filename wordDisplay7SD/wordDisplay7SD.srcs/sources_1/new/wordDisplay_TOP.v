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

//input wire PS2_clk,
//input wire PS2_data,
input wire clk,
input wire btn_E,
input wire btn_W,
output wire [6:0] ssdAnode,
output wire [3:0] ssdCathode
    );
    
    reg [3:0] wordCount;
    wire [31:0] whatWord;
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

always @(posedge clk) begin 

if(btn_E_spot) wordCount <= wordCount +1;
else if(btn_W_spot) wordCount <= wordCount -1;

end

wordSelect wordSelect_inst (
.displayWord(wordCount),
.whatWord(whatWord)
);

displayDriver seven_seg_inst(
.clk(clk),
.displayValues(whatWord),
.ssdAnode(ssdAnode),
.ssdCathode(ssdCathode)
);



endmodule



