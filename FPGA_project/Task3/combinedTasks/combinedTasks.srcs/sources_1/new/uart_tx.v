module uart_tx #(
    parameter integer BAUD_DIVIDER = 5208
)(
    input wire clk,
    input wire reset,
    input wire [7:0] data_in,
    input wire send,
    output reg tx = 1,
    output reg busy = 0
);
    // Baud clock generation
    clockDividerHB #(
        .THRESHOLD(BAUD_DIVIDER)
    ) baud_gen (
        .clk(clk),
        .enable(1'b1),
        .reset(reset),
        .dividedClk(dividedClk),
        .beat(beat)
    );

    // FSM states
    localparam [1:0] IDLE      = 2'b00;
    localparam [1:0] START_BIT = 2'b01;
    localparam [1:0] DATA_BITS = 2'b10;
    localparam [1:0] STOP_BIT  = 2'b11;

    // Internal registers
    reg [1:0] current_state,next_state = IDLE;
    reg [2:0] bit_count = 3'd0;
    reg [7:0] data_reg = 8'd0;
    reg sending = 1'b0;
    
    
    // Latch 'send' signal until beat occurs
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            sending <= 1'b0;
        end else if (send) begin
            sending <= 1'b1;
        end else if (beat && current_state == IDLE && sending) begin
            sending <= 1'b0;
        end
    end

    // FSM state update on beat
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end else if (beat) begin
            current_state <= next_state;
        end
    end

    // FSM transition logic 
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (sending) next_state = START_BIT;
                else         next_state = IDLE;
            end

            START_BIT: begin
                next_state = DATA_BITS;
            end

            DATA_BITS: begin
                if (bit_count == 3'd7) next_state = STOP_BIT;
                else                   next_state = DATA_BITS;
            end

            STOP_BIT: begin
                next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end

    // Output and data handling (on beat)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            tx <= 1'b1;
            busy <= 1'b0;
            bit_count <= 3'd0;
            data_reg <= 8'd0;
        end else if (beat) begin
            case (current_state)
                IDLE: begin
                    tx <= 1'b1;
                    busy <= 1'b0;
                    bit_count <= 3'd0;

                    if (sending) begin
                        data_reg <= data_in;
                        busy <= 1'b1;
                    end
                end

                START_BIT: begin
                    tx <= 1'b0; // valid start bit
                    busy <= 1'b1;
                end

                DATA_BITS: begin
                    tx <= data_reg[bit_count];
                    bit_count <= bit_count + 1;
                    busy <= 1'b1;
                end

                STOP_BIT: begin
                    tx <= 1'b1;
                    busy <= 1'b1;
                end
            endcase
        end
    end

endmodule