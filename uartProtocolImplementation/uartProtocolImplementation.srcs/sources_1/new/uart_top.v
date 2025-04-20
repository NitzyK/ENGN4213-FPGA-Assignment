//module uart_top (
//    input wire clk,             // 100 MHz system clock
//    input wire reset,           // Active-high reset
//    input wire rx,              // UART receive line
//    input wire send,
//    output wire tx,             // UART transmit line
//    output wire [7:0] led,     // Show received data on LEDs (optional)
//    output wire data_valid_led  // Show valid data flag (optional)
////    output  wire [1:0] stateled

//);

//    // Wires to connect RX to TX
//    wire [7:0] rx_data;
//    wire rx_data_valid;
//    reg [7:0] tx_data = 8'h3C;//u
//    wire busy;
    
//    debouncer debounce_inst(
//    .clk(clk),
//    .switchIn(send),
//    .debounceout(send_deb),
//    .reset(1'b0)
//    );
    
//    spot spot_inst(
//    .clk(clk),
//    .spot_in(send_deb),
//    .spot_out(send_spot)
//    );
    
    
    
//    // Instantiate UART Receiver
//    uart_rx uart_receiver (
//        .clk(clk),
//        .rx(rx),
//        .data(rx_data),
//        .data_valid(rx_data_valid),
//        .reset(1'b0)
//    );

//    // Instantiate UART Transmitter
//    uart_tx uart_transmitter (
//        .clk(clk),
//        .data_in(tx_data),
//        .send(send_spot),
//        .tx(tx),
//        .busy(busy),
//        .reset(reset)
//    );

//    // Control logic to send received data back out
//    always @(posedge clk or posedge reset) begin
//        if (reset) begin
//            tx_data <= 8'h33; //h
            
//        end
//    end

//    // Optional: output the received data to LEDs
//    assign led = rx_data;
//    assign data_valid_led = rx_data_valid;

//endmodule

module uart_top (
    input wire clk,             // 100 MHz system clock
    input wire reset,           // Active-high reset
    input wire rx,              // UART receive line
    input wire send,            // Trigger to send 32-bit word
    output wire tx,             // UART transmit line
    output wire [7:0] led,      // Show received data on LEDs (optional)
    output wire data_valid_led, // Show valid data flag (optional)
    output wire sending_led,      // LED to show when sending chunks
    output wire [6:0] ssdAnode,
    output wire [3:0] ssdCathode
);

    // Wires to connect RX to TX
    wire [7:0] rx_data;
//    wire[7:0] rx_data_swap;
    wire rx_data_valid;
    wire busy;
//    wire [31:0] data32  = 32'h4333341c; // 32-bit data to transmit
    wire [255:0] data32 = 256'h002b002b003400340033003300430043001b001b002a002a003c003c4333341c;
    reg [31:0] databuffer;
    
    
    
    // Internal registers for chunk transmission
    reg [7:0] tx_data;
    reg [4:0] chunk_count = 4'b0;
    reg sending_chunks = 1'b0;
    reg [255:0] data_buffer;
    reg send_enable = 0;
    reg beat_out;
    reg beat_1;
    // Debouncer and single-pulse generator for send signal
    wire send_deb;
    wire send_spot;
    
   
//   assign rx_data_swap = {rx_data[0],rx_data[1],
//    rx_data[2],
//    rx_data[3], rx_data[4], rx_data[5], rx_data[6], rx_data[7]};
    
    debouncer debounce_inst(
        .clk(clk),
        .switchIn(send),
        .debounceout(send_deb),
        .reset(1'b0)
    );
    
    spot spot_inst(
        .clk(clk),
        .spot_in(send_deb),
        .spot_out(send_spot)
    );
    
    // Instantiate UART Receiver
    uart_rx uart_receiver (
        .clk(clk),
        .rx(rx),
        .data(rx_data),
        .data_valid(rx_data_valid),
        .reset(1'b0)
        
    );
    
        clockDividerHB #(
        .THRESHOLD(27_778_000)
    ) pulse_send (
        .clk(clk),
        .enable(send_enable),
        .reset(reset),
        .beat(beat),
        .dividedClk()        
    );

    // Instantiate UART Transmitter
    uart_tx uart_transmitter (
        .clk(clk),
        .data_in(tx_data),
        .send(beat_out),
        .tx(tx),
        .busy(busy),
        .reset(reset),
        .sending(sending)
       
    );
    
    
   displayDriver ssd_Driver (
   .clk(clk),
   .displayValues(databuffer),
   .ssdAnode(ssdAnode),
   .ssdCathode(ssdCathode)
   );

    // Control logic to send 32-bit word in 8-bit chunks
//    always @(posedge clk or posedge reset) begin
//        if (reset) begin
//            tx_data <= 8'h00;
//            chunk_count <= 2'b00;
//            sending_chunks <= 1'b0;
//            data_buffer <= 32'h00000000;
//        end else begin
//            // Latch new data when send is pressed
//            if (send_spot && !sending_chunks) begin
//                data_buffer <= data32;
//                chunk_count <= 2'b00;
//                sending_chunks <= 1'b1;
//            end
            
//            // Send next chunk when transmitter is ready
//            if (sending_chunks && !busy && !sending) begin
//                case (chunk_count)
//                    2'b00: tx_data <= data_buffer[7:0];
//                    2'b01: tx_data <= data_buffer[15:8];
//                    2'b10: tx_data <= data_buffer[23:16];
//                    2'b11: tx_data <= data_buffer[31:24];
//                endcase
                
//                if (chunk_count == 2'b11) begin
//                    sending_chunks <= 1'b0;
//                end
                
//                chunk_count <= chunk_count + 1;
//            end
//        end
//    end

 always @(posedge clk or posedge reset) begin
 if (reset) begin
    databuffer <= 0;
 end
 else begin
 if(rx_data_valid) databuffer <= { databuffer[23:0],rx_data};
 
 end
 end
    

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            tx_data <= 8'h00;
            chunk_count <= 2'b00;
            sending_chunks <= 1'b0;
            data_buffer <= 32'h00000000;
            send_enable <=0;
            
            end
            
            
            else begin
            beat_out <= beat_1;
            beat_1 <= beat;
            
            
            if(send_spot && !send_enable) begin
            send_enable <=1;
                data_buffer <= data32;
                chunk_count <= 2'b00;
            end
            
            
            if(beat ) begin 
                tx_data <= data_buffer[8*chunk_count +: 8];
             if (!(&chunk_count)) begin 
                chunk_count <= chunk_count +1;   
                    end
              else begin
              chunk_count <= 0;   
              send_enable <=0;
              
              end    
                   
           
                
            
            end 
            
            

           

            
            end
            
     end
    // Optional: output the received data to LEDs
    assign led = {chunk_count, 3'b0};
    assign data_valid_led = rx_data_valid;
    assign sending_led = sending_chunks;

endmodule
