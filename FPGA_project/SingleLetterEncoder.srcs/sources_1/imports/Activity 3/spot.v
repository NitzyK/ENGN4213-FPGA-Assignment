module spot (
input wire clk,
input wire spot_in,
output wire spot_out);

reg B;

always @(posedge clk) begin
    B <= spot_in;
end
assign spot_out = spot_in & ~B;

endmodule