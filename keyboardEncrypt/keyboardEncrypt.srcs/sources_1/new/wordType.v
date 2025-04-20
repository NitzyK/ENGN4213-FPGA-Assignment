module wordType (
    input wire reset,
    input wire clk,
    input wire [7:0] ps2_scancode,
    input wire dv_dec,
    input wire break_flag,
    input wire extended_flag,
    input wire btnL,
    input wire btnR,
    input wire auto_beat,
    input wire enable,
    input wire task_btn_spot,
    output reg [31:0] currentWord,
    output reg [2:0] word_index,
    input wire encrypt,
    input wire [255:0] encrypted_word,
    output reg [255:0] word =  256'h002b002b003400340033003300430043001b001b002a002a003c003c4333341c,
    input wire fixedWord_enable
);


    
    reg [1:0] letter_index;
    
    reg [255:0] fixed_word = {
    32'h2c1b1c2b, // 'fast'
    32'h001B4B4D, // 'pls'
    32'h4D4B2433,  // 'help'
    32'h232D1C33, // 'hard'
    32'h0044442C,  // 'too'
    32'h00242D1C, // 'are'
    32'h1C344D2B, // 'fpga'
    32'h34311c23   // 'dang'

};


  

    spot spot_dv_dec(
    .clk(clk),
    .spot_in(dv_dec),
    .spot_out(dv_dec_spot)
    );
    


    always @(*) case({fixedWord_enable,encrypt})
    2'b00: currentWord <= word[32*word_index +:32 ];
    2'b01: currentWord <= encrypted_word[32*word_index +:32];
    2'b11,2'b10: currentWord <= fixed_word[32*word_index +:32]; 
    endcase
    
    
    
    always @(posedge clk or posedge reset) begin
    
              
        if (reset) begin
            word_index <= 0;
            letter_index <= 0;
            
                word <= 256'h0;

            
        end 
        
        else if (task_btn_spot) word_index <=0;
        else  if (dv_dec_spot && !break_flag && enable) begin
            if (!extended_flag && (ps2_scancode != 8'h6B)) begin
                case (ps2_scancode)
                    8'h66: begin // Backspace
 
                        case(letter_index)
                        2'b00: word[32*word_index +:32 ] <= 0;
                        2'b01: begin 
                                word[32*word_index +:32 ] <= 0;
                                letter_index <=0;
                                end
                        2'b10: begin 
                                word[32*word_index + 8 +: 8] <= 8'h0;
                                letter_index <=1;
 
                                end
                        
                        
                        2'b11: begin 
                                
                                if(|word[32*word_index + 24 +: 8]) word[32*word_index + 24 +: 8] <= 8'h0;
                                else begin 
                                word[32*word_index + 16 +: 8] <= 8'h0;
                                letter_index <= 2'b10;
                                end
                        end
                        
                        
                        endcase
                        
                        
                        
                        end
//                    8'h6B: begin 
//                         if (word_index > 0) word_index <= word_index - 1;
                        
//                    end
                    default: begin
                        if (letter_index < 4) begin                                                    
//                             word[word_index][letter_index * 8 +: 8] <= ps2_scancode;   
                                word[32*word_index + 8*letter_index +: 8] <= ps2_scancode;
                         
                            letter_index <= (letter_index < 3) ?  letter_index + 1: 2'b11;
                        end
                    end
                endcase
            end else begin
                case (ps2_scancode)
                    8'h6B: begin // Left Arrow
                        if (word_index > 0)
                            word_index <= word_index - 1;
                    end
                    8'h74: begin // Right Arrow
                        if (word_index < 7)
                            word_index <= word_index + 1;
                    end
                    default: ; // ignore
                endcase
                letter_index <= 0;
            end
            
            
            
        end
        else if ((btnR || btnL|| auto_beat) && enable) begin
           
                if (!btnR && btnL && word_index > 0) begin
                    word_index <= word_index - 1;
                end
                else if (!btnL && btnR && word_index < 7) begin
                    word_index <= word_index + 1;
                end
                    else  if (auto_beat) word_index <= word_index + 1;
                    
                     letter_index <= 0;
            end 
//    end
    end
endmodule
