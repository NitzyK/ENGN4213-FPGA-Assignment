`timescale 1ns / 1ps

module timedDataEncoder_top(
    input wire clk,reset, btn1,
    output wire [2:0] m_coords,
    output wire [2:0] n_coords,
    output wire [2:0] stateLED,
    output wire [1:0] counter,
    output wire [6:0] ssdAnode,
    output wire [3:0] ssdCathode
    );

wire btn1_debounced;
wire btn1_processed;

// debounce and spot btn1
debouncer debouncer_btn1_inst(
    .switchIn(btn1),
    .clk(clk),
    .reset(1'b0),
    .debounceout(btn1_debounced)
);

spot spot_btn1_inst(
    .clk(clk),
    .spot_in(btn1_debounced),
    .spot_out(btn1_processed)
);

coordinatesGenerator coordinatesGenerator_inst(
.clk(clk),
.reset(reset),
.btn_1(btn1_processed),
.n_coords(n_coords),
.m_coords(m_coords),
.stateLED(stateLED),
.counter(counter)
);

wire [7:0] keyboardHex_n;
wire [7:0] keyboardHex_m;
wire [31:0] displayValues;
wire [7:0] letter;

toKeyboardHexEncoder toKeyboardHexEncoder_n(
.bcd(n_coords),
.keyboardHex(keyboardHex_n)
); 

toKeyboardHexEncoder toKeyboardHexEncoder_m(
.bcd(m_coords),
.keyboardHex(keyboardHex_m)
); 

polybiusEncoder polybiusEncoder_inst(
.n_coords(n_coords),
.m_coords(m_coords),
.letter(letter)
);


assign displayValues = {letter, 8'h00, keyboardHex_m, keyboardHex_n};

displayDriver displayDriver_inst(
.clk(clk), 
.ssdAnode(ssdAnode),
.ssdCathode(ssdCathode),
.displayValues(displayValues) 
);

endmodule
