`timescale 1ns / 1ps

module eastWestShifter #(parameter max_index = 4'd15)(
input wire clk, reset, btnE,btnW, enable,
output reg [3:0] index = 4'b0
);

/////////////////////////////Overview////////////////////////////////////////////////
// this module creates an index which starts at 0, and pressing the east and west buttons increment the
// index between 0 and max_index. 

always @(posedge clk) begin
    if (reset) index <= 4'b0;
    
    else if (enable == 1) begin
        if (index > max_index) index <= max_index;
        else if (btnE) index <= index + 4'b1;
        else if (btnW & index > 4'd0) index <= index - 4'b1;
    end
    
end
    
endmodule
