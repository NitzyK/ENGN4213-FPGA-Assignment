`timescale 1ns / 1ps

module lvl3Encrypter(
input wire [23:0] wordCoords,
input wire m_seed, n_seed,
output wire [31:0] wordLetters_encrypted
);
////////////////////////////////Overview//////////////////////////////////////////////
// 

////////////////////////////////Internal Signal Declaration//////////////////////////

wire [2:0] n1, n2, n3, n4; // m coordinates
wire [2:0] m1, m2, m3, m4; // n coordinates
wire [4:0] seedIndex; // index of seed
wire [4:0] letter1_index, letter2_index, letter3_index, letter4_index; // index of encrypted letters to be retrived
wire [7:0] letter1_encrypted, letter2_encrypted, letter3_encrypted, letter4_encrypted; // encrypted letters
reg [7:0] polybius_flat [0:24];  // define an array of 25x 8 bit elements
reg [4:0] polybiusIndex1, polybiusIndex2, polybiusIndex3, polybiusIndex4; // index of 

/// wordCoords structure : {m1,n1,m2,n2,m3,n3,m4,n4}
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
        polybius_flat[9] = 8'h00;   // x (k)
        
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
        
        polybius_flat[20] = 8'h00;  // x (v)
        polybius_flat[21] = 8'h00;  // x (w)
        polybius_flat[22] = 8'h00;  // x (x)
        polybius_flat[23] = 8'h00;  // x (y)
        polybius_flat[24] = 8'h00;  // x (z)
end


// construct seed index from (m,n)
assign seedIndex = ((m_seed - 1) * 5) + (n_seed - 1);

// construct letter indexs from (m,n)
assign letter1_index = ((m1 - 1) * 5) + (n1 - 1); 
assign letter2_index = ((m2 - 1) * 5) + (n2 - 1); 
assign letter3_index = ((m3 - 1) * 5) + (n3 - 1); 
assign letter4_index = ((m4 - 1) * 5) + (n4 - 1); 

//////////////////////////////////// Encryption ///////////////////////////////////////
always @(*) begin
            // Letter 1 seed encryption
            if (letter1_index == seedIndex) polybiusIndex1 <= 5'd0;
            else if (letter1_index > seedIndex) polybiusIndex1 <= 5'd25 - letter1_index;
            else if (letter1_index < seedIndex) polybiusIndex1 <= 5'd24 - letter1_index;
                
            // Letter 2 seed encryption
            if (letter2_index == seedIndex) polybiusIndex2 <= 5'd0;
            else if (letter2_index > seedIndex) polybiusIndex2 <= 5'd25 - letter2_index;
            else if (letter2_index < seedIndex) polybiusIndex2 <= 5'd24 - letter2_index;
            
            // Letter 3 seed encryption
            if (letter3_index == seedIndex) polybiusIndex3 <= 5'd0;
            else if (letter3_index > seedIndex) polybiusIndex3 <= 5'd25 - letter3_index;
            else if (letter3_index < seedIndex) polybiusIndex3 <= 5'd24 - letter3_index;
            
            // Letter 4 seed encryption
            if (letter4_index == seedIndex) polybiusIndex1 <= 5'd0;
            else if (letter4_index > seedIndex) polybiusIndex4 <= 5'd25 - letter4_index;
            else if (letter4_index < seedIndex) polybiusIndex4 <= 5'd24 - letter4_index;
end

//////////////////////////////////// retrive encrypted letters ///////////////////////////////////////////
assign letter1_encrypted = polybius_flat[polybiusIndex1];
assign letter2_encrypted = polybius_flat[polybiusIndex2];
assign letter3_encrypted = polybius_flat[polybiusIndex3];
assign letter4_encrypted = polybius_flat[polybiusIndex4];    

//////////////////////////////////// construct encrypted word ////////////////////////////////////////////
assign wordLetters_encrypted = {letter1_encrypted, letter2_encrypted, letter3_encrypted, letter4_encrypted};

endmodule
