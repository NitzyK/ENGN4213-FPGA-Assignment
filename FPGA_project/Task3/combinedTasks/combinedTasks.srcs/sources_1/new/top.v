`timescale 1ns / 1ps

module top(
input wire clk,reset, btn1, btnE, btnW, task1, task2, task3,
input wire view,
output wire [2:0] m_coords,
output wire [2:0] n_coords,
output wire [2:0] stateLED,
//output wire [1:0] counter,
output wire [6:0] ssdAnode,
output wire [3:0] ssdCathode
);

wire btn1_debounced;
wire btn1_processed;
wire [2:0] task_selector;
assign task_selector = {task1, task2, task3};


// debounce and spot btn1
debouncer debouncer_btn1_inst( .switchIn(btn1), .clk(clk), .reset(1'b0), .debounceout(btn1_debounced) );
spot spot_btn1_inst( .clk(clk), .spot_in(btn1_debounced), .spot_out(btn1_processed) );

// debounce and spot btnE
debouncer debouncer_btnE_inst( .switchIn(btnE), .clk(clk), .reset(1'b0), .debounceout(btnE_debounced) );
spot spot_btnE_inst( .clk(clk), .spot_in(btnE_debounced), .spot_out(btnE_processed) );

// debounce and spot btnW
debouncer debouncer_btnW_inst( .switchIn(btnW), .clk(clk), .reset(1'b0), .debounceout(btnW_debounced) );
spot spot_btnW_inst( .clk(clk), .spot_in(btnW_debounced), .spot_out(btnW_processed) );

//////////// TASK SELECTOR ////////////////////////////
parameter IDLE=2'b00, TASK1=2'b01, TASK2=2'b10, TASK3=2'b11;
reg[1:0] state;

always @(posedge clk) begin
   if (reset || task_selector == 3'b000) state <= IDLE;
   else if (task_selector == 3'b100) state <= TASK1;
   else if (task_selector == 3'b010) state <= TASK2;
   else if (task_selector == 3'b001) state <= TASK3;
   else state <= IDLE;
end

// task1
wire [5:0] coordinates;
reg [5:0] T1_coordinates;
reg [15:0] T1_coordinatesPS2;
reg [15:0] PS2oneCoordinates;
reg [5:0] T3_coordinates;
reg [31:0] T1_displayValues, T2_displayValues, T3_displayValues, T4_displayValues;
wire [7:0] T1_letter;
wire [15:0] PS2one;

//task2
wire [7:0] letter_1, letter_2, letter_3, letter_4;
wire [5:0] coordinates_1, coordinates_2, coordinates_3, coordinates_4;
reg [31:0] wordLetters; 
//word assign : FAST

        


assign m_coords = T1_coordinates[5:3];
assign n_coords = T1_coordinates[2:0];

always @(posedge clk) begin
///////////////////////////TASK1 multiplexing/////////////////////////
    if (state == TASK1) begin
        T1_coordinates <= coordinates;
        T1_coordinatesPS2 <= PS2one;
        case (view)
            1'b0: T1_displayValues <= {T1_letter, 8'h00, 8'h00, 8'h00};
            1'b1: T1_displayValues <= {T1_letter, 8'h00, T1_coordinatesPS2[15:8], T1_coordinatesPS2[7:0]};
        endcase
    end
///////////////////////////TASK2 multiplexing/////////////////////////    
    if (state == TASK2) begin
        assign letter_1 = 8'h2B; 
        assign letter_2 = 8'h1C; 
        assign letter_3 = 8'h1B; 
        assign letter_4 = 8'h2c; 
        wordLetters <= {letter_1, letter_2, letter_3, letter_4};
        
         
    end
///////////////////////////TASK3 multiplexing/////////////////////////    
    if (state == TASK3) begin
        T3_coordinates <= coordinates;
        letter_1 <= serial_input;
    end
end


////////////////////////////////////////////////////////////////////////////////////////////


///////////////////////////// Global Module Instantiations /////////////////////////////////

// coordinateGenerator
coordinateGeneratorFSM coordGenFSM_inst( .clk(clk), .reset(reset), .tap(btn1_processed), .stateLED(stateLED), .coordinates(coordinates), .error(error) );

// toPS2 modules and routing
wire [5:0] toPS2one_coordinates = (state == TASK1) ? T1_coordinates : 
                                  (state == TASK3) ? T3_coordinates :
                                  6'd0;                                  
toPS2 toPS2one( .coordinates(toPS2one_coordinates), .PS2coordinates(PS2one) );

// polybiusSquare
polybiusSquare polybiusSquare_inst( .coordinates(T1_coordinates), .letter(T1_letter));

// displayDriver
wire [31:0] taskDisplayValues = (state == TASK1) ? T1_displayValues : 
                                (state == TASK2) ? T2_displayValues :
                                (state == TASK3) ? T3_displayValues :
                                32'd0;
displayDriver displayDriver_inst( .clk(clk), .displayValues(taskDisplayValues), .ssdAnode(ssdAnode), .ssdCathode(ssdCathode) );

eastWestShifter EWShifter ( .clk(clk), .reset(reset), .btnE(btnE_processed), .btnW(btnW_processed) );

ps2ToCoord ps2ToCoord_1 ( .letter(letter_1), .coordinates(coordinates_1) );
ps2ToCoord ps2ToCoord_2 ( .letter(letter_2), .coordinates(coordinates_2) );
ps2ToCoord ps2ToCoord_3 ( .letter(letter_3), .coordinates(coordinates_3) );
ps2ToCoord ps2ToCoord_4 ( .letter(letter_4), .coordinates(coordinates_4) );

assign wordCoords = {coordinates_1, coordinates_2, coordinates_3, coordinates_4};






endmodule
