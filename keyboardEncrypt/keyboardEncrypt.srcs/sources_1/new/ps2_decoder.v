`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2025 11:19:31
// Design Name: 
// Module Name: ps2_decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ps2_decoder(
    input clk,
    input [10:0] ps2_data_in,
    input dv,
    input type_enable,
    output reg [7:0] scan_code,
    output reg is_extended,
    output reg is_break,
    output reg dv_dec
);

    reg  break_flag = 0;
    reg extended_flag = 0;

    always @(posedge clk) begin
        dv_dec <= 0;
    
        if (dv && type_enable) begin // Start and stop bits valid            
            case (ps2_data_in[8:1]) // extract 8-bit data
                8'hE0: extended_flag <= 1;
                8'hF0: break_flag <= 1;
                default: begin
                    scan_code <= ps2_data_in[8:1];
                    is_extended <= extended_flag;    
                    is_break <= break_flag;                
                    break_flag <= 0;
                    extended_flag <= 0;
                    dv_dec <= 1;
                end
            endcase
            
        end
    end
endmodule

