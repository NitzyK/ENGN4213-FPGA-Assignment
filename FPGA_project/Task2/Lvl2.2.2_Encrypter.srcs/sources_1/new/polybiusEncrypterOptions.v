`timescale 1ns / 1ps


module polybiusEncrypterOptions(
    input wire encrypterSelector, 
    input wire [2:0] m_coords,       
    input wire [2:0] n_coords,       
    output wire [7:0] letter_encrypted,
    output reg [4:0] extract_coords,
    output reg [2:0] encrypted_m_coords,
    output reg [2:0] encrypted_n_coords   
); 

reg [7:0] polybius_flat [0:24];  // define an array of 25x 8 bit elements

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

always @(*) begin
    case(encrypterSelector)
    1'b0: begin
    extract_coords = ((n_coords - 1) * 5) + (m_coords - 1);
    encrypted_m_coords = n_coords;
    encrypted_n_coords = m_coords;
    end
    1'b1: begin
    extract_coords = ((5 - m_coords) * 5) + (5 - n_coords);
    encrypted_m_coords = 6 - m_coords;
    encrypted_n_coords = 6 - n_coords;
    end
    endcase
end

//assign coords = extract_coords; 

assign letter_encrypted = polybius_flat[extract_coords]; 
 
endmodule
