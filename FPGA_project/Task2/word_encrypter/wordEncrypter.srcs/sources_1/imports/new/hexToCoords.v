`timescale 1ns / 1ps


module hexToCoords(
    input wire [7:0] letter,    
    output reg [2:0] m_coords,
    output reg [2:0] n_coords
);

reg [5:0] coords;

always @(*) begin
		case(letter)
			8'h1C : coords = 6'b001001; //A
			8'h32 : coords = 6'b001010; //b
			8'h21 : coords = 6'b001011; //C
			8'h23 : coords = 6'b001100; //d
			8'h24 : coords = 6'b001101; //E
			
			8'h2B : coords = 6'b010001; //F
			8'h34 : coords = 6'b010010; //G
			8'h33 : coords = 6'b010011; //H
			8'h43 : coords = 6'b010100; //I
			8'h00 : coords = 6'b010101; //x (k)
			
			8'h4B : coords = 6'b011001; //L
			8'h00 : coords = 6'b011010; //x (m)
			8'h31 : coords = 6'b011011; //n
			8'h44 : coords = 6'b011100; //O
			8'h4D : coords = 6'b011101; //P
			
			8'h00 : coords = 6'b100001; //x (q)
			8'h2D : coords = 6'b100010; //r
			8'h1B : coords = 6'b100011; //S
			8'h2C : coords = 6'b100100; //t
			8'h3C : coords = 6'b100101; //U
			
			8'h00 : coords = 6'b101001; //x (v)
			8'h00 : coords = 6'b101010; //x (w)
			8'h00 : coords = 6'b101011; //x (x)
			8'h00 : coords = 6'b101100; //x (y)
			8'h00 : coords = 6'b101101; //x (z)
			

			default : coords = 6'b000000; //default to 0,0
		endcase
		m_coords = coords[5:3];
		n_coords = coords[2:0];

end
endmodule
