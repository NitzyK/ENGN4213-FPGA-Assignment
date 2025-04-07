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
input wire SW,
output wire [6:0] ssdAnode,
output wire [3:0] ssdCathode,
output  wire [3:0] displayWord,
output reg SW_led
//output    wire left_key_spot,
// output   wire right_key_spot
    );
    
    reg [3:0] wordCount;
    reg [31:0] whatWord;
    wire [10:0] PS2_data_out;
    wire [7:0] PS2_data_out_conc;
    wire left_key;
    wire right_key;
    
    assign PS2_data_out_conc = PS2_data_out[8:1];
    assign left_key = ( PS2_data_out_conc == 8'h6B);
    assign right_key = ( PS2_data_out_conc == 8'h74);

    
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

//debouncer debounce_inst_R(
//.clk(clk),
//.reset(1'b0),
//.switchIn(right_key),
//.debounceout(right_key_deb)
//);
//debouncer debounce_inst_L(
//.clk(clk),
//.reset(1'b0),
//.switchIn(left_key),
//.debounceout(left_key_deb));

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

spot spot_inst_L (
.clk(clk),
.spot_in(left_key),
.spot_out(left_key_spot)
);
spot spot_inst_R(
.clk(clk),
.spot_in(right_key),
.spot_out(right_key_spot)
);

clockDividerHB #(.THRESHOLD(50_000_000)) oneSecClk(
.clk(clk),
.enable(SW),
.reset(1'b0),
.dividedClk() ,
.beat(beat)
);


   
always @(posedge clk) begin 
 
 if(btn_E_spot || right_key_spot) wordCount <= wordCount +1;
 else if(btn_W_spot || left_key_spot) wordCount <= wordCount -1;
     
  if(beat) begin 
  wordCount <= wordCount +1;
  SW_led = ~SW_led;
  end
  
  
 

 
 end



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

PS2_data_capture signaldecoder(
.clk(clk),
.PS2_data_in(PS2_data),
.PS2_clk(PS2_clk),
.PS2_data_out(PS2_data_out)

);


endmodule



