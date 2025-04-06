`timescale 1ns / 1ps

module SingleLetterEncoder_top(
    input wire clk, reset, view,
    input wire btn_1,
    output wire tap,
    output wire [1:0] counter, 
    output wire [2:0] n_coords, 
    output wire [2:0] m_coords,
    output wire [2:0] stateLED
    );

debouncer debouncer_btn_1(
    .switchIn(btn_1),
    .clk(clk),
    .reset(1'b0),
    .debounceout(btn_1_debounced)
);

spot spot_btn_1(
    .clk(clk),
    .spot_in(btn_1_debounced),
    .spot_out(tap)
);

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


