`timescale 1ns / 1ps

module lvl3Encrypter2(
input wire [5:0] coordinates,
input wire [2:0] m_seed, n_seed,
output wire [7:0] seed, 
output wire [7:0] letter_encrypted
);
////////////////////////////////Overview//////////////////////////////////////////////
// 

////////////////////////////////Internal Signal Declaration//////////////////////////
wire [2:0] m, n;
wire [4:0] seedIndex; // index of seed
wire [4:0] letter_index;// index of unencrypted letter  
reg [7:0] polybius_flat [0:24];  // define an array of 25x 8 bit elements
reg [4:0] polybiusIndex; // index of encrypted letter to be retrived

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
        polybius_flat[9] = 8'h42;   // x (k)
        
        polybius_flat[10] = 8'h4B;   // L
        polybius_flat[11] = 8'h3A;  // x (m)
        polybius_flat[12] = 8'h31;  // n
        polybius_flat[13] = 8'h44;  // O
        polybius_flat[14] = 8'h4D;  // P
        
        polybius_flat[15] = 8'h15;  // x (q)
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

assign m = coordinates[5:3];
assign n = coordinates[2:0];


// construct seed index from (m,n)
assign seedIndex = ((m_seed - 1) * 5) + (n_seed - 1);

assign seed = polybius_flat[seedIndex];


// construct letter indexs from (m,n)
assign letter_index = ((m - 1) * 5) + (n - 1); 

//////////////////////////////////// Encryption ///////////////////////////////////////
always @(*) begin
            if (letter_index == 0) polybiusIndex <= seedIndex;
            else if (5'd25 - letter_index > seedIndex) polybiusIndex <= (5'd25- letter_index);
            else polybiusIndex <= 5'd24 - letter_index;
            
 end

//////////////////////////////////// retrive encrypted letters ///////////////////////////////////////////
assign letter_encrypted = polybius_flat[polybiusIndex];

endmodule
