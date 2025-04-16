`timescale 1ns / 1ps

module top_tb;

    // Clock parameters
    parameter CLK_PERIOD = 10; // 100MHz clock
    
    // UART parameters
    parameter BAUD_RATE = 9600;
    parameter BIT_PERIOD = 1_000_000_000/BAUD_RATE; // in ns
    
    // DUT inputs
    reg clk = 0;
    reg reset = 0;
    reg btn1 = 0;
    reg btnE = 0;
    reg btnW = 0;
    reg task1 = 0;
    reg task2 = 0;
    reg task3 = 0;
    reg encrypterSelector = 0;
    reg view = 0;
    reg encrypt = 0;
    reg [5:0] T3_coordinates;
    reg rx = 1; // Idle high for UART
    
    // DUT outputs
    wire tx;
    wire [2:0] stateLED;
    wire [1:0] state;
    wire [7:0] tx_LED;
    wire [6:0] ssdAnode;
    wire [3:0] ssdCathode;
    wire [2:0] send_counter;

    // Instantiate the DUT
    top dut (
        .clk(clk),
        .reset(reset),
        .btn1(btn1),
        .btnE(btnE),
        .btnW(btnW),
        .task1(task1),
        .task2(task2),
        .task3(task3),
        .encrypterSelector(encrypterSelector),
        .view(view),
        .encrypt(encrypt),
        .rx(rx),
        .tx(tx),
        .stateLED(stateLED),
        .state(state),
        .tx_LED(tx_LED),
        .ssdAnode(ssdAnode),
        .ssdCathode(ssdCathode),
        .send_counter(send_counter)
        //.T3_coordinates(T3_coordinates)
    );
    
    // Clock generation
    always #(CLK_PERIOD/2) clk = ~clk;
    
    // Task for sending a byte over UART rx
    task send_uart_byte;
        input [7:0] data;
        integer i;
        begin
            // Start bit
            rx = 0;
            #BIT_PERIOD;
            
            // Data bits (LSB first)
            for (i = 0; i < 8; i = i + 1) begin
                rx = data[i];
                #BIT_PERIOD;
            end
            
            // Stop bit
            rx = 1;
            #BIT_PERIOD;
        end
    endtask
    
    // Monitor tx output
    reg [7:0] received_byte;
    task receive_uart_byte;
        output [7:0] data;
        integer i;
        begin
            // Wait for start bit
            @(negedge tx);
            
            // Wait half bit period to sample in the middle
            #(BIT_PERIOD/2);
            
            // Check if it's a valid start bit
            if (tx != 0) begin
                $display("ERROR: Invalid start bit detected!");
                data = 8'hFF; // Error code
            end else begin
                #BIT_PERIOD; // Move to first data bit
                
                // Sample data bits
                for (i = 0; i < 8; i = i + 1) begin
                    data[i] = tx;
                    #BIT_PERIOD;
                end
                
                // Check stop bit
                if (tx != 1) begin
                    $display("ERROR: Invalid stop bit detected!");
                end
                
                // Wait a bit before next byte
                #(BIT_PERIOD/2);
            end
        end
    endtask
    
    // Main test sequence
    initial begin
        // Initialize with a reset pulse
        reset = 1;
        #(CLK_PERIOD * 10);
        reset = 0;
        T3_coordinates = 001001;
        #(CLK_PERIOD * 10);
        
        // Set to Task 3 (UART mode)
        task1 = 0;
        task2 = 0;
        task3 = 1;
        #(CLK_PERIOD * 100); // Allow time for state to change
        
        // Send test data via UART rx
        send_uart_byte(8'h2B); // ASCII 'F'
        #(BIT_PERIOD * 2);     // Wait between bytes
        
        // Wait for processing and response
        #(CLK_PERIOD * 1000);
        
        // Send another test byte
        send_uart_byte(8'h1C); // ASCII 'A'
        
        // Wait for processing and response
        #(CLK_PERIOD * 1000);
        
         // Send test data via UART rx
        send_uart_byte(8'h1B); // ASCII 'S'
        #(BIT_PERIOD * 2);     // Wait between bytes
        
        // Wait for processing and response
        #(CLK_PERIOD * 1000);
        
        // Send another test byte
        send_uart_byte(8'h2C); // ASCII 'T'
        
        // Wait for processing and response
        #(CLK_PERIOD * 1000);
        
        // End simulation
        #(CLK_PERIOD * 5000);
        $finish;
    end
    
    // Monitor tx output (optional, can be removed if you just want to view waveforms)
    initial begin
        forever begin
            receive_uart_byte(received_byte);
            $display("Time: %t, Received byte: 0x%h", $time, received_byte);
        end
    end
    
    // Generate VCD file for waveform viewing
    initial begin
        $dumpfile("top_tb.vcd");
        $dumpvars(0, top_tb);
    end

endmodule