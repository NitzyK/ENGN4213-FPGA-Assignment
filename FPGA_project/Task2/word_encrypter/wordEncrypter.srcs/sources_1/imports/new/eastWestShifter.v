`timescale 1ns / 1ps

module eastWestShifter #(parameter max_index = 4'd15)(
input wire clk,
input wire reset,
input wire btn_E,
input wire btn_W,
output reg [3:0] index = 4'b0
    );

always @(posedge clk) begin
    if (reset) index <= 4'b0;
    else if (index > max_index) index <= max_index;
    else if (btn_E) index <= index + 4'b1;
    else if (btn_W & index > 4'd0) index <= index - 4'b1;
    
end
    
endmodule
