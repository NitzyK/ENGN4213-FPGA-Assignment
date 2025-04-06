`timescale 1ns / 1ps

module top(

input wire clk,
input wire reset,
input wire btn_E,
input wire btn_W,
output wire [3:0] index 
    );



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



eastWestShifter eastWestShifter_inst (
.clk(clk),
.reset(reset),
.btn_E(btnE_processed),
.btn_W(btnW_processed),
.index(index)
);
endmodule
