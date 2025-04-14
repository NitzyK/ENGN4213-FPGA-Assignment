`timescale 1ns / 1ps

module top_tb();

// Inputs
reg clk;
reg reset;
reg btn1;
reg btnE;
reg btnW;
reg task1;
reg task2;
reg task3;
reg encrypterSelector;
reg view;
reg encrypt;

// Outputs
wire [2:0] m_coords;
wire [2:0] n_coords;
wire [2:0] stateLED;
wire [1:0] state;
wire [6:0] ssdAnode;
wire [3:0] ssdCathode;

// Instantiate the Device Under Test (DUT)
top uut (
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
    .m_coords(m_coords), 
    .n_coords(n_coords), 
    .stateLED(stateLED), 
    .state(state), 
    .ssdAnode(ssdAnode), 
    .ssdCathode(ssdCathode)
);

// Internal signals to probe
wire [31:0] T1_displayValues;
wire [31:0] T2_displayValues;
wire [7:0] T1_letter;
wire [15:0] PS2_1;

// Assign internal signals (for simulation visibility only)
assign T1_displayValues = uut.T1_displayValues;
assign T2_displayValues = uut.T2_displayValues;
assign T1_letter = uut.T1_letter;
assign PS2_1 = uut.PS2_1;

// Generate a clock 
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 100MHz clock
end

// Test procedure
initial begin
    // Initialize inputs
    reset = 1;
    btn1 = 0;
    btnE = 0;
    btnW = 0;
    task1 = 0;
    task2 = 0;
    task3 = 0;
    encrypterSelector = 0;
    view = 0;
    encrypt = 0;
    
    // Wait for global reset
    #100;
    reset = 0;
    
    // TEST TASK 1
    #20;
    $display("Testing TASK 1 mode");
    task1 = 1;
    task2 = 0;
    task3 = 0;
    
    // Wait for state machine to update
    #20;
    $display("Current state: %b", state);
    
    // Test coordinate generation
    btn1 = 1;
    #20;
    btn1 = 0;
    #20;
    btn1 = 1;
    #20;
    btn1 = 0;
    #20;
    
    // Check the values after coordinates are generated
    $display("Task 1 - T1_coordinates: %h", uut.T1_coordinates);
    $display("Task 1 - T1_letter: %h", T1_letter);
    $display("Task 1 - PS2_1: %h", PS2_1);
    $display("Task 1 - T1_coordinatesPS2: %h", uut.T1_coordinatesPS2);
    $display("Task 1 - Display Values (view=0): %h", T1_displayValues);
    
    // Change to view mode
    view = 1;
    #20;
    $display("Task 1 - Display Values (view=1): %h", T1_displayValues);
    
    // TEST TASK 2
    #100;
    $display("\nTesting TASK 2 mode");
    task1 = 0;
    task2 = 1;
    task3 = 0;
    view = 0;
    
    // Wait for state machine to update
    #20;
    $display("Current state: %b", state);
    
    // Check the initial values
    $display("Task 2 - wordLetters: %h", uut.wordLetters);
    $display("Task 2 - T2_coordinates: %h", uut.T2_coordinates);
    $display("Task 2 - Display Values (mode=000): %h", T2_displayValues);
    
    // Change view mode
    view = 1;
    #20;
    $display("Task 2 - Display Values (mode=001): %h", T2_displayValues);
    
    // Test coordinate decryption & encryption
    encrypt = 1;
    view = 0;
    #20;
    $display("Task 2 - Display Values (mode=010): %h", T2_displayValues);
    
    view = 1;
    #20;
    $display("Task 2 - Display Values (mode=011): %h", T2_displayValues);
    
    // Test with different encrypter
    encrypterSelector = 1;
    view = 0;
    #20;
    $display("Task 2 - Display Values (mode=110): %h", T2_displayValues);
    
    view = 1;
    #20;
    $display("Task 2 - Display Values (mode=111): %h", T2_displayValues);
    
    // Look at specific signals around the issue
    $display("\nDEBUGGING KEY SIGNALS");
    $display("wordLetters_encrypted: %h", uut.wordLetters_encrypted);
    $display("T2_coordinates_encrypted: %h", uut.T2_coordinates_encrypted);
    
    // Check Task 1 specific connections
    task1 = 1;
    task2 = 0;
    #20;
    $display("\nTask 1 DEBUG");
    $display("toPS2_1coordinates: %h", uut.toPS2_1coordinates);
    $display("PS2_1: %h", PS2_1);
    $display("T1_letter from polybiusSquare: %h", T1_letter);
    
    // Check the signals that feed into the final display mux
    $display("\nDISPLAY MUX SIGNALS");
    $display("state: %b", state);
    $display("taskDisplayValues: %h", uut.taskDisplayValues);
    
    $finish;
end

// Monitor important signals continuously
initial begin
    $monitor("Time=%0t, State=%b, T1_displayValues=%h, T2_displayValues=%h", 
             $time, state, T1_displayValues, T2_displayValues);
end

endmodule