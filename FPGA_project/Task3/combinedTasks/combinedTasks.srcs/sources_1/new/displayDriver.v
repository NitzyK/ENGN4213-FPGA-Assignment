`timescale 1ns / 1ps

module displayDriver(
    input wire clk, 
    input wire [31:0] displayValues,
    output wire [6:0] ssdAnode,
    output reg [3:0] ssdCathode
);
////////////////////////////////Overview/////////////////////////////////////////////////////

// this module takes in a 32 bit value (a 4 letter word) and displays it to 
// the 4x ssd by scanning 1 ssd at a time. 

////////////////////////////////Internal Signal Declaration//////////////////////////////////
reg [3:0] activeDisplay = 4'b0111;

////////////////////////////////scanning SSD ////////////////////////////////////////////////   
clockDividerHB #( .THRESHOLD(125_000)) clk_div_inst ( .clk(clk), .reset(1'b0), .dividedClk(), .enable(1'b1), .beat(beat) );
    
always @(posedge clk) begin
    if (beat) activeDisplay <= {activeDisplay[2:0], activeDisplay[3]}; // Shift left and wrap around
    end

reg [7:0] ssdValue;
always @(*) begin
    case(activeDisplay)
        4'b0111 : begin
             ssdValue = displayValues[31:24]; // 1st SSD
             ssdCathode = 4'b0111;
        end
        4'b1011 : begin 
             ssdValue = displayValues[23:16]; // 2nd SSD
             ssdCathode = 4'b1011;
        end
        4'b1101 : begin 
             ssdValue = displayValues[15:8]; // 3rd SSD
             ssdCathode = 4'b1101; 
        end
        4'b1110 : begin 
             ssdValue = displayValues[7:0]; // 4th SSD
             ssdCathode = 4'b1110;
        end
        default : begin
            ssdValue = 8'h00; // undefined
            ssdCathode = 4'b1111;
        end
    endcase
end

////////////////////////////////Instantiate SSD decoder ////////////////////////////////////////////////   
ssdDecoder ssdDecoder_inst(
    .hex_value(ssdValue),
    .ssd(ssdAnode)
);

endmodule
