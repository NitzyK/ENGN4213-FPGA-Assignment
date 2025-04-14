`timescale 1ns / 1ps

module combined_TOP_tb;

    // Testbench signals
    reg clk = 0;
    reg reset = 0;
    reg rx = 1;            // idle state of UART line is high
    reg send = 0;
    wire tx;
    wire [7:0] led;
    wire data_valid;

    // Clock generation
    always #5 clk = ~clk;  // 100 MHz clock

    // Instantiate DUT
    combined_TOP uut (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .led(led),
        .data_valid(data_valid),
        .send(send),
        .tx(tx)
    );

    // UART bit-banging (simulate reception)
    task send_uart_byte(input [7:0] byte);
        integer i;
        begin
            // Start bit
            rx = 0;
            #(104160);  // 1 baud period = 10416 ns * 10 due to 10ns clock

            // Data bits (LSB first)
            for (i = 0; i < 8; i = i + 1) begin
                rx = byte[i];
                #(104160);
            end

            // Stop bit
            rx = 1;
            #(104160);
        end
    endtask

    initial begin
        $display("Starting combined_TOP simulation...");

        // Reset
        reset = 1;
        #50;
        reset = 0;

        // Simulate a rising edge on `send` (simulating debouncer + spot logic)
        #100;
        send = 1;
        #20;
        send = 0;

        // Wait for TX to finish and loop tx back into rx
        // We're assuming loopback: so feed TX into RX
        // For actual hardware loopback, tx would be physically connected to rx
        // But here we simulate RX manually as if a byte is coming in

        // Wait for a moment
        #50000;

        // Simulate RX receiving the same byte that TX was sending (0xAF)
        send_uart_byte(8'hAF);

        // Wait for data_valid
        wait(data_valid);
        #20;

        $display("Received LED value = %h", led);

        if (led == 8'hAF)
            $display("✅ Test Passed");
        else
            $display("❌ Test Failed");

        #50;
        $finish;
    end

endmodule
