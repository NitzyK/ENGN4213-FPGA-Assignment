`timescale 1ns / 1ps

module debouncer (
input wire switchIn,
input wire clk,
input wire reset,
output wire debounceout,
output wire beat);

////////////////////////////////Overview//////////////////////////////////////////////
// this module debounces a button or switch input to remove noise or unwanted signals

////////////////////////////////Internal Signal Declaration//////////////////////////
reg[2:0] pipeline;

clockDividerHB #(.THRESHOLD(3_333_333)) clockDividerHB_inst(.enable(1'b1), .reset(reset), .clk(clk), .beat(beat));

always @(posedge clk) begin
    if (beat) begin
        pipeline[0] <= switchIn;
        pipeline[1] <= pipeline[0];
        pipeline[2] <= pipeline[1];
    end
end

assign debounceout = &pipeline;

endmodule
