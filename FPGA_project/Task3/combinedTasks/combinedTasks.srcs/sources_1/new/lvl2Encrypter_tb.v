`timescale 1ns / 1ps

module lvl2Encrypter_tb();

// Inputs
reg encrypterSelector;
reg [23:0] wordCoords;

// Outputs
wire [31:0] wordLetters_encrypted;
wire [23:0] wordCoords_encrypted;

// Internal signals for debugging
wire [2:0] m1, n1, m2, n2, m3, n3, m4, n4;
wire [2:0] m1_encrypted, n1_encrypted, m2_encrypted, n2_encrypted;
wire [2:0] m3_encrypted, n3_encrypted, m4_encrypted, n4_encrypted;
wire [7:0] letter1_encrypted, letter2_encrypted, letter3_encrypted, letter4_encrypted;

// Instantiate the Device Under Test (DUT)
lvl2Encrypter uut (
    .encrypterSelector(encrypterSelector),
    .wordCoords(wordCoords),
    .wordLetters_encrypted(wordLetters_encrypted),
    .wordCoords_encrypted(wordCoords_encrypted)
);

// Extract signals from the DUT for easier debugging
assign m1 = wordCoords[23:21];
assign n1 = wordCoords[20:18];
assign m2 = wordCoords[17:15];
assign n2 = wordCoords[14:12];
assign m3 = wordCoords[11:9];
assign n3 = wordCoords[8:6];
assign m4 = wordCoords[5:3];
assign n4 = wordCoords[2:0];

assign m1_encrypted = wordCoords_encrypted[23:21];
assign n1_encrypted = wordCoords_encrypted[20:18];
assign m2_encrypted = wordCoords_encrypted[17:15];
assign n2_encrypted = wordCoords_encrypted[14:12];
assign m3_encrypted = wordCoords_encrypted[11:9];
assign n3_encrypted = wordCoords_encrypted[8:6];
assign m4_encrypted = wordCoords_encrypted[5:3];
assign n4_encrypted = wordCoords_encrypted[2:0];

assign letter1_encrypted = wordLetters_encrypted[31:24];
assign letter2_encrypted = wordLetters_encrypted[23:16];
assign letter3_encrypted = wordLetters_encrypted[15:8];
assign letter4_encrypted = wordLetters_encrypted[7:0];

// Test procedure
initial begin
    // Print header
    $display("==== Testing lvl2Encrypter Module ====");
    
    // Test Case 1: Word "FAST" with encrypterSelector = 0 (swap m,n)
    // F->(2,3), A->(1,1), S->(3,4), T->(3,5)
    encrypterSelector = 1'b0;
    wordCoords = {3'd2, 3'd1, 3'd1, 3'd1, 3'd4, 3'd3, 3'd4, 3'd4};
    #10;
    $display("\nTest Case 1: Word coords for 'FAST' with Encrypter Mode 0 (swap m,n)");
    $display("Input Coordinates: F(2,3), A(1,1), S(3,4), T(3,5)");
    $display("Expected Output: Coordinates swapped to (3,2), (1,1), (4,3), (5,3)");
    $display("Letter1 encrypted: %h", letter1_encrypted);
    $display("Letter2 encrypted: %h", letter2_encrypted);
    $display("Letter3 encrypted: %h", letter3_encrypted);
    $display("Letter4 encrypted: %h", letter4_encrypted);
    $display("Encrypted coordinates:");
    $display("Letter1 (m,n): (%d,%d)", m1_encrypted, n1_encrypted);
    $display("Letter2 (m,n): (%d,%d)", m2_encrypted, n2_encrypted);
    $display("Letter3 (m,n): (%d,%d)", m3_encrypted, n3_encrypted);
    $display("Letter4 (m,n): (%d,%d)", m4_encrypted, n4_encrypted);
    
    // Test Case 2: Same word with encrypterSelector = 1 (reverse)
    encrypterSelector = 1'b1;
    #10;
    $display("\nTest Case 2: Word coords for 'FAST' with Encrypter Mode 1 (reverse)");
    $display("Input Coordinates: F(2,3), A(1,1), S(3,4), T(3,5)");
    $display("Expected Output: Coordinates reversed to (4,3), (5,5), (3,2), (3,1)");
    $display("Letter1 encrypted: %h", letter1_encrypted);
    $display("Letter2 encrypted: %h", letter2_encrypted);
    $display("Letter3 encrypted: %h", letter3_encrypted);
    $display("Letter4 encrypted: %h", letter4_encrypted);
    $display("Encrypted coordinates:");
    $display("Letter1 (m,n): (%d,%d)", m1_encrypted, n1_encrypted);
    $display("Letter2 (m,n): (%d,%d)", m2_encrypted, n2_encrypted);
    $display("Letter3 (m,n): (%d,%d)", m3_encrypted, n3_encrypted);
    $display("Letter4 (m,n): (%d,%d)", m4_encrypted, n4_encrypted);
    
    // Test Case 3: Actual word used in top module "FAST" (F=2B, A=1C, S=1B, T=2C)
    // Convert letters to coordinates using Polybius Square
    // F -> 2,3 -> (2,3)
    // A -> 1,1 -> (1,1)
    // S -> 3,4 -> (3,4)
    // T -> 3,5 -> (3,5)
    $display("\nTest Case 3: Testing with specific PS2 letters from top module");
    $display("Letter hex values: F=2B, A=1C, S=1B, T=2C");
    encrypterSelector = 1'b0;
    wordCoords = {3'd2, 3'd1, 3'd1, 3'd1, 3'd4, 3'd3, 3'd4, 3'd4};
    #10;
    $display("Mode 0 (swap) - Encrypted letters: %h %h %h %h", 
             letter1_encrypted, letter2_encrypted, letter3_encrypted, letter4_encrypted);
    
    encrypterSelector = 1'b1;
    #10;
    $display("Mode 1 (reverse) - Encrypted letters: %h %h %h %h", 
             letter1_encrypted, letter2_encrypted, letter3_encrypted, letter4_encrypted);
    
    // Test Case 4: Test with the actual values from your top module
    $display("\nTest Case 4: Testing with hardcoded letters from top module");
    // letter_1 <= 8'h2B; // F 
    // letter_2 <= 8'h1C; // A
    // letter_3 <= 8'h1B; // S
    // letter_4 <= 8'h2c; // T
    encrypterSelector = 1'b0;
    // These are actual coordinates for F, A, S, T derived from ps2ToCoord
    wordCoords = {3'd2, 3'd1, 3'd1, 3'd1, 3'd3, 3'd4, 3'd3, 3'd5};
    #10;
    $display("Original letters: F=2B, A=1C, S=1B, T=2C");
    $display("Mode 0 (swap) - Encrypted letters (hex): %h %h %h %h", 
             letter1_encrypted, letter2_encrypted, letter3_encrypted, letter4_encrypted);
    $display("Mode 0 (swap) - Encrypted coords: (%d,%d), (%d,%d), (%d,%d), (%d,%d)",
             m1_encrypted, n1_encrypted, m2_encrypted, n2_encrypted, 
             m3_encrypted, n3_encrypted, m4_encrypted, n4_encrypted);
             
    encrypterSelector = 1'b1;
    #10;
    $display("Mode 1 (reverse) - Encrypted letters (hex): %h %h %h %h", 
             letter1_encrypted, letter2_encrypted, letter3_encrypted, letter4_encrypted);
    $display("Mode 1 (reverse) - Encrypted coords: (%d,%d), (%d,%d), (%d,%d), (%d,%d)",
             m1_encrypted, n1_encrypted, m2_encrypted, n2_encrypted, 
             m3_encrypted, n3_encrypted, m4_encrypted, n4_encrypted);
    
    // End simulation
    #10;
    $display("\n==== Testing Complete ====");
    $finish;
end

endmodule