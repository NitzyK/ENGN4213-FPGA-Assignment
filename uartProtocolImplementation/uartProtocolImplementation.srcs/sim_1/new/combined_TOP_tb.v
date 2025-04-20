`timescale 1ns / 1ps

module tb_uart_tx;

    // Testbench signals
    reg clk = 0;
    reg reset = 1;
    reg [7:0] data_in = 8'h55; // Example data (binary: 01010101)
    reg send = 0;
    wire tx;
    wire busy;
    wire beat;

    // Clock generation: 10ns period => 100MHz
    always #5 clk = ~clk;

    // Instantiate uart_tx
    uart_tx #(
        .BAUD_DIVIDER(10) // Use small divider for faster sim
    ) uut (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .send(send),
        .tx(tx),
        .busy(busy),
        .beat(beat)
    );

    initial begin
        // Initialize and release reset
        $display("Starting UART TX Test...");
        #20 reset = 0;

        // Wait a few cycles and send a byte
        #30 send = 1;
        #10 send = 0; // One-cycle pulse

        // Wait long enough for transmission (start + 8 data + stop bits)
        #300;

        // Send another byte
        data_in = 8'hA3;
        #50 send = 1;
        #10 send = 0;

        #300;

        $display("Test complete.");
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time=%0t | TX=%b | send=%b | busy=%b | beat=%b", 
                  $time, tx, send, busy, beat);
    end

endmodule
