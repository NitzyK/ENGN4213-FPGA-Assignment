module uart_rx (
    input wire clk,          
    input wire reset,     
    input wire rx,      // Serial input data line
    output reg [7:0] data,   
    output reg data_valid   
);


parameter CLKS_PER_BIT = 10416;    
parameter CLKS_PER_HALF_BIT = CLKS_PER_BIT/2;  // For detecting start bit

parameter [2:0] IDLE         = 3'b000;
parameter [2:0] START_BIT     = 3'b001;
parameter [2:0] RECEIVE_DATA = 3'b010;
parameter [2:0] STOP_BIT      = 3'b011;
parameter [2:0] DATA_VALID    = 3'b100;

// Internal registers
reg [3:0] bit_index;       
reg [15:0] clk_counter;    
reg [7:0] data_reg;        
reg [2:0] current_state, next_state = IDLE;

//Timing Logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        clk_counter <= 0;
    end else begin
        case (current_state)
            IDLE: clk_counter <= 0;
            
            START_BIT: begin
                if (clk_counter < CLKS_PER_HALF_BIT)
                    clk_counter <= clk_counter + 1;
                else
                    clk_counter <= 0;
            end
            
            RECEIVE_DATA, STOP_BIT: begin
                if (clk_counter < CLKS_PER_BIT)
                    clk_counter <= clk_counter + 1;
                else
                    clk_counter <= 0;
            end
            
            default: clk_counter <= 0;
        endcase
    end
end


// State Transition Logic

always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= IDLE;
    end else begin
        current_state <= next_state;
    end
end

always @(*) begin
    next_state = current_state; // Default: stay in current state
    
    case (current_state)
        IDLE: begin
            if (rx == 1'b0)  // Start bit detected
                next_state = START_BIT;
        end
        
        START_BIT: begin
            if (clk_counter == CLKS_PER_HALF_BIT) begin
                if (rx == 1'b0) // Valid start bit
                    next_state = RECEIVE_DATA;
                else                // False start
                    next_state = IDLE;
            end
        end
        
        RECEIVE_DATA: begin
            if (clk_counter == CLKS_PER_BIT && bit_index == 7)
                next_state = STOP_BIT;
        end
        
        STOP_BIT: begin
            if (clk_counter == CLKS_PER_BIT) begin
                if (rx == 1'b1) // Valid stop bit
                    next_state = DATA_VALID;
                else                  // Framing error
                    next_state = IDLE;
            end
        end
        
        DATA_VALID: begin
            next_state = IDLE; // Always return to IDLE
        end
    endcase
end


// Output  Logic

always @(posedge clk or posedge reset) begin
    if (reset) begin
        data <= 8'b0;
        data_valid <= 1'b0;
        data_reg <= 8'b0;
        bit_index <= 4'b0;
    end else begin
        // Default outputs
        data_valid <= 1'b0;
        
        case (current_state)
            IDLE: begin
                bit_index <= 0;
                data_reg <= 0;
            end
            
            RECEIVE_DATA: begin
                if (clk_counter == CLKS_PER_BIT) begin
                    data_reg[bit_index] <= rx;
                    bit_index <= bit_index + 1;
                end
            end
            
            STOP_BIT: begin
                if (clk_counter == CLKS_PER_BIT && rx == 1'b1) begin
                    data <= data_reg; // Latch the received data
                end
            end
            
            DATA_VALID: begin
                data_valid <= 1'b1; // Pulse valid for one clock
            end
        endcase
    end
end

endmodule