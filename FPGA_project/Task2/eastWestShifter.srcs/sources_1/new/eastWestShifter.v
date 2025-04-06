`timescale 1ns / 1ps

module eastWestShifter(
input wire clk,
input wire reset,
input wire btn_E,
input wire btn_W,
output reg [3:0] index
    );

always @(posedge clk) begin
    if (reset) index <= 4'b0;
    else if (btn_E && index != 4'd15) index <= index + 1;
    else if (btn_W && index != 4'd0) index <= index - 1;
    else index <= 4'd0;
end
    
endmodule
