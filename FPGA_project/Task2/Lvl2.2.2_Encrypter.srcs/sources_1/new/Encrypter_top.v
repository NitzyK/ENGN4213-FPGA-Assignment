`timescale 1ns / 1ps

module Encrypter_top(
    input wire clk, reset, view, encrypt, btn_E, btn_W,encrypterSelector,
    output wire [2:0] m_coords,
    output wire [2:0] n_coords,
    output wire [6:0] ssdAnode,
    output wire [3:0] ssdCathode,
    output wire [3:0] index,
    output wire [4:0] coords
    );

 wire [31:0] word;
 
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
 
 
 
///### Letter selection 

// debounce and spot btn1
debouncer debouncer_btnE_inst(
    .switchIn(btn_E),
    .clk(clk),
    .reset(1'b0),
    .debounceout(btnE_debounced)
);

spot spot_btn1_inst(
    .clk(clk),
    .spot_in(btnE_debounced),
    .spot_out(btnE_processed)
);

// debounce and spot btn1
debouncer debouncer_btnW_inst(
    .switchIn(btn_W),
    .clk(clk),
    .reset(1'b0),
    .debounceout(btnW_debounced)
);

spot spot_btnW_inst(
    .clk(clk),
    .spot_in(btnW_debounced),
    .spot_out(btnW_processed)
);

eastWestShifter #(.max_index(4'd3)) eastWestShifter_inst (
.clk(clk),
.reset(reset),
.btn_E(btnE_processed),
.btn_W(btnW_processed),
.index(index)
);


reg [7:0] letter;

always @(*) begin
    case(index)
        4'd0 : letter = letter_1; 
        4'd1 : letter = letter_2;
        4'd2 : letter = letter_3;
        4'd3 : letter = letter_4;
        default : letter = 8'h00;
    endcase
end

wire [7:0] keyboardHex_n;
wire [7:0] keyboardHex_m;

 hexToCoords hexToCoords_inst(
.letter(letter),    
.m_coords(m_coords),
.n_coords(n_coords)
);

toKeyboardHexEncoder toKeyboardHexEncoder_n(
.bcd(n_coords),
.keyboardHex(keyboardHex_n)
); 

toKeyboardHexEncoder toKeyboardHexEncoder_m(
.bcd(m_coords),
.keyboardHex(keyboardHex_m)
); 


assign word = {letter_1,letter_2, letter_3, letter_4};


reg [31:0] displayValues;
wire [7:0] letter_encrypted;

always @(posedge clk) begin
    if (reset) begin
        displayValues <= 32'h00000000;
    end
    else begin
        case(view)
            1'b0: displayValues <= word;
            1'b1: displayValues <= {letter_encrypted, 8'h00, keyboardHex_m, keyboardHex_n};
            default: displayValues <= {8'h00, 8'h00, 8'h00, 8'h00};
        endcase
    end
end

polybiusEncrypterOptions polybiusEncrypterOptions_inst(
.encrypterSelector(encrypterSelector),
.m_coords(m_coords),
.n_coords(n_coords),
.letter_encrypted(letter_encrypted),
.extract_coords(coords)
);

 displayDriver displayDriver_inst(
.clk(clk), 
.ssdAnode(ssdAnode),
.ssdCathode(ssdCathode),
.displayValues(displayValues) 
);

endmodule


