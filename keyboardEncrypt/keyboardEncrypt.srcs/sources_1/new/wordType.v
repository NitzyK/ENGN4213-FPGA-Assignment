module wordType(
    input wire enable,
    input wire reset,
    input wire clk,
    input wire [7:0] ps2_scancode,
    input wire dv_dec,
    input wire break_flag,
    input wire extended_flag,
    output reg [31:0] currentWord,
    output wire [3:0] led 
);
    
    reg [7:0] word_buffer[0:7][0:3];  // 8 words, each 4 bytes
    reg [3:0] word_index;
    reg [2:0] letter_index;
    
    integer i, j;
    
    
    assign led = word_index;
    // Update currentWord whenever word_buffer changes
    always @(posedge clk) begin
        currentWord = {word_buffer[word_index][3], 
                       word_buffer[word_index][2], 
                       word_buffer[word_index][1], 
                       word_buffer[word_index][0]};
    end
    
    always @(posedge clk) begin   
        if (reset) begin 
            // Clear the word buffer
            for (i = 0; i < 8; i = i + 1) begin
                for (j = 0; j < 4; j = j + 1) begin
                    word_buffer[i][j] <= 8'h00;
                end
            end
            word_index <= 0;
            letter_index <= 0;
        end
        else if (enable && dv_dec && !break_flag) begin
            if (!extended_flag) begin
                // Handle normal keys (letters, backspace)
                case(ps2_scancode)
                    8'h66: begin // Backspace
                        if (letter_index > 0) begin
                            letter_index <= letter_index - 1;
                            word_buffer[word_index][letter_index - 1] <= 8'h00;
                        end
                    end
                    default: begin // Typing a letter
                        if (letter_index < 4) begin
                            word_buffer[word_index][letter_index] <= ps2_scancode;
                            letter_index <= letter_index + 1;
                        end
                    end
                endcase
            end
            else begin // Extended keys (arrows)
                case(ps2_scancode)
                    8'h6B: word_index <= (word_index > 0) ? word_index - 1 : 0; // Left arrow
                    8'h74: word_index <= (word_index < 7) ? word_index + 1 : 7; // Right arrow
                    default: ; // Ignore other extended keys
                endcase
                // Reset letter_index when switching words
                letter_index <= 0;
            end
        end
    end
endmodule