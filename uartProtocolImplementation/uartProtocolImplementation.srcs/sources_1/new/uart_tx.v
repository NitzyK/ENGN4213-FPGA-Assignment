module uart_tx(
    input wire clk,
    input wire beat,                 // From clockDividerHB2
    input wire [7:0] data_in,
    input wire send,
    output reg tx = 1,
    output reg busy = 0
);
    reg [3:0] bit_index = 0;
    reg [9:0] shift_reg = 10'b1111111111;
    reg sending = 0;

    always @(posedge clk) begin
        if (!sending && send) begin
            shift_reg <= {1'b1, data_in, 1'b0};  // stop, data[7:0], start
            bit_index <= 0;
            sending <= 1;
            busy <= 1;
            tx <= 0;  // Start bit
        end else if (sending && beat) begin
            tx <= shift_reg[0];
            shift_reg <= shift_reg >> 1;
            bit_index <= bit_index + 1;
            if (bit_index >= 9) begin  // Changed to >= for safety
                sending <= 0;
                busy <= 0;
                tx <= 1;  // Return to idle state
            end
        end
    end
endmodule