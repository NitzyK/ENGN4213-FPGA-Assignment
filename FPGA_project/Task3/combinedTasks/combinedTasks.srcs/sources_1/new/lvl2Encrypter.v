`timescale 1ns / 1ps

module lvl2Encrypter(
input wire encrypterSelector,
input wire [23:0] wordCoords,
output wire [31:0] wordLetters_encrypted,
output wire [23:0] wordCoords_encrypted
);
/////////////////////////////Overview////////////////////////////////////////////////
// this module receives the letter coordinates for a word (4x 8 bit letters) as a concatonated 24 bit value, and applys two
// encryptions, which can be chosen by encypterSelector. The module returns a concatonated encrypted word (32 bit) and the 
// corresponding coordinates for each of the encrypted letters (24 bit).

////////////////////////////////Internal Signal Declaration//////////////////////////
wire [2:0] n1, n2, n3, n4; // n coordaintes
wire [2:0] m1, m2, m3, m4; // m coordinates
wire [7:0] letter1_encrypted, letter2_encrypted, letter3_encrypted, letter4_encrypted; // encrypted letters
reg [2:0] n1_encrypted, n2_encrypted, n3_encrypted, n4_encrypted; // encrypted n coordinates
reg [2:0] m1_encrypted, m2_encrypted, m3_encrypted, m4_encrypted; // encrypted m coordinates
reg [7:0] polybius_flat [0:24];  // define an array of 25x 8 bit elements
reg [4:0] polybiusIndex1, polybiusIndex2, polybiusIndex3, polybiusIndex4; // index of encrypted letters to be retrived

/// reconstruct coordinates (m,n) for each letter. wordCoords structure : {m1,n1,m2,n2,m3,n3,m4,n4}
assign m1 = wordCoords[23:21];
assign n1 = wordCoords[20:18];
assign m2 = wordCoords[17:15];
assign n2 = wordCoords[14:12];
assign m3 = wordCoords[11:9];
assign n3 = wordCoords[8:6];
assign m4 = wordCoords[5:3];
assign n4 = wordCoords[2:0];

initial begin
    polybius_flat[0] = 8'h1C;  // A
    polybius_flat[1] = 8'h32;  // b
    polybius_flat[2] = 8'h21;  // C
    polybius_flat[3] = 8'h23;  // d
    polybius_flat[4] = 8'h24;  // E
    
    polybius_flat[5] = 8'h2B;   // F
    polybius_flat[6] = 8'h34;   // G
    polybius_flat[7] = 8'h33;   // H
    polybius_flat[8] = 8'h43;   // I
    polybius_flat[9] = 8'h22;   // x (k)
    
    polybius_flat[10] = 8'h4B;   // L
    polybius_flat[11] = 8'h00;  // x (m)
    polybius_flat[12] = 8'h31;  // n
    polybius_flat[13] = 8'h44;  // O
    polybius_flat[14] = 8'h4D;  // P
    
    polybius_flat[15] = 8'h00;  // x (q)
    polybius_flat[16] = 8'h2D;  // r
    polybius_flat[17] = 8'h1B;  // S
    polybius_flat[18] = 8'h2C;  // t
    polybius_flat[19] = 8'h3C;  // U
    
    polybius_flat[20] = 8'h2A;  // x (v)
    polybius_flat[21] = 8'h1D;  // x (w)
    polybius_flat[22] = 8'h22;  // x (x)
    polybius_flat[23] = 8'h35;  // x (y)
    polybius_flat[24] = 8'h1A;  // x (z)
end

////////////////////////////// Encryption /////////////////////////////// 
always @(*) begin
    case(encrypterSelector) // select encryption (0: swap m and n, 1: reverse polybius square) 
    1'b0: begin
    // convert coordinates to index
        polybiusIndex1 = ((n1 - 1) * 5) + (m1 - 1); 
        polybiusIndex2 = ((n2 - 1) * 5) + (m2 - 1);
        polybiusIndex3 = ((n3 - 1) * 5) + (m3 - 1);
        polybiusIndex4 = ((n4 - 1) * 5) + (m4 - 1);
        
    // encrypted letter coordinates
        m1_encrypted = n1;
        n1_encrypted = m1;
        m2_encrypted = n2;
        n2_encrypted = m2;
        m3_encrypted = n3;
        n3_encrypted = m3;
        m4_encrypted = n4;
        n4_encrypted = m4;
    end
    
    1'b1: begin
    // convert coordinates to index
        polybiusIndex1 = ((5 - m1) * 5) + (5 - n1);
        polybiusIndex2 = ((5 - m2) * 5) + (5 - n2);
        polybiusIndex3 = ((5 - m3) * 5) + (5 - n3);
        polybiusIndex4 = ((5 - m4) * 5) + (5 - n4);
        
    // encrypted letter coordinates 
        m1_encrypted = 6 - m1;
        n1_encrypted = 6 - n1;
        
        m2_encrypted = 6 - m2;  
        n2_encrypted = 6 - n2;
        
        m3_encrypted = 6 - m3;
        n3_encrypted = 6 - n3;
        
        m4_encrypted = 6 - m4;
        n4_encrypted = 6 - n4;
    end
    endcase
end

///////////////////////////////// construct encrypted word and coordinates ////////////////////////////////////////////////////
assign letter1_encrypted = polybius_flat[polybiusIndex1];
assign letter2_encrypted = polybius_flat[polybiusIndex2];
assign letter3_encrypted = polybius_flat[polybiusIndex3];
assign letter4_encrypted = polybius_flat[polybiusIndex4];    
assign wordLetters_encrypted = {letter1_encrypted, letter2_encrypted, letter3_encrypted, letter4_encrypted};
assign wordCoords_encrypted = {m1_encrypted, n1_encrypted, m2_encrypted, n2_encrypted, m3_encrypted, n3_encrypted, m4_encrypted, n4_encrypted};

endmodule
