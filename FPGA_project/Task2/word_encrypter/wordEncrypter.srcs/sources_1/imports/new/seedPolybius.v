`timescale 1ns / 1ps

module seedPolybius(

input wire [1:0] encrypterSelector,
input wire [23:0] wordCoords,
output wire [31:0] wordLetters_encrypted,
output wire [23:0] wordCoords_encrypted,
input wire m_seed, n_seed

    );

reg [7:0] polybius_flat [0:24];  // define an array of 25x 8 bit elements
reg [23:0] polybiusReversed_flat;

wire [2:0] n1, n2, n3, n4;
wire [2:0] m1, m2, m3, m4;
wire [4:0] seedIndex;
wire [7:0] seed;

reg [4:0] polybiusIndex1, polybiusIndex2, polybiusIndex3, polybiusIndex4;
reg [2:0] m1_encrypted, m2_encrypted, m3_encrypted, m4_encrypted;
reg [2:0] n1_encrypted, n2_encrypted, n3_encrypted, n4_encrypted;

wire [4:0] letter1_index, letter2_index, letter3_index, letter4_index;

wire [7:0] letter1_encrypted, letter2_encrypted, letter3_encrypted, letter4_encrypted;

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

assign seedIndex = ((m_seed - 1) * 5) + (n_seed - 1);
assign seed =  polybius_flat[seedIndex];



assign letter1_index = ((m1 - 1) * 5) + (n1 - 1); 
assign letter2_index = ((m2 - 1) * 5) + (n2 - 1); 
assign letter3_index = ((m3 - 1) * 5) + (n3 - 1); 
assign letter4_index = ((m4 - 1) * 5) + (n4 - 1); 


always @(*) begin
    if (letter1_index == seedIndex) begin
        polybiusIndex1 <= 5'd0;
    end
    else if (letter1_index > seedIndex) begin
        polybiusIndex1 <= 5'd25 - letter1_index;
    end
    else if (letter1_index < seedIndex) begin
        polybiusIndex1 <= 5'd24 - letter1_index;
    end 
end



always @(*) begin
    case(encrypterSelector)
    2'b00: begin
        polybiusIndex1 = ((n1 - 1) * 5) + (m1 - 1);
        polybiusIndex2 = ((n2 - 1) * 5) + (m2 - 1);
        polybiusIndex3 = ((n3 - 1) * 5) + (m3 - 1);
        polybiusIndex4 = ((n4 - 1) * 5) + (m4 - 1);
        
        m1_encrypted = n1;
        n1_encrypted = m1;
        
        m2_encrypted = n2;
        n2_encrypted = m2;
        
        m3_encrypted = n3;
        n3_encrypted = m3;
        
        m4_encrypted = n4;
        n4_encrypted = m4;
    end
    
    2'b01: begin
        polybiusIndex1 = ((5 - m1) * 5) + (5 - n1);
        polybiusIndex2 = ((5 - m2) * 5) + (5 - n2);
        polybiusIndex3 = ((5 - m3) * 5) + (5 - n3);
        polybiusIndex4 = ((5 - m4) * 5) + (5 - n4);
        
        m1_encrypted = 6 - m1;
        n1_encrypted = 6 - n1;
        
        m2_encrypted = 6 - m2;  
        n2_encrypted = 6 - n2;
        
        m3_encrypted = 6 - m3;
        n3_encrypted = 6 - n3;
        
        m4_encrypted = 6 - m4;
        n4_encrypted = 6 - n4;
    end
    
    2'b10: begin
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
    endcase
end

assign letter1_encrypted = polybius_flat[polybiusIndex1];
assign letter2_encrypted = polybius_flat[polybiusIndex2];
assign letter3_encrypted = polybius_flat[polybiusIndex3];
assign letter4_encrypted = polybius_flat[polybiusIndex4];    

assign wordLetters_encrypted = {letter1_encrypted, letter2_encrypted, letter3_encrypted, letter4_encrypted};
assign wordCoords_encrypted = {m1_encrypted, n1_encrypted, m2_encrypted, n2_encrypted, m3_encrypted, n3_encrypted, m4_encrypted, n4_encrypted};

endmodule
