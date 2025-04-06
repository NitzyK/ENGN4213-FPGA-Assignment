`timescale 1ns / 1ps

module coordinatesGenerator_top(
    input wire clk, reset,
    input wire btn_1,
    output wire tap,// debugging
    output wire [1:0] counter, // debugging
    output wire [2:0] n_coords, 
    output wire [2:0] m_coords,
    output wire [2:0] stateLED // debugging
    );
// spot and debounce btn_1 which becomes the tap signal
//debouncer debouncer_btn_1(
//    .switchIn(btn_1),
//    .clk(clk),
//    .reset(1'b0),
//    .debounceout(btn_1_debounced)
//);

//spot spot_btn_1(
//    .clk(clk),
//    .spot_in(btn_1_debounced),
//    .spot_out(tap)
//);

// instantiate FSM which outputs the n_coords and m_coords 
FSM FSM_inst (
    .clk(clk),
    .tap(tap),
    .reset(reset),
    .n_coords(n_coords),
    .m_coords(m_coords),
    .counter(counter),
    .stateLED(stateLED)
);    

endmodule


