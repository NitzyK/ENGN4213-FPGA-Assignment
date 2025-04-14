//`timescale 1ns / 1ps
// //////////////////////////////////////////////////////////////////////////////////
// // Company: 
// // Engineer: 
// // 
// // Create Date: 04.04.2025 15:38:02
// // Design Name: 
// // Module Name: PS2_data_capture
// // Project Name: 
// // Target Devices: 
// // Tool Versions: 
// // Description: 
// // 
// // Dependencies: 
// // 
// // Revision:
// // Revision 0.01 - File Created
// // Additional Comments:
// // 
// //////////////////////////////////////////////////////////////////////////////////
 
 
// module PS2_data_capture(
// input wire clk,
// input wire PS2_data_in,
// input wire PS2_clk,
// output reg [10:0] PS2_data_out
//     );
     
// reg [10:0] data_buffer;
// reg [3:0] counter;
// reg [1:0] PS2_clk_sync;
// wire ps2_clk_negedge;
 
// assign PS2_clk_negedge = (PS2_clk_sync == 2'b10);
 
// always @(posedge clk) begin 
//     PS2_clk_sync[1:0] <= {PS2_clk_sync[0] ,PS2_clk};
     
// end
 
// spot spot_ps2_clk (
// .clk(clk),
// .spot_in(ps2_clk_negedge),
// .spot_out(ps2_clk_negedge_delayed)
// );
     
     
// always @(negedge ps2_clk_negedge_delayed)begin 
 
     
//     data_buffer <= {data_buffer[10:1], PS2_data_in};
     
     
//     if (counter == 4'd10) begin 
//         PS2_data_out <= data_buffer;
//         data_buffer <= 11'b0;
//         counter <= 4'b0;
//         end
//     else counter <= counter +1;
// end
 
 
     
// endmodule

`timescale 1ns / 1ps

module PS2_data_capture(
    input wire clk,
    input wire PS2_data_in,
    input wire PS2_clk,
    output reg [10:0] PS2_data_out,
    output reg dv
);

// Internal registers
reg [10:0] data_buffer = 11'd0;
reg [3:0] counter = 4'd0;
reg [1:0] PS2_clk_sync = 2'b11;
wire ps2_clk_negedge;
wire ps2_clk_negedge_delayed;

// Detect falling edge of PS2_clk
assign ps2_clk_negedge = (PS2_clk_sync == 2'b10);

// Synchronize PS2_clk to system clock
always @(posedge clk) begin
    PS2_clk_sync <= {PS2_clk_sync[0], PS2_clk};
end


spot spot_ps2_clk (
    .clk(clk),
    .spot_in(ps2_clk_negedge),
    .spot_out(ps2_clk_negedge_delayed)
);

// Capture data on delayed falling edge
always @(posedge clk) begin
    if (ps2_clk_negedge_delayed) begin
        data_buffer <= {PS2_data_in, data_buffer[10:1]}; // Shift right, insert new bit

        if (counter == 4'd10) begin
            PS2_data_out <= {PS2_data_in, data_buffer[10:1]}; // Complete frame
            dv <=1;
            counter <= 0;
        end else begin
            counter <= counter + 1;
            dv <=0;
        end
    end
end

endmodule
