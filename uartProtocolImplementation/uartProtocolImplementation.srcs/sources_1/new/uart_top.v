module uart_top (
    input wire clk,             // 100 MHz system clock
    input wire reset,           // Active-high reset
    input wire rx,              // UART receive line
    input wire send,
    output wire tx,             // UART transmit line
    output wire [7:0] led,     // Show received data on LEDs (optional)
    output wire data_valid_led,  // Show valid data flag (optional)
    output  wire [1:0] stateled

);

    // Wires to connect RX to TX
    wire [7:0] rx_data;
    wire rx_data_valid;
    reg [7:0] tx_data = 8'hAF;
    wire busy;
    
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

    // Instantiate UART Transmitter
    uart_tx uart_transmitter (
        .clk(clk),
        .data_in(tx_data),
        .send(send_spot),
        .tx(tx),
        .busy(busy),
        .reset(reset)
    );

    // Control logic to send received data back out
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            tx_data <= 8'd2;
            
        end
    end

    // Optional: output the received data to LEDs
    assign led = rx_data;
    assign data_valid_led = rx_data_valid;

endmodule
