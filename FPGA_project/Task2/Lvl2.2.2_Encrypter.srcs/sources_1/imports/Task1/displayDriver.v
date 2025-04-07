    `timescale 1ns / 1ps
    
    module displayDriver(
    input wire clk, 
    output wire [6:0] ssdAnode,
    output reg [3:0] ssdCathode,
    input wire [31:0] displayValues 
        );
       
            clockDividerHB2 #(.THRESHOLD(125_000)) clk_div_inst (
            .clk(clk),
            .reset(1'b0),
            .dividedClk(),
            .enable(1'b1),
            .beat(beat)     
        );
        
    
    
    
    reg [3:0] activeDisplay = 4'b0111;
        
    always @(posedge clk) begin
        if (beat) activeDisplay <= {activeDisplay[2:0], activeDisplay[3]}; // Shift left and wrap around
        end
    
    // 3. Define the behavior for each display using a case structure
    reg [7:0] ssdValue;
    always @(*) begin
        case(activeDisplay)
            4'b0111 : begin
                 ssdValue = displayValues[31:24]; // 1st digit of number '37'
                 ssdCathode = 4'b0111;
            end
            4'b1011 : begin 
                 ssdValue = displayValues[23:16]; // 2nd digit of number '37' //CHANNGE
                 ssdCathode = 4'b1011;
            end
            4'b1101 : begin 
                 ssdValue = displayValues[15:8]; // 2nd digit of number '37' //CHANGE
                 ssdCathode = 4'b1101; 
            end
            4'b1110 : begin 
                 ssdValue = displayValues[7:0]; // 2nd digit of number '37' //CHANGE
                 ssdCathode = 4'b1110;
            end
            default : begin
                ssdValue = 8'h31; // undefined - should not occur
                ssdCathode = 4'b1111;
            end
        endcase
    end
    
    // 5. Instantiate the seven segment decoder
    sevenSegmentDisplayDecoder sevSegDec_inst(
        .hex_value(ssdValue),
        .ssd(ssdAnode)
    );
    endmodule
