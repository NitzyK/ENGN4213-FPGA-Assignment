module uart_tx #(
    parameter integer BAUD_DIVIDER = 100_000
)(
    input wire clk,
    input wire reset,
    input wire [7:0] data_in,
    input wire send,
    output reg tx = 1,
    output reg busy = 0
);
    // Baud rate generation
    wire beat;
    
    clockDividerHB #(
        .THRESHOLD(BAUD_DIVIDER)
    ) baud_gen (
        .clk(clk),
        .enable(1'b1),
        .reset(reset),
        .dividedClk(),
        .beat(beat)
    );
    
    // FSM states
    parameter [1:0] IDLE      = 2'b00;
    parameter [1:0] START_BIT = 2'b01;
    parameter [1:0] DATA_BITS = 2'b10;
    parameter [1:0] STOP_BIT  = 2'b11;
    
    reg [1:0] current_state, next_state = IDLE;
    reg [2:0] bit_count;
    reg [7:0] data_reg;
    
    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            tx <= 1'b1;
            bit_count <= 3'b0;
            data_reg <= 8'b0;
           busy <= 0;
        end 
        
        else begin
            current_state <= next_state;
            
            
            if (current_state == IDLE && send)          data_reg <= data_in; // Data latching
            if (current_state == DATA_BITS && beat)     bit_count <= bit_count + 1;
            else if (current_state != DATA_BITS)        bit_count <= 3'b0;
          
        end
    end
    
    // Transition Logic
    always @(*) begin
        
        case (current_state)
            IDLE: begin
                if (send && beat) next_state = START_BIT;
                else next_state = IDLE;
            end
            
            START_BIT: begin
                if (beat) next_state = DATA_BITS;
                else next_state = START_BIT;
            end
            
            DATA_BITS: begin
                if (beat && (bit_count == 3'd7)) next_state = STOP_BIT;
                else next_state = DATA_BITS;
                
            end
            
            STOP_BIT: begin
                if (beat) next_state = IDLE;
                else next_state = STOP_BIT;

            end
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                tx = 1'b1;
                busy = 1'b0;
            end
            
            START_BIT: begin
                tx = 1'b0;
                busy = 1'b1;
            end
            
            DATA_BITS: begin
                tx = data_reg[bit_count];
                busy = 1'b1;
            end
            
            STOP_BIT: begin
                tx = 1'b1;
                busy = 1'b1;
            end
        endcase
    end
endmodule