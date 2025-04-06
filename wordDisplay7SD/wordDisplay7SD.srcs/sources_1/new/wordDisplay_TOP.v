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
input wire SW,
output wire [6:0] ssdAnode,
output wire [3:0] ssdCathode,
output wire [3:0] displayWord
    );
    
    reg [3:0] wordCount;
    reg [31:0] whatWord;
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

clockDividerHB #(.THRESHOLD(3_333_333)) oneSecClk(
.clk(),
.enable(SW),
.reset(1'b0),
.dividedClk() ,
.beat(beat)
);

always @(posedge clk) begin 
 
 if(btn_E_spot) wordCount <= wordCount +1;
 else if(btn_W_spot) wordCount <= wordCount -1;
     if(btn_E_spot) wordCount <= wordCount +1;
     else if(btn_W_spot) wordCount <= wordCount -1;
     
 end
 
 always @(posedge beat) begin
     if(wordCount != 6'd3) wordCount <= wordCount +1;
     else wordCount <= 4'd0;
 
 end



//wire [7:0] word2 = 32'hFF242D1C; 
//wire [7:0] word3 = 32'hFF44442C;
//wire [7:0] word4 = 32'h232D1C33;
//wire [7:0] word5 = 32'h4D4B2433;
//wire [7:0] word6 = 32'hFF1B4B4D;

assign displayWord = wordCount;

always @(*) begin
    case(displayWord)
        3'd0: whatWord = 32'h1C344D2B;
        3'd1: whatWord = 32'hFF242D1C;
        3'd2: whatWord = 32'hFF44442C;
        3'd3: whatWord = 32'h232D1C33;
        3'd4: whatWord = 32'h4D4B2433;
        3'd5: whatWord = 32'hFF1B4B4D;
        
        default: whatWord = 32'hFFFFFFFF;
        endcase
        
    end
    
displayDriver seven_seg_inst(
.clk(clk),
.displayValues(whatWord),
.ssdAnode(ssdAnode),
.ssdCathode(ssdCathode)
);



endmodule



