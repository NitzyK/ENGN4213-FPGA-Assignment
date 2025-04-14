`timescale 1ns / 1ps

module seedPolybius_tb();

    // Inputs
    reg [1:0] encrypterSelector;
    reg [23:0] wordCoords;
    reg [2:0] m_seed, n_seed;  // Changed to 3 bits to match the module
    
    // Outputs
    wire [31:0] wordLetters_encrypted;
    wire [23:0] wordCoords_encrypted;
    
    // Instantiate the Unit Under Test (UUT)
    seedPolybius uut (
        .encrypterSelector(encrypterSelector),
        .wordCoords(wordCoords),
        .wordLetters_encrypted(wordLetters_encrypted),
        .wordCoords_encrypted(wordCoords_encrypted),
        .m_seed(m_seed),
        .n_seed(n_seed)
    );
    
    initial begin
        // Initialize inputs
        encrypterSelector = 2'b10; // Test only case 2'b10
        wordCoords = 24'b0;
        m_seed = 3'd1;
        n_seed = 3'd1;
        
        // Wait for global reset
        #100;
        
        // Test Case 1: Seed at 2,1
        m_seed = 3'd1;
        n_seed = 3'd1;
        // FPGA
        wordCoords = {3'd2, 3'd1, 3'd3, 3'd5, 3'd2, 3'd2, 3'd1, 3'd1};
        #20;
        
        $display("Test Case 1 - Seed at (%d,%d)", m_seed, n_seed);
        $display("Input Word Coordinates:");
        $display("Letter 1: (%d,%d)", wordCoords[23:21], wordCoords[20:18]);
        $display("Letter 2: (%d,%d)", wordCoords[17:15], wordCoords[14:12]);
        $display("Letter 3: (%d,%d)", wordCoords[11:9], wordCoords[8:6]);
        $display("Letter 4: (%d,%d)", wordCoords[5:3], wordCoords[2:0]);
        $display("");
        
        $display("Input Letters in PS2 hex (if mapping is correct):");
        $display("Letter 1 (A): 0x1C");
        $display("Letter 2 (C): 0x21");
        $display("Letter 3 (T): 0x2C");
        $display("Letter 4 (S): 0x1B");
        $display("");
        
        $display("Encrypted Word Coordinates:");
        $display("Letter 1: (%d,%d)", wordCoords_encrypted[23:21], wordCoords_encrypted[20:18]);
        $display("Letter 2: (%d,%d)", wordCoords_encrypted[17:15], wordCoords_encrypted[14:12]);
        $display("Letter 3: (%d,%d)", wordCoords_encrypted[11:9], wordCoords_encrypted[8:6]);
        $display("Letter 4: (%d,%d)", wordCoords_encrypted[5:3], wordCoords_encrypted[2:0]);
        $display("");
        
        $display("Encrypted Letters (PS2 Hex):");
        $display("Letter 1: 0x%h", wordLetters_encrypted[31:24]);
        $display("Letter 2: 0x%h", wordLetters_encrypted[23:16]);
        $display("Letter 3: 0x%h", wordLetters_encrypted[15:8]);
        $display("Letter 4: 0x%h", wordLetters_encrypted[7:0]);
        $display("");
        
        // Test Case 2: Different seed and word
        m_seed = 3'd2;
        n_seed = 3'd2;
        // P(3,5), U(4,5), L(3,1), S(4,2)
        wordCoords = {3'd3, 3'd5, 3'd4, 3'd5, 3'd3, 3'd1, 3'd4, 3'd2};
        #20;
        
        $display("Test Case 2 - Seed at (%d,%d)", m_seed, n_seed);
        $display("Input Word Coordinates:");
        $display("Letter 1: (%d,%d)", wordCoords[23:21], wordCoords[20:18]);
        $display("Letter 2: (%d,%d)", wordCoords[17:15], wordCoords[14:12]);
        $display("Letter 3: (%d,%d)", wordCoords[11:9], wordCoords[8:6]);
        $display("Letter 4: (%d,%d)", wordCoords[5:3], wordCoords[2:0]);
        $display("");
        
        $display("Input Letters in PS2 hex (if mapping is correct):");
        $display("Letter 1 (P): 0x4D");
        $display("Letter 2 (U): 0x3C");
        $display("Letter 3 (L): 0x4B");
        $display("Letter 4 (S): 0x1B");
        $display("");
        
        $display("Encrypted Word Coordinates:");
        $display("Letter 1: (%d,%d)", wordCoords_encrypted[23:21], wordCoords_encrypted[20:18]);
        $display("Letter 2: (%d,%d)", wordCoords_encrypted[17:15], wordCoords_encrypted[14:12]);
        $display("Letter 3: (%d,%d)", wordCoords_encrypted[11:9], wordCoords_encrypted[8:6]);
        $display("Letter 4: (%d,%d)", wordCoords_encrypted[5:3], wordCoords_encrypted[2:0]);
        $display("");
        
        $display("Encrypted Letters (PS2 Hex):");
        $display("Letter 1: 0x%h", wordLetters_encrypted[31:24]);
        $display("Letter 2: 0x%h", wordLetters_encrypted[23:16]);
        $display("Letter 3: 0x%h", wordLetters_encrypted[15:8]);
        $display("Letter 4: 0x%h", wordLetters_encrypted[7:0]);
        $display("");
        
        #100 $finish;
    end

endmodule