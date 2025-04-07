`timescale 1ns / 1ps

module Encrypter_top(
    input wire clk, reset, view, encrypt, btn_E, btn_W, encrypterSelector,
    
//    output wire [2:0] m1_coords,
//    output wire [2:0] n1_coords,
    
    
//    output wire [2:0] m2_coords,
//    output wire [2:0] n2_coords,
    
    
//    output wire [2:0] m3_coords,
//    output wire [2:0] n3_coords,
    
    
//    output wire [2:0] m4_coords,
//    output wire [2:0] n4_coords,
    
    
    output wire [6:0] ssdAnode,
    output wire [3:0] ssdCathode,
    
    
    output wire [3:0] index
    );
 
 
    wire [2:0] m1_coords;
    wire [2:0] n1_coords;
    wire [2:0] encrypted_m1_coords;
    wire [2:0] encrypted_n1_coords;
   
    
    wire [2:0] m2_coords;
    wire [2:0] n2_coords;
    wire [2:0] encrypted_m2_coords;
    wire [2:0] encrypted_n2_coords;
    
    wire [2:0] m3_coords;
    wire [2:0] n3_coords;
    wire [2:0] encrypted_m3_coords;
    wire [2:0] encrypted_n3_coords;
    
    
    wire [2:0] m4_coords;
    wire [2:0] n4_coords;
    wire [2:0] encrypted_m4_coords;
    wire [2:0] encrypted_n4_coords;
//    wire [3:0] index;
 

 
  
 wire [7:0] letter_1;
 wire [7:0] letter_2;
 wire [7:0] letter_3; 
 wire [7:0] letter_4;
 
 
 
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
 
 
 wire [31:0] word;
 assign word = {letter_1,letter_2, letter_3, letter_4};
 
///### Letter selection 

// debounce and spot btn1
debouncer debouncer_btnE_inst(.switchIn(btn_E), .clk(clk), .reset(1'b0), .debounceout(btnE_debounced) );

spot spot_btn1_inst( .clk(clk), .spot_in(btnE_debounced), .spot_out(btnE_processed));

// debounce and spot btn1
debouncer debouncer_btnW_inst( .switchIn(btn_W), .clk(clk), .reset(1'b0), .debounceout(btnW_debounced));

spot spot_btnW_inst( .clk(clk), .spot_in(btnW_debounced), .spot_out(btnW_processed));

eastWestShifter #(.max_index(4'd3)) eastWestShifter_inst ( .clk(clk), .reset(reset), .btn_E(btnE_processed), .btn_W(btnW_processed), .index(index));


reg [7:0] unencrypted_letter;

always @(*) begin
    case(index)
        4'd0 : unencrypted_letter = letter_1; 
        4'd1 : unencrypted_letter = letter_2;
        4'd2 : unencrypted_letter = letter_3;
        4'd3 : unencrypted_letter = letter_4;
        default : unencrypted_letter = 8'h00;
    endcase
end

wire [7:0] keyboardHex_n1;
wire [7:0] keyboardHex_m1;
wire [7:0] keyboardHex_n2;
wire [7:0] keyboardHex_m2;
wire [7:0] keyboardHex_n3;
wire [7:0] keyboardHex_m3;
wire [7:0] keyboardHex_n4;
wire [7:0] keyboardHex_m4;

reg [7:0] m_coordinate;
reg [7:0] n_coordinate;

always @(*) begin
    case(index)
        4'd0 : begin 
        m_coordinate = keyboardHex_m1;
        n_coordinate = keyboardHex_n1;
        end
        4'd1 : begin 
        m_coordinate = keyboardHex_m2;
        n_coordinate = keyboardHex_n2;
        end
        4'd2 : begin
        m_coordinate = keyboardHex_m3;
        n_coordinate = keyboardHex_n3;
        end
        4'd3 : begin 
        m_coordinate = keyboardHex_m4;
        n_coordinate = keyboardHex_n4;
        end
        default : begin
        m_coordinate = 8'h0;
        n_coordinate = 8'h0;
        end
    endcase
end

wire [7:0] keyboardHex_n1_encrypted;
wire [7:0] keyboardHex_m1_encrypted;
wire [7:0] keyboardHex_n2_encrypted;
wire [7:0] keyboardHex_m2_encrypted;
wire [7:0] keyboardHex_n3_encrypted;
wire [7:0] keyboardHex_m3_encrypted;
wire [7:0] keyboardHex_n4_encrypted;
wire [7:0] keyboardHex_m4_encrypted;

reg [7:0] m_coordinate_encrypted;
reg [7:0] n_coordinate_encrypted;

always @(*) begin
    case(index)
        4'd0 : begin 
        m_coordinate_encrypted = keyboardHex_m1_encrypted;
        n_coordinate_encrypted = keyboardHex_n1_encrypted;
        end
        4'd1 : begin 
        m_coordinate_encrypted = keyboardHex_m2_encrypted;
        n_coordinate_encrypted = keyboardHex_n2_encrypted;
        end
        4'd2 : begin
        m_coordinate_encrypted = keyboardHex_m3_encrypted;
        n_coordinate_encrypted = keyboardHex_n3_encrypted;
        end
        4'd3 : begin 
        m_coordinate_encrypted = keyboardHex_m4_encrypted;
        n_coordinate_encrypted = keyboardHex_n4_encrypted;
        end
        default : begin
        m_coordinate_encrypted = 8'h0;
        n_coordinate_encrypted = 8'h0;
        end
    endcase
end


hexToCoords hexToCoords_1( .letter(letter_1), .m_coords(m1_coords), .n_coords(n1_coords) );
hexToCoords hexToCoords_2( .letter(letter_2), .m_coords(m2_coords), .n_coords(n2_coords) );
hexToCoords hexToCoords_3( .letter(letter_3), .m_coords(m3_coords), .n_coords(n3_coords) );
hexToCoords hexToCoords_4( .letter(letter_4), .m_coords(m4_coords), .n_coords(n4_coords) );

toKeyboardHexEncoder toKeyboardHexEncoder_n1( .bcd(n1_coords), .keyboardHex(keyboardHex_n1) ); 
toKeyboardHexEncoder toKeyboardHexEncoder_m1( .bcd(m1_coords), .keyboardHex(keyboardHex_m1) );
toKeyboardHexEncoder toKeyboardHexEncoder_n2( .bcd(n2_coords), .keyboardHex(keyboardHex_n2) ); 
toKeyboardHexEncoder toKeyboardHexEncoder_m2( .bcd(m2_coords), .keyboardHex(keyboardHex_m2) ); 
toKeyboardHexEncoder toKeyboardHexEncoder_n3( .bcd(n3_coords), .keyboardHex(keyboardHex_n3) ); 
toKeyboardHexEncoder toKeyboardHexEncoder_m3( .bcd(m3_coords), .keyboardHex(keyboardHex_m3) ); 
toKeyboardHexEncoder toKeyboardHexEncoder_n4( .bcd(n4_coords), .keyboardHex(keyboardHex_n4) ); 
toKeyboardHexEncoder toKeyboardHexEncoder_m4( .bcd(m4_coords), .keyboardHex(keyboardHex_m4) ); 

toKeyboardHexEncoder toKeyboardHexEncoder_n1_encrypted( .bcd(encrypted_n1_coords), .keyboardHex(keyboardHex_n1_encrypted) ); 
toKeyboardHexEncoder toKeyboardHexEncoder_m1_encrypted( .bcd(encrypted_m1_coords), .keyboardHex(keyboardHex_m1_encrypted) );
toKeyboardHexEncoder toKeyboardHexEncoder_n2_encrypted( .bcd(encrypted_n2_coords), .keyboardHex(keyboardHex_n2_encrypted) ); 
toKeyboardHexEncoder toKeyboardHexEncoder_m2_encrypted( .bcd(encrypted_m2_coords), .keyboardHex(keyboardHex_m2_encrypted) );
toKeyboardHexEncoder toKeyboardHexEncoder_n3_encrypted( .bcd(encrypted_n3_coords), .keyboardHex(keyboardHex_n3_encrypted) ); 
toKeyboardHexEncoder toKeyboardHexEncoder_m3_encrypted( .bcd(encrypted_m3_coords), .keyboardHex(keyboardHex_m3_encrypted) );
toKeyboardHexEncoder toKeyboardHexEncoder_n4_encrypted( .bcd(encrypted_n4_coords), .keyboardHex(keyboardHex_n4_encrypted) ); 
toKeyboardHexEncoder toKeyboardHexEncoder_m4_encrypted( .bcd(encrypted_m4_coords), .keyboardHex(keyboardHex_m4_encrypted) );


reg [31:0] displayValues;
wire [7:0] letter1_encrypted;
wire [7:0] letter2_encrypted;
wire [7:0] letter3_encrypted;
wire [7:0] letter4_encrypted;

wire [31:0] encrypted_word;
assign encrypted_word = {letter1_encrypted,letter2_encrypted,letter3_encrypted,letter4_encrypted};

polybiusEncrypterOptions polybiusEncrypterOptions_1( .encrypterSelector(encrypterSelector), .m_coords(m1_coords), .n_coords(n1_coords),
.letter_encrypted(letter1_encrypted), .encrypted_m_coords(encrypted_m1_coords), .encrypted_n_coords(encrypted_n1_coords) );

polybiusEncrypterOptions polybiusEncrypterOptions_2( .encrypterSelector(encrypterSelector), .m_coords(m2_coords), .n_coords(n2_coords),
.letter_encrypted(letter2_encrypted), .encrypted_m_coords(encrypted_m2_coords), .encrypted_n_coords(encrypted_n2_coords) );

polybiusEncrypterOptions polybiusEncrypterOptions_3( .encrypterSelector(encrypterSelector), .m_coords(m3_coords), .n_coords(n3_coords),
.letter_encrypted(letter3_encrypted), .encrypted_m_coords(encrypted_m3_coords), .encrypted_n_coords(encrypted_n3_coords) );

polybiusEncrypterOptions polybiusEncrypterOptions_4( .encrypterSelector(encrypterSelector), .m_coords(m4_coords), .n_coords(n4_coords),
.letter_encrypted(letter4_encrypted), .encrypted_m_coords(encrypted_m4_coords), .encrypted_n_coords(encrypted_n4_coords) );


reg [7:0] letter_encrypted;

always @(*) begin
    case(index)
        4'd0 : letter_encrypted = letter1_encrypted; 
        4'd1 : letter_encrypted = letter2_encrypted;
        4'd2 : letter_encrypted = letter3_encrypted;
        4'd3 : letter_encrypted = letter4_encrypted;
        default : letter_encrypted = 8'h00;
    endcase
end

wire [2:0] state;
 assign state = {encrypterSelector, encrypt, view}; 

always @(posedge clk) begin
    if (reset) begin
        displayValues <= 32'h00000000;
    end
    else begin
        case(state)
            3'b000: displayValues <= word;
            3'b001: displayValues <= {unencrypted_letter, 8'h00, m_coordinate, n_coordinate};
            3'b010: displayValues <= encrypted_word;
            3'b011: displayValues <= {letter_encrypted, 8'h00, m_coordinate_encrypted, n_coordinate_encrypted};
            3'b100: displayValues <= word;
            3'b101: displayValues <= {letter_encrypted, 8'h00, m_coordinate_encrypted, n_coordinate_encrypted};
            3'b110: displayValues <= encrypted_word;
            3'b111: displayValues <= {letter_encrypted, 8'h00, m_coordinate_encrypted, n_coordinate_encrypted};
            default: displayValues <= {8'h00, 8'h00, 8'h00, 8'h00};
        endcase
    end
end

displayDriver displayDriver_inst(.clk(clk), .ssdAnode(ssdAnode), .ssdCathode(ssdCathode), .displayValues(displayValues) );

endmodule


