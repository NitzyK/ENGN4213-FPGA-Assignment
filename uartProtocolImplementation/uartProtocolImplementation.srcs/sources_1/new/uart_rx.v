//module uart_rx #(
//    parameter integer BAUD_DIVIDER = 100_000
//)(
//    input wire clk,
//    input wire reset,
//    input wire rx,
//    output reg [7:0] data_out,
//    output reg data_ready
//);

//    // Internal signals
//    wire beat;    
//    // Instantiate clock divider for optimal sampling
//    clockDividerHB #(
//        .THRESHOLD(BAUD_DIVIDER/2)  // Half period for mid-bit sampling
//    ) baud_gen (
//        .clk(clk),
//        .enable(1'b1),
//        .reset(reset),
//        .dividedClk(),
//        .beat(beat)
//    );
    
//    // State definitions
//    localparam IDLE         = 3'b000;
//    localparam RX_START_BIT = 3'b001;
//    localparam RX_DATA_BITS = 3'b010;
//    localparam RX_STOP_BIT  = 3'b011;
//    localparam CLEANUP      = 3'b100;
    
//    // Metastability protection registers
//    reg rx_sync1 = 1'b1;
//    reg rx_sync2 = 1'b1;
//    reg rx_sync3 = 1'b1;  // Third stage for edge detection
    
//    // State machine registers
//    reg [2:0] state = IDLE;
//    reg [2:0] bit_index = 0;
//    reg [7:0] rx_data = 0;
//    reg sample_now = 0;
    
//    // Synchronize the RX input with 3-stage synchronizer
//    always @(posedge clk) begin
//        rx_sync1 <= rx;
//        rx_sync2 <= rx_sync1;
//        rx_sync3 <= rx_sync2;
//    end
    
//    // Edge detection for start bit
//    wire rx_falling_edge = (rx_sync3 == 1'b1) && (rx_sync2 == 1'b0);
    
//    // UART receive state machine
//    always @(posedge clk or posedge reset) begin
//        if (reset) begin
//            state <= IDLE;
//            bit_index <= 0;
//            rx_data <= 0;
//            data_out <= 0;
//            data_ready <= 0;
//            sample_now <= 0;
//        end else begin
//            // Default assignments
//            data_ready <= 0;
//            sample_now <= 0;
            
//            // The beat signal marks optimal sampling points
//            if (beat) begin
//                sample_now <= 1;
//            end
            
//            if (sample_now) begin
//                case (state)
//                    IDLE: begin
//                        if (rx_falling_edge) begin
//                            state <= RX_START_BIT;
//                        end
//                    end
                    
//                    RX_START_BIT: begin
//                        if (rx_sync2 == 1'b0) begin  // Confirm start bit
//                            state <= RX_DATA_BITS;
//                            bit_index <= 0;
//                        end else begin               // False start
//                            state <= IDLE;
//                        end
//                    end
                    
//                    RX_DATA_BITS: begin
//                        rx_data[bit_index] <= rx_sync2;  // Sample at optimal point
                        
//                        if (bit_index < 7) begin
//                            bit_index <= bit_index + 1;
//                        end else begin
//                            state <= RX_STOP_BIT;
//                        end
//                    end
                    
//                    RX_STOP_BIT: begin
//                        if (rx_sync2 == 1'b1) begin  // Valid stop bit
//                            data_out <= rx_data;
//                            data_ready <= 1;
//                        end
//                        state <= CLEANUP;
//                    end
                    
//                    CLEANUP: begin
//                        state <= IDLE;
//                    end
                    
//                    default: state <= IDLE;
//                endcase
//            end
//        end
//    end
    
//endmodule


module uart_rx 
  (
   input    wire    i_Clock,
   input    wire    i_Rx_Serial,
   output  wire     o_Rx_DV,
   output wire [7:0] o_Rx_Byte
   );
  parameter CLKS_PER_BIT = 10_416;
  parameter s_IDLE         = 3'b000;
  parameter s_RX_START_BIT = 3'b001;
  parameter s_RX_DATA_BITS = 3'b010;
  parameter s_RX_STOP_BIT  = 3'b011;
  parameter s_CLEANUP      = 3'b100;
   
  reg           r_Rx_Data_R = 1'b1;
  reg           r_Rx_Data   = 1'b1;
   
  reg [7:0]     r_Clock_Count = 0;
  reg [2:0]     r_Bit_Index   = 0; //8 bits total
  reg [7:0]     r_Rx_Byte     = 0;
  reg           r_Rx_DV       = 0;
  reg [2:0]     r_SM_Main     = 0;
   
  // Purpose: Double-register the incoming data.
  // This allows it to be used in the UART RX Clock Domain.
  // (It removes problems caused by metastability)
  always @(posedge i_Clock)
    begin
      r_Rx_Data_R <= i_Rx_Serial;
      r_Rx_Data   <= r_Rx_Data_R;
    end
   
   
  // Purpose: Control RX state machine
  always @(posedge i_Clock)
    begin
       
      case (r_SM_Main)
        s_IDLE :
          begin
            r_Rx_DV       <= 1'b0;
            r_Clock_Count <= 0;
            r_Bit_Index   <= 0;
             
            if (r_Rx_Data == 1'b0)          // Start bit detected
              r_SM_Main <= s_RX_START_BIT;
            else
              r_SM_Main <= s_IDLE;
          end
         
        // Check middle of start bit to make sure it's still low
        s_RX_START_BIT :
          begin
            if (r_Clock_Count == (CLKS_PER_BIT-1)/2)
              begin
                if (r_Rx_Data == 1'b0)
                  begin
                    r_Clock_Count <= 0;  // reset counter, found the middle
                    r_SM_Main     <= s_RX_DATA_BITS;
                  end
                else
                  r_SM_Main <= s_IDLE;
              end
            else
              begin
                r_Clock_Count <= r_Clock_Count + 1;
                r_SM_Main     <= s_RX_START_BIT;
              end
          end // case: s_RX_START_BIT
         
         
        // Wait CLKS_PER_BIT-1 clock cycles to sample serial data
        s_RX_DATA_BITS :
          begin
            if (r_Clock_Count < CLKS_PER_BIT-1)
              begin
                r_Clock_Count <= r_Clock_Count + 1;
                r_SM_Main     <= s_RX_DATA_BITS;
              end
            else
              begin
                r_Clock_Count          <= 0;
                r_Rx_Byte[r_Bit_Index] <= r_Rx_Data;
                 
                // Check if we have received all bits
                if (r_Bit_Index < 7)
                  begin
                    r_Bit_Index <= r_Bit_Index + 1;
                    r_SM_Main   <= s_RX_DATA_BITS;
                  end
                else
                  begin
                    r_Bit_Index <= 0;
                    r_SM_Main   <= s_RX_STOP_BIT;
                  end
              end
          end // case: s_RX_DATA_BITS
     
     
        // Receive Stop bit.  Stop bit = 1
        s_RX_STOP_BIT :
          begin
            // Wait CLKS_PER_BIT-1 clock cycles for Stop bit to finish
            if (r_Clock_Count < CLKS_PER_BIT-1)
              begin
                r_Clock_Count <= r_Clock_Count + 1;
                r_SM_Main     <= s_RX_STOP_BIT;
              end
            else
              begin
                r_Rx_DV       <= 1'b1;
                r_Clock_Count <= 0;
                r_SM_Main     <= s_CLEANUP;
              end
          end // case: s_RX_STOP_BIT
     
         
        // Stay here 1 clock
        s_CLEANUP :
          begin
            r_SM_Main <= s_IDLE;
            r_Rx_DV   <= 1'b0;
          end
         
         
        default :
          r_SM_Main <= s_IDLE;
         
      endcase
    end   
   
  assign o_Rx_DV   = r_Rx_DV;
  assign o_Rx_Byte = r_Rx_Byte;
   
endmodule // uart_rx