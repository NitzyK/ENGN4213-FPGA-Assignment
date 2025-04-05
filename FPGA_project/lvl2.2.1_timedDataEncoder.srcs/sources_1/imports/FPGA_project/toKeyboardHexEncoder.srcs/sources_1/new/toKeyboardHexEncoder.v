`timescale 1ns / 1ps

module toKeyboardHexEncoder(

input wire [2:0] bcd,
output reg [7:0] keyboardHex
    );
    

always @(*) begin
		case(bcd)
			3'b001 : keyboardHex = 8'h16; //1
			3'b010 : keyboardHex = 8'h1E; //2
			3'b011 : keyboardHex = 8'h26; //3
			3'b100 : keyboardHex = 8'h25; //4
			3'b101 : keyboardHex = 8'h2E; //5

			default : keyboardHex = 8'h45; //default to 0
		endcase
end

endmodule

