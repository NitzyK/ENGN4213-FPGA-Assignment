`timescale 1ns / 1ps

module wordEncrypter_tb;

    // Inputs
    reg encrypterSelector;
    reg [23:0] wordCoords;

    // Outputs
    wire [31:0] wordLetters_encrypted;
    wire [23:0] wordCoords_encrypted;

    // Instantiate the Unit Under Test (UUT)
    wordEncrypter uut (
        .encrypterSelector(encrypterSelector),
        .wordCoords(wordCoords),
        .wordLetters_encrypted(wordLetters_encrypted),
        .wordCoords_encrypted(wordCoords_encrypted)
    );

    initial begin
        // Monitor values
        $monitor("Time=%0t | Selector=%b | Coords=%h | Letters_encrypted=%h | Coords_encrypted=%h", 
                 $time, encrypterSelector, wordCoords, wordLetters_encrypted, wordCoords_encrypted);

        // Initialize Inputs
        encrypterSelector = 0;
        wordCoords = {3'd1, 3'd2, 3'd1, 3'd1, 3'd4, 3'd3, 3'd4, 3'd4};  // Format: {m1,n1,m2,n2,...}

        #10;  // Wait 10 time units

        // Test encryption selector = 1
        encrypterSelector = 1;
        wordCoords = {3'd1, 3'd2, 3'd1, 3'd1, 3'd4, 3'd3, 3'd4, 3'd4};

        #10;

        // Another test pattern (selector = 0)
        encrypterSelector = 0;
        wordCoords = {3'd1, 3'd2, 3'd1, 3'd1, 3'd4, 3'd3, 3'd4, 3'd4};

        #10;

        // Finish simulation
        $finish;
    end

endmodule
