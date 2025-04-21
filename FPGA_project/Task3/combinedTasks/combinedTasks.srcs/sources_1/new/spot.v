module spot (
input wire clk,spot_in,
output wire spot_out
);

////////////////////////////////Overview//////////////////////////////////////////////
// this module generates a single pulse on the transition of an input signal

////////////////////////////////Internal Signal Declaration//////////////////////////
reg B;

always @(posedge clk) begin
    B <= spot_in;
end
assign spot_out = spot_in & ~B;

endmodule