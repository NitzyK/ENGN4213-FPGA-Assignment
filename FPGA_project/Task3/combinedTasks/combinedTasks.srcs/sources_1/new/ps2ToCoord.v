`timescale 1ns / 1ps

module ps2ToCoord(
    input wire [7:0] letter,    
    output reg [2:0] m,
    output reg [2:0] n,
    output reg [5:0] coordinates
);

/////////////////////////////Overview////////////////////////////////////////////////
// this module takes in a PS2 letter and retrives the corresponding (m,n) coordinates

////////////////////////////////Internal Signal Declaration//////////////////////////

///////////////////////////////Decoder//////////////////////////////////////////////
always @(*) begin
		case(letter)
			8'h1C : coordinates = 6'b001001; //A
			8'h32 : coordinates = 6'b001010; //b
			8'h21 : coordinates = 6'b001011; //C
			8'h23 : coordinates = 6'b001100; //d
			8'h24 : coordinates = 6'b001101; //E
			
			8'h2B : coordinates = 6'b010001; //F
			8'h34 : coordinates = 6'b010010; //G
			8'h33 : coordinates = 6'b010011; //H
			8'h43 : coordinates = 6'b010100; //I
			8'h42 : coordinates = 6'b010101; //x (k)
			
			8'h4B : coordinates = 6'b011001; //L
			8'h3A : coordinates = 6'b011010; //x (m)
			8'h31 : coordinates = 6'b011011; //n
			8'h44 : coordinates = 6'b011100; //O
			8'h4D : coordinates = 6'b011101; //P
			
			8'h15 : coordinates = 6'b100001; //x (q)
			8'h2D : coordinates = 6'b100010; //r
			8'h1B : coordinates = 6'b100011; //S
			8'h2C : coordinates = 6'b100100; //t
			8'h3C : coordinates = 6'b100101; //U
			
			8'h2A : coordinates = 6'b101001; //x (v)
			8'h1D : coordinates = 6'b101010; //x (w)
			8'h22 : coordinates = 6'b101011; //x (x)
			8'h35 : coordinates = 6'b101100; //x (y)
			8'h1Z : coordinates = 6'b101101; //x (z)
			

			default : coordinates = 6'b000000; //default to 0,0
		endcase
end

endmodule
