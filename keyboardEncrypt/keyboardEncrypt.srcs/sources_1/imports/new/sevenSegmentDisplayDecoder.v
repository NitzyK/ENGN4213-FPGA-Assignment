module sevenSegmentDisplayDecoder(
    input wire [7:0] hex_value,  
    output reg [6:0] ssd     
);

    always @(*) begin
        case(hex_value)
            // Numbers 1-5 
            8'h16: ssd = 7'b1001111; // '1' - segments b,c on
            8'h1E: ssd = 7'b0010010; // '2' - segments a,b,d,e,g on
            8'h26: ssd = 7'b0000110; // '3' - segments a,b,c,d,g on
            8'h25: ssd = 7'b1001100; // '4' - segments b,c,f,g on
            8'h2E: ssd = 7'b0100100; // '5' - segments a,c,d,f,g on
            
            // Vowels (A,E,I,O,U)
            8'h1C: ssd = 7'b0001000; // 'A' - segments a,b,c,e,f,g on
            8'h24: ssd = 7'b0110000; // 'E' - segments a,d,e,f,g on
            8'h43: ssd = 7'b1111001; // 'I' - segments b,c on (similar to '1')
            8'h44: ssd = 7'b0000001; // 'O' - segments a,b,c,d,e,f on (similar to '0')
            8'h3C: ssd = 7'b1000001; // 'U' - segments b,c,d,e,f on
            
            // Consonants (b,C,d,F,G,H,L,n,P,r,S,t)
            8'h32: ssd = 7'b1100000; // 'b' - segments c,d,e,f,g on
            8'h21: ssd = 7'b0110001; // 'C' - segments a,d,e,f on
            8'h23: ssd = 7'b1000010; // 'd' - segments b,c,d,e,g on
            8'h2B: ssd = 7'b0111000; // 'F' - segments a,e,f,g on
            8'h34: ssd = 7'b0100001; // 'G' - segments a,c,d,e,f on
            8'h33: ssd = 7'b1001000; // 'H' - segments b,c,e,f,g on
            8'h4B: ssd = 7'b1110001; // 'L' - segments d,e,f on
            8'h31: ssd = 7'b1101010; // 'n' - segments c,e,g on
            8'h4D: ssd = 7'b0011000; // 'P' - segments a,b,e,f,g on
            8'h2D: ssd = 7'b1111010; // 'r' - segments e,g on
            8'h1B: ssd = 7'b0100100; // 'S' - segments a,c,d,f,g on (similar to '5')
            8'h2C: ssd = 7'b1110000; // 't' - segments d,e,f,g on
            
            8'hFF: ssd = 7'b1111110; // '-'
            
            default: ssd = 7'b1111111; // All segments off for unrecognized codes
        endcase
    end

endmodule