`timescale 1ns / 1ps

module toPS2(
    input wire [5:0] coordinates,
    output reg [15:0] PS2coordinates
);
////////////////////////////////Overview//////////////////////////////////////////////

// this module converts a m,n (in binary) into PS2 format for display

wire [2:0] m,n;

assign m = coordinates[5:3];
assign n = coordinates[2:0];
    
always @(*) begin
		case(m)
			3'd1 : PS2coordinates[15:8] = 8'h16; // 1
			3'd2 : PS2coordinates[15:8] = 8'h1E; // 2
			3'd3 : PS2coordinates[15:8] = 8'h26; // 3
			3'd4 : PS2coordinates[15:8] = 8'h25; // 4
			3'd5 : PS2coordinates[15:8] = 8'h2E; // 5
			default : PS2coordinates[15:8] = 8'h00; 
		endcase
end

always @(*) begin
		case(n)
			3'd1 : PS2coordinates[7:0] = 8'h16; // 1
			3'd2 : PS2coordinates[7:0] = 8'h1E; // 2
			3'd3 : PS2coordinates[7:0] = 8'h26; // 3
			3'd4 : PS2coordinates[7:0] = 8'h25; // 4
			3'd5 : PS2coordinates[7:0] = 8'h2E; // 5
			default : PS2coordinates[7:0] = 8'h00;
		endcase
end



endmodule