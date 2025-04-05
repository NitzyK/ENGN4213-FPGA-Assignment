module ssDisplayDriver(
    input wire clk,
//    input wire [3:0] enableMask,            // Which displays are enabled
//    input wire [27:0] displayValues,        // 4 digits: {disp3, disp2, disp1, disp0}
    output reg [6:0] ssdAnode,             // Segment control
    output reg [3:0] ssdCathode             // Digit selector (active low)
);

reg displayValues = 28'b101010101010101010101010101;
reg enableMask = 4'b1010;
// Beat signal from clock divider
wire beat;

clockDividerHB clk_div_inst (
    .clk(clk),
    .reset(1'b0),
    .dividedClk(),      // Not used
    .enable(1'b1),
    .beat(beat)     
);

// Counter to cycle through displays
reg [1:0] displayIndex;

always @(posedge beat) begin
    displayIndex <= displayIndex + 1;
end

always @(*) begin
    // Default to all off
    ssdCathode = 4'b1111;
    ssdAnode = 4'd10; // undefined

    case (displayIndex)
        2'd0: begin
            if (enableMask[0]) begin
                ssdAnode = displayValues[6:0];
                ssdCathode = 4'b1110;
            end
        end
        2'd1: begin
            if (enableMask[1]) begin
                ssdAnode = displayValues[13:7];
                ssdCathode = 4'b1101;
            end
        end
        2'd2: begin
            if (enableMask[2]) begin
                ssdAnode = displayValues[20:14];
                ssdCathode = 4'b1011;
            end
        end
        2'd3: begin
            if (enableMask[3]) begin
                ssdAnode = displayValues[27:21];
                ssdCathode = 4'b0111;
                displayIndex = 2'd0;
            end
        end
    endcase
end


endmodule
