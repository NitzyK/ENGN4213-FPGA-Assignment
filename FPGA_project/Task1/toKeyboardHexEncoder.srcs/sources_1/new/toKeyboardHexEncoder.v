`timescale 1ns / 1ps

module toKeyboardHexEncoder(

input wire [2:0] bcd,
output reg [6:0] keyboardHex
    );
    

always @(*) begin
		case(bcd)
			3'd1 : keyboardHex = 8'h16;
			3'd2 : keyboardHex = 8'h1E;
			3'd3 : keyboardHex = 8'h26;
			3'd4 : keyboardHex = 8'h25;
			3'd5 : keyboardHex = 8'h2E;

			default : keyboardHex = 8'h45; //default to 0
		endcase
end

endmodule

