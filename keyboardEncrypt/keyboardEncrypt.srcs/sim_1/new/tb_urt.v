`timescale 1ns / 1ps

module uart_top_tb;

    // Inputs
    reg clk = 0;
    reg reset = 0;
    reg rx = 1;      // Not used here
    reg send = 0;

    // Outputs
    wire tx;
    wire [7:0] led;
    wire data_valid_led;
    wire [1:0] stateled;

    // Instantiate UART top module
    uart_top uut (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .send(send),
        .tx(tx),
        .led(led),
        .data_valid_led(data_valid_led),
        .stateled(stateled)
    );

    // Clock generation: 100 MHz = 10 ns period
    always #5 clk = ~clk;

    initial begin
        $display("==== UART TX Only Testbench ====");
        $dumpfile("uart_tx_only_tb.vcd");
        $dumpvars(0, uart_top_tb);

        // Reset pulse
        reset <= 1;
        #100;
        reset <= 0;

        // Wait for system to stabilize
        #20000;

        // Send one 1-clock-cycle pulse
        @(posedge clk);
        send <= 1;
        @(posedge clk);
        send <= 0;

        // Wait for UART to transmit all 4 bytes
        // At 115200 baud: 10 bits/byte = ~86.8 µs per byte
        //     9600
        // 4 bytes ≈ 350 µs
        #4_000_000;  // wait 500 us

        $display("==== Testbench Complete ====");
        $finish;
    end

endmodule
