`timescale 1ns / 1ps

module uart_tb;

    // Clock and reset
    reg clk = 0;
    reg reset = 0;
    reg enable = 1;

    // UART TX signals
    reg [7:0] tx_data = 8'hA5;  // test byte: 10100101
    reg send = 0;
    wire tx;
    wire busy;

    // UART RX signals
    wire [7:0] rx_data;
    wire data_ready;

    // Clock divider outputs
    wire dividedClk;
    wire beat;

    // Instantiate clock divider
    clockDividerHB #(10) clkdiv (
        .clk(clk),
        .enable(enable),
        .reset(reset),
        .dividedClk(dividedClk),
        .beat(beat)
    );

    // Instantiate UART transmitter
    uart_tx tx_inst (
        .clk(clk),
        .beat(beat),
        .data_in(tx_data),
        .send(send),
        .tx(tx),
        .busy(busy)
    );

    // Instantiate UART receiver
    uart_rx rx_inst (
        .clk(clk),
        .beat(beat),
        .rx(tx),  // connect TX to RX
        .data_out(rx_data),
        .data_ready(data_ready)
    );

    // Clock generation
    always #5 clk = ~clk;  // 100 MHz

    // Test sequence
    initial begin
        $display("Starting UART TX->RX loopback test...");

        // Reset
        reset = 1;
        #20;
        reset = 0;

        // Send a byte
        #20;
        send = 1;
        #10;
        send = 0;

        // Wait for transmission and reception
        wait (data_ready == 1);
        #10;

        // Display result
        $display("Transmitted: %h", tx_data);
        $display("Received:    %h", rx_data);

        if (rx_data == tx_data) begin
            $display("Test PASSED");
        end else begin
            $display("Test FAILED");
        end

        #20;
        $finish;
    end

endmodule
