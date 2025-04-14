`timescale 1ns / 1ps

module Encrypter_top(
    input wire clk, reset, view, encrypt, btn_E, btn_W, encrypterSelector,
    output wire [6:0] ssdAnode,
    output wire [3:0] ssdCathode,
    output wire [3:0] index
    );
 
    ///
   
    wire [2:0] m1, m2, m3, m4;
    wire [2:0] n1, n2, n3, n4;    
    wire [2:0] n1_encrypted, n2_encrypted, n3_encrypted, n4_encrypted;
    wire [2:0] m1_encrypted, m2_encrypted, m3_encrypted, m4_encrypted;
    
   
    wire [31:0] wordLetters;
    wire [23:0] wordCoords;
    wire [31:0] wordLetters_encrypted;
    wire [23:0] wordCoords_encrypted;
    wire [31:0] wordEncrypted;
    
    wire [7:0] n1_encrypted_PS2, n2_encrypted_PS2, n3_encrypted_PS2, n4_encrypted_PS2;
    wire [7:0] m1_encrypted_PS2, m2_encrypted_PS2, m3_encrypted_PS2, m4_encrypted_PS2;
    wire [7:0] n1_PS2, n2_PS2, n3_PS2, n4_PS2;
    wire [7:0] m1_PS2, m2_PS2, m3_PS2, m4_PS2;
    reg [7:0] m_coordinate;
    reg [7:0] n_coordinate;
    reg [7:0] m_coordinate_encrypted;
    reg [7:0] n_coordinate_encrypted;
    reg [7:0] letter_unencrypted;
    reg [7:0] letter_encrypted;
    wire [7:0] letter_1, letter_2, letter_3,letter_4;
    wire [7:0] letter1_encrypted, letter2_encrypted, letter3_encrypted, letter4_encrypted;
    reg [31:0] displayValues;
    ///

 //HELP
// assign letter_1 = 8'h33; 
// assign letter_2 = 8'h24; 
// assign letter_3 = 8'h4B; 
// assign letter_4 = 8'h4D; 

//FAST
 assign letter_1 = 8'h2B; 
 assign letter_2 = 8'h1C; 
 assign letter_3 = 8'h1B; 
 assign letter_4 = 8'h2c; 
 

 assign wordLetters = {letter_1,letter_2, letter_3, letter_4};  // create word from letters
 
 // retreive letters coordinates from polybius square
 hexToCoords hexToCoords_1( .letter(letter_1), .m_coords(m1), .n_coords(n1) );
 hexToCoords hexToCoords_2( .letter(letter_2), .m_coords(m2), .n_coords(n2) );
 hexToCoords hexToCoords_3( .letter(letter_3), .m_coords(m3), .n_coords(n3) );
 hexToCoords hexToCoords_4( .letter(letter_4), .m_coords(m4), .n_coords(n4) );

 assign wordCoords = {m1,n1,m2,n2,m3,n3,m4,n4}; // concatonate coordinates
 
 // perform word encryption --> outputs encrypted word, and encrypted coordinates 
 wordEncrypter wordEncrypter_inst(
 .encrypterSelector(encrypterSelector), .wordCoords(wordCoords), 
 .wordLetters_encrypted(wordLetters_encrypted), .wordCoords_encrypted(wordCoords_encrypted)
 );
 
assign letter1_encrypted = wordLetters_encrypted[31:24];
assign letter2_encrypted = wordLetters_encrypted[23:16];
assign letter3_encrypted = wordLetters_encrypted[15:8];
assign letter4_encrypted = wordLetters_encrypted[7:0];

assign wordEncrypted = {letter1_encrypted, letter2_encrypted, letter3_encrypted, letter4_encrypted};
 
// Retrieve encrypted coordinates
assign n1_encrypted = wordCoords_encrypted[23:21];
assign m1_encrypted = wordCoords_encrypted[20:18];
assign n2_encrypted = wordCoords_encrypted[17:15];
assign m2_encrypted = wordCoords_encrypted[14:12];
assign n3_encrypted = wordCoords_encrypted[11:9];
assign m3_encrypted = wordCoords_encrypted[8:6];
assign n4_encrypted = wordCoords_encrypted[5:3];
assign m4_encrypted = wordCoords_encrypted[2:0];

// Convert each coordinate to PS2 from binary 
toPS2 toPS2_n1( .bcd(n1), .keyboardHex(n1_PS2) ); ////// create toPS2 (rename from keyboard...)
toPS2 toPS2_m1( .bcd(m1), .keyboardHex(m1_PS2) ); 
toPS2 toPS2_n2( .bcd(n2), .keyboardHex(n2_PS2) ); 
toPS2 toPS2_m2( .bcd(m2), .keyboardHex(m2_PS2) ); 
toPS2 toPS2_n3( .bcd(n3), .keyboardHex(n3_PS2) ); 
toPS2 toPS2_m3( .bcd(m3), .keyboardHex(m3_PS2) ); 
toPS2 toPS2_n4( .bcd(n4), .keyboardHex(n4_PS2) ); 
toPS2 toPS2_m4( .bcd(m4), .keyboardHex(m4_PS2) );

// Convert each coordinate to PS2 from binary 
toPS2 toPS2_n1_encrypted ( .bcd(n1_encrypted), .keyboardHex(n1_encrypted_PS2) ); 
toPS2 toPS2_m1_encrypted ( .bcd(m1_encrypted), .keyboardHex(m1_encrypted_PS2) ); 
toPS2 toPS2_n2_encrypted ( .bcd(n2_encrypted), .keyboardHex(n2_encrypted_PS2) ); 
toPS2 toPS2_m2_encrypted ( .bcd(m2_encrypted), .keyboardHex(m2_encrypted_PS2) ); 
toPS2 toPS2_n3_encrypted ( .bcd(n3_encrypted), .keyboardHex(n3_encrypted_PS2) ); 
toPS2 toPS2_m3_encrypted ( .bcd(m3_encrypted), .keyboardHex(m3_encrypted_PS2) ); 
toPS2 toPS2_n4_encrypted ( .bcd(n4_encrypted), .keyboardHex(n4_encrypted_PS2) ); 
toPS2 toPS2_m4_encrypted ( .bcd(m4_encrypted), .keyboardHex(m4_encrypted_PS2) );      


// debounce and spot btn1
debouncer debouncer_btnE_inst(.switchIn(btn_E), .clk(clk), .reset(1'b0), .debounceout(btnE_debounced) );

spot spot_btn1_inst( .clk(clk), .spot_in(btnE_debounced), .spot_out(btnE_processed));

// debounce and spot btn1
debouncer debouncer_btnW_inst( .switchIn(btn_W), .clk(clk), .reset(1'b0), .debounceout(btnW_debounced));

spot spot_btnW_inst( .clk(clk), .spot_in(btnW_debounced), .spot_out(btnW_processed));


// use east west buttons to create an index i between 0-3
eastWestShifter eastWestShifter_inst ( .clk(clk), .reset(reset), .btn_E(btnE_processed), .btn_W(btnW_processed), .index(index));

// use index to select the ith position retreiving the ith letter, encrypted letter, coordinate and encrypted coordinate
always @(*) begin
    case(index)
        4'd0 : begin
        letter_unencrypted = letter_1;
        letter_encrypted = letter1_encrypted;
        m_coordinate = m1_PS2;
        n_coordinate = n1_PS2;
        m_coordinate_encrypted = m1_encrypted_PS2;
        n_coordinate_encrypted = n1_encrypted_PS2;
        end 
        4'd1 : begin
        letter_unencrypted = letter_2;
        letter_encrypted = letter2_encrypted;
        m_coordinate = m2_PS2;
        n_coordinate = n2_PS2;
        m_coordinate_encrypted = m2_encrypted_PS2;
        n_coordinate_encrypted = n2_encrypted_PS2;
        end
        4'd2 : begin
        letter_unencrypted = letter_3;
        letter_encrypted = letter3_encrypted;
        m_coordinate = m3_PS2;
        n_coordinate = n3_PS2;
        m_coordinate_encrypted = m3_encrypted_PS2;
        n_coordinate_encrypted = n3_encrypted_PS2;
        end
        4'd3 : begin
        letter_unencrypted = letter_4;
        letter_encrypted = letter4_encrypted;
        m_coordinate = m4_PS2;
        n_coordinate = n4_PS2;
        m_coordinate_encrypted = m4_encrypted_PS2;
        n_coordinate_encrypted = n4_encrypted_PS2;
        end
        default : begin
        letter_unencrypted = 8'h00;
        letter_encrypted = 8'h00;
        m_coordinate = 8'h0;
        n_coordinate = 8'h0;
        m_coordinate_encrypted = 8'h0;
        n_coordinate_encrypted = 8'h0;
        end
    endcase
end

wire [2:0] state;
 assign state = {encrypterSelector, encrypt, view}; 

always @(posedge clk) begin
    if (reset) begin
        displayValues <= 32'h00000000;
    end
    else begin ////// update the case statements
        case(state)
            3'b000: displayValues <= wordLetters;
            3'b001: displayValues <= {letter_unencrypted, 8'h00, m_coordinate, n_coordinate};
            3'b010: displayValues <= wordEncrypted; //
            3'b011: displayValues <= {letter_encrypted, 8'h00, m_coordinate_encrypted, n_coordinate_encrypted};
            3'b100: displayValues <= wordLetters;// 
            3'b101: displayValues <= {letter_unencrypted, 8'h00, m_coordinate, n_coordinate}; 
            3'b110: displayValues <= wordEncrypted;
            3'b111: displayValues <= {letter_encrypted, 8'h00, m_coordinate_encrypted, n_coordinate_encrypted};
            default: displayValues <= {8'h00, 8'h00, 8'h00, 8'h00};
        endcase
    end
end

displayDriver displayDriver_inst(.clk(clk), .ssdAnode(ssdAnode), .ssdCathode(ssdCathode), .displayValues(displayValues) );


endmodule


