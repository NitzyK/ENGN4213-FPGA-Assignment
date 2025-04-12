module uart_rx (
    input wire clk,
    input wire reset,           // Active-high reset
    input wire beat,            // From clockDividerHB2
    input wire rx,
    output reg [7:0] data_out,
    output reg data_ready
);
    
  // State definitions
  parameter IDLE         = 3'b000;
  parameter RX_START_BIT = 3'b001;
  parameter RX_DATA_BITS = 3'b010;
  parameter RX_STOP_BIT  = 3'b011;
  parameter CLEANUP      = 3'b100;
  
  // Metastability protection registers
  reg rx_sync1 = 1'b1;
  reg rx_sync2 = 1'b1;
  
  // State machine registers
  reg [2:0] state = IDLE;
  reg [2:0] bit_index = 0;
  reg [7:0] rx_data = 0;
  
  // Synchronize the RX input
  always @(posedge clk) begin
    rx_sync1 <= rx;
    rx_sync2 <= rx_sync1;
  end
  
  // UART receive state machine
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      bit_index <= 0;
      rx_data <= 0;
      data_out <= 0;
      data_ready <= 0;
    end else if (beat) begin  // Only advance on beat signals
      data_ready <= 0;  // Default assignment
      
      case (state)
        IDLE: begin
          if (rx_sync2 == 1'b0) begin  // Start bit detected
            state <= RX_START_BIT;
          end
        end
        
        RX_START_BIT: begin
          if (rx_sync2 == 1'b0) begin  // Still low - valid start bit
            state <= RX_DATA_BITS;
            bit_index <= 0;
          end else begin               // False start
            state <= IDLE;
          end
        end
        
        RX_DATA_BITS: begin
          rx_data[bit_index] <= rx_sync2;  // Sample the bit
          
          if (bit_index < 7) begin
            bit_index <= bit_index + 1;
          end else begin
            state <= RX_STOP_BIT;
          end
        end
        
        RX_STOP_BIT: begin
          if (rx_sync2 == 1'b1) begin  // Valid stop bit
            data_out <= rx_data;
            data_ready <= 1;
          end
          // else: framing error (could add error output)
          state <= CLEANUP;
        end
        
        CLEANUP: begin
          state <= IDLE;
        end
        
        default: state <= IDLE;
      endcase
    end
  end
  
endmodule