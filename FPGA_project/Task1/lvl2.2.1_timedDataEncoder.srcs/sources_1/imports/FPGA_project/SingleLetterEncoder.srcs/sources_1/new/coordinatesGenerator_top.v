`timescale 1ns / 1ps

module coordinatesGenerator(
    input wire clk, reset,
    input wire btn_1,
    output wire tap,// debugging
    output wire [1:0] counter, // debugging
    output wire [2:0] n_coords, 
    output wire [2:0] m_coords,
    output wire [2:0] stateLED // debugging
    );

// instantiate FSM which outputs the n_coords and m_coords 
FSM FSM_inst (
    .clk(clk),
    .tap(btn_1),
    .reset(reset),
    .n_coords(n_coords),
    .m_coords(m_coords),
    .counter(counter),
    .stateLED(stateLED)
);    

endmodule


