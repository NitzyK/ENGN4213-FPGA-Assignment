`timescale 1ns / 1ps

module ssdDecoder(
    input [7:0] hex_value,  
    output reg [6:0] ssd     
);
////////////////////////////////Overview//////////////////////////////////////////////
// this module converts PS2 Hex values into the SSD values for displaying


////////////////////////////////// Decoder ////////////////////////////////////////
    always @(*) begin
        case(hex_value)
            // Numbers 1-5 
            8'h16: ssd = 7'b1001111; // 1
            8'h1E: ssd = 7'b0010010; // 2
            8'h26: ssd = 7'b0000110; // 3
            8'h25: ssd = 7'b1001100; // 4
            8'h2E: ssd = 7'b0100100; // 5
            
            // Vowels (A,E,I,O,U)
            8'h1C: ssd = 7'b0001000; // A
            8'h24: ssd = 7'b0110000; // E
            8'h43: ssd = 7'b1111001; // I
            8'h44: ssd = 7'b0000001; // O
            8'h3C: ssd = 7'b1000001; // U
            
            // Consonants (b,C,d,F,G,H,L,n,P,r,S,t)
            8'h32: ssd = 7'b1100000; // b
            8'h21: ssd = 7'b0110001; // C
            8'h23: ssd = 7'b1000010; // d
            8'h2B: ssd = 7'b0111000; // F
            8'h34: ssd = 7'b0100001; // G
            8'h33: ssd = 7'b1001000; // H
            8'h4B: ssd = 7'b1110001; // L
            8'h31: ssd = 7'b1101010; // n
            8'h4D: ssd = 7'b0011000; // p
            8'h2D: ssd = 7'b1111010; // r
            8'h1B: ssd = 7'b0100100; // S
            8'h2C: ssd = 7'b1110000; // t
            
            default: ssd = 7'b1111111; // All segments off for unrecognized codes
        endcase
    end


endmodule