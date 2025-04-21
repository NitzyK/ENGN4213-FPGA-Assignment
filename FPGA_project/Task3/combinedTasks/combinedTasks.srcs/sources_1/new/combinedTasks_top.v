`timescale 1ns / 1ps

module top(
input wire clk,
input wire reset, encrypterSelector, encrypt, view, // input switches
input wire btnE, btnW, tap, btn, reset_btn, // input buttons
input wire rx, // UART
output wire tx, // UART
output reg [1:0] state, // top FSM states
output wire [6:0] ssdAnode, // ssd
output wire [3:0] ssdCathode, // ssd
output wire [2:0] coordGenState, // coordinate genertaor FSM state
output reg [3:0] letter_index
);

////////////////////////////////Internal Signal Declaration//////////////////////////

// debounced and spotted button inputs
wire btn_debounced;
wire btn_processed;
wire tap_debounced;
wire tap_processed;
wire btn4_debounced;
wire btn4_processed;
wire btnE_debounced;
wire btnE_processed;
wire btnW_debounced;
wire btnW_processed;
wire [2:0] mode_selector;
reg [2:0] nextstate;
reg [2:0] prevstate;


//task1
reg [5:0] T1_coordinates;
wire [7:0] T1_letter;
reg [31:0] T1_displayValues;
reg reset_stateChange;
wire error;


//task2
reg [31:0] T2_displayValues;
reg [7:0] letter_1, letter_2, letter_3, letter_4;
reg [31:0] wordLetters; 
wire [31:0] wordLetters_encrypted;
reg [23:0] T2_coordinates;
wire [5:0] coordinates_1, coordinates_2, coordinates_3, coordinates_4;
reg [7:0] m, n, m_encrypted, n_encrypted, letter, letter_encrypted;
wire [3:0] index;
wire [23:0] T2_coordinates_encrypted;
reg EWshifter_enable;

//task3
reg [31:0] T3_displayValues;
wire [31:0] T3_letter_encrypted;
wire send;
reg [5:0] T3_coordinates;
wire [7:0] seed;
wire [7:0] rx_data;
reg [7:0] tx_data_reg;
wire [7:0] tx_data;
reg [7:0] encrytionIn;
reg [3:0] send_delay_bits;

//shared
wire [5:0] generatedCoordinates;
reg [5:0] toPS2coordinates_1, toPS2coordinates_2, toPS2coordinates_3, toPS2coordinates_4, toPS2coordinates_5, toPS2coordinates_6, toPS2coordinates_7, toPS2coordinates_8;
reg [15:0] T1_coordinatesPS2;
wire [15:0] PS2coordinates_1, PS2coordinates_2, PS2coordinates_3, PS2coordinates_4, PS2coordinates_5, PS2coordinates_6, PS2coordinates_7, PS2coordinates_8;
reg [31:0] taskDisplayValues;
reg coordGen_enable;


/////////////////////////// Instantiations /////////////////////////////////////////////

// debounce and spot tap
debouncer debouncer_btn1_inst( .switchIn(tap), .clk(clk), .reset(1'b0), .debounceout(tap_debounced) );
spot spot_tap_inst( .clk(clk), .spot_in(tap_debounced), .spot_out(tap_processed) );

// debounce and spot btn
debouncer debouncer_btn_inst( .switchIn(btn), .clk(clk), .reset(2'b0), .debounceout(btn_debounced) );
spot spot_btn_inst( .clk(clk), .spot_in(btn_debounced), .spot_out(btn_processed) );

// debounce and spot resert_btn
debouncer debouncer_resetButton_inst( .switchIn(reset_btn), .clk(clk), .reset(1'b0), .debounceout(reset_btn_debounced) );
spot spot_resetButton_inst( .clk(clk), .spot_in(reset_btn_debounced), .spot_out(reset_btn_processed) );

// debounce and spot btnE
debouncer debouncer_btnE_inst( .switchIn(btnE), .clk(clk), .reset(1'b0), .debounceout(btnE_debounced) );
spot spot_btnE_inst( .clk(clk), .spot_in(btnE_debounced), .spot_out(btnE_processed) );

// debounce and spot btnW
debouncer debouncer_btnW_inst( .switchIn(btnW), .clk(clk), .reset(1'b0), .debounceout(btnW_debounced) );
spot spot_btnW_inst( .clk(clk), .spot_in(btnW_debounced), .spot_out(btnW_processed) );

// Coordinate Generator:
// 'coordinates' is a common input into TASK1 and TASK3
coordinateGeneratorFSM coordGenFSM_inst( .clk(clk), .reset(reset_btn_processed || reset_stateChange), .tap(tap_processed), .state(coordGenState), .coordinates(generatedCoordinates), .enable(coordGen_enable));

// polybiusSquare 
polybiusSquare polybiusSquare_inst( .coordinates(generatedCoordinates), .letter(T1_letter));

// toPS2 decoders (to PS2 from bcd)                                
toPS2 toPS2_1( .coordinates(toPS2coordinates_1),  .PS2coordinates(PS2coordinates_1) ); ////// convert binary COORDINATES to PS2
toPS2 toPS2_2( .coordinates(toPS2coordinates_2),  .PS2coordinates(PS2coordinates_2) );
toPS2 toPS2_3( .coordinates(toPS2coordinates_3),  .PS2coordinates(PS2coordinates_3) );
toPS2 toPS2_4( .coordinates(toPS2coordinates_4),  .PS2coordinates(PS2coordinates_4) );
toPS2 toPS2_5( .coordinates(toPS2coordinates_5),  .PS2coordinates(PS2coordinates_5) ); ///// convert binary ENCRYPTED COORDINATES to PS2
toPS2 toPS2_6( .coordinates(toPS2coordinates_6),  .PS2coordinates(PS2coordinates_6) );
toPS2 toPS2_7( .coordinates(toPS2coordinates_7),  .PS2coordinates(PS2coordinates_7) );
toPS2 toPS2_8( .coordinates(toPS2coordinates_8),  .PS2coordinates(PS2coordinates_8) );


// ps2ToCoord (PS2 Hex values to coordinates decoder)
ps2ToCoord ps2ToCoord_1 ( .letter(letter_1), .coordinates(coordinates_1) );
ps2ToCoord ps2ToCoord_2 ( .letter(letter_2), .coordinates(coordinates_2) );
ps2ToCoord ps2ToCoord_3 ( .letter(letter_3), .coordinates(coordinates_3) );
ps2ToCoord ps2ToCoord_4 ( .letter(letter_4), .coordinates(coordinates_4) );
    
// Level 2 Encrypter (encrypts 4 letters at a time)
lvl2Encrypter lvl2Encrypter_inst( .encrypterSelector(encrypterSelector), .wordCoords(T2_coordinates), .wordLetters_encrypted(wordLetters_encrypted), .wordCoords_encrypted(T2_coordinates_encrypted) );

// eastWestShifter used as a pointer for displaying letters (button inputs east and west increment and decrement index by 1 between 0 and 4)
eastWestShifter #(.max_index(4'd3)) EWShifter ( .clk(clk), .reset(reset || reset_stateChange), .btnE(btnE_processed), .btnW(btnW_processed), .index(index), .enable(EWshifter_enable) );

// UART receiver
uart_rx uart_rx_inst( .clk(clk), .rx(rx), .data(rx_data), .data_valid(rx_data_valid), .reset(reset) );

// UART transceiver
uart_tx uart_tx_inst( .clk(clk), .tx(tx) , .busy(busy), .reset(reset), .send(send), .data_in(tx_data) );

// Level3Encrypter2 (encrypts a single letter at a time)
lvl3Encrypter lvl3Encrypter_inst( .coordinates(coordinates_1), .m_seed(generatedCoordinates[5:3]), .n_seed(generatedCoordinates[2:0]), .letter_encrypted(T3_letter_encrypted), .seed(seed) );

displayDriver displayDriver_inst( .clk(clk), .displayValues(taskDisplayValues), .ssdAnode(ssdAnode), .ssdCathode(ssdCathode) );


//  Assignments  
assign mode_selector = {encrypterSelector, encrypt, view};

assign  tx_data = tx_data_reg;

assign send = send_delay_bits[3]; 
    
////////////////////////// Finite State Machine //////////////////////////////////////

parameter IDLE=2'b00, TASK1=2'b01, TASK2=2'b10, TASK3=2'b11;

// next state logic
always @(posedge clk) begin
   if (reset) begin
       state <= IDLE;  
   end

   else begin
       state <= nextstate;
       prevstate <= state;
   end
end    

// state transition logic
always@(*) begin
    case(state)
        IDLE: begin
            if (btn_processed) nextstate = TASK1;
            else nextstate = IDLE;
        end
        
        TASK1: begin
            if (btn_processed) nextstate = TASK2;
            else nextstate = TASK1;
        end
        
        TASK2: begin 
            if (btn_processed) nextstate = TASK3;
            else nextstate = TASK2;
        end
        
        TASK3: begin 
            if (btn_processed) nextstate = IDLE;
            else nextstate = TASK3;
        end
    endcase
end

// output logic
always @(posedge clk) begin
     // reset values when entering state
     if (state != prevstate) reset_stateChange <= 1'd1; 
     else if (reset_stateChange == 1'd1) reset_stateChange <= 1'd0; 

     case(state)
        IDLE: begin
                // state module enable/dissable
                EWshifter_enable <= 1'd0;    
                coordGen_enable <= 1'd0; 
                
                taskDisplayValues <= {8'h43, 8'h23, 8'h4B, 8'h24}; // display IDLE 
              end
        TASK1: 
        begin
            // state module enable/dissable       
            EWshifter_enable <= 1'd0;
            coordGen_enable <= 1'd1;
            
            if (coordGenState == 3'b000) taskDisplayValues <= {8'h2C, 8'h1C, 8'h4D, 8'h00 }; // display TAP
            
            else if (coordGenState == 3'b100) taskDisplayValues <= {8'h24, 8'h2D, 8'h2D, 8'h00 }; // display Err if error
            
            else begin
                toPS2coordinates_1 <= generatedCoordinates; // output from coordinatesGenerator (m,n) and input into toPS2_1
                case (view)
                    1'b1: taskDisplayValues <= {T1_letter, 8'h00, 8'h00, 8'h00};
                    1'b0: taskDisplayValues <= {T1_letter, 8'h00, PS2coordinates_1[15:8], PS2coordinates_1[7:0]};
                endcase
            end
        end
        
        TASK2:
        begin
            // state module enable/dissable
            EWshifter_enable <= 1'd1;
            coordGen_enable <= 1'd0;      
            
            // prewritten letter FAST
            letter_1 <= 8'h2B; 
            letter_2 <= 8'h1C; 
            letter_3 <= 8'h1B; 
            letter_4 <= 8'h2c; 
            
            wordLetters <= {letter_1, letter_2, letter_3, letter_4};
            
            T2_coordinates <= {coordinates_1, coordinates_2, coordinates_3, coordinates_4};
            
            // convert coordinates to PS2 keycodes
            toPS2coordinates_1 <= coordinates_1;
            toPS2coordinates_2 <= coordinates_2;
            toPS2coordinates_3 <= coordinates_3;
            toPS2coordinates_4 <= coordinates_4;
            toPS2coordinates_5 <= T2_coordinates_encrypted[23:18];
            toPS2coordinates_6 <= T2_coordinates_encrypted[17:12];
            toPS2coordinates_7 <= T2_coordinates_encrypted[11:6];
            toPS2coordinates_8 <= T2_coordinates_encrypted[5:0];
            
            // display based on switch configuration 
            case(mode_selector)
                3'b000: taskDisplayValues <= wordLetters;
                3'b001: taskDisplayValues <= {letter, 8'h00, m, n};
                3'b010: taskDisplayValues <= wordLetters_encrypted; //
                3'b011: taskDisplayValues <= {letter_encrypted, 8'h00, m_encrypted, n_encrypted};
                3'b100: taskDisplayValues <= wordLetters;// 
                3'b101: taskDisplayValues <= {letter, 8'h00, m, n}; 
                3'b110: taskDisplayValues <= wordLetters_encrypted;
                3'b111: taskDisplayValues <= {letter_encrypted, 8'h00, m_encrypted, n_encrypted};
                default: taskDisplayValues <= {8'h00, 8'h00, 8'h00, 8'h00};
            endcase
        end
        
        TASK3:
        begin 
            // state module enable/dissable
            EWshifter_enable <= 1'd0;
            coordGen_enable <= 1'd1;
            
            if (coordGenState == 3'b000) taskDisplayValues <= {8'h1B, 8'h24, 8'h24, 8'h23 }; // display SEED
            
            else if (coordGenState == 3'b100) taskDisplayValues <= {8'h24, 8'h2D, 8'h2D, 8'h00 }; // display Err if error
            
            else begin 
                toPS2coordinates_1 <= generatedCoordinates; 
                //T3_coordinates <= generatedCoordinates;
                
                taskDisplayValues <= {seed, 8'h00, PS2coordinates_1[15:8], PS2coordinates_1[7:0]}; // display seed and seed coordinates
                
                if (rx_data_valid) letter_1 <= rx_data; // if the rx data is received, assign the data to letter_1
                
                else if (send) begin
                   tx_data_reg <= T3_letter_encrypted;
                   //send_counter <= send_counter + 1;
                end 
            end
        end             
    endcase
end


//////////////////////////////////// 7SD index letter display /////////////////////////////
always @(*) begin
    case(index)
        4'd0 : begin
            letter = letter_1;
            letter_index = 4'b1000;
            letter_encrypted = wordLetters_encrypted[31:24];
            m = PS2coordinates_1[15:8];
            n = PS2coordinates_1[7:0];
            m_encrypted = PS2coordinates_5[15:8];
            n_encrypted = PS2coordinates_5[7:0];
        end 
        4'd1 : begin
            letter = letter_2;
            letter_index = 4'b0100;
            letter_encrypted = wordLetters_encrypted[23:16];
            m = PS2coordinates_2[15:8];
            n = PS2coordinates_2[7:0];
            m_encrypted = PS2coordinates_6[15:8];
            n_encrypted = PS2coordinates_6[7:0];
        end
        4'd2 : begin
            letter = letter_3;
            letter_index = 4'b0010;
            letter_encrypted = wordLetters_encrypted[15:8];
            m = PS2coordinates_3[15:8];
            n = PS2coordinates_3[7:0];
            m_encrypted = PS2coordinates_7[15:8];
            n_encrypted = PS2coordinates_7[7:0];
        end
        4'd3 : begin
            letter = letter_4;
            letter_index = 4'b0001;
            letter_encrypted = wordLetters_encrypted[7:0];
            m = PS2coordinates_4[15:8];
            n = PS2coordinates_4[7:0];
            m_encrypted = PS2coordinates_8[15:8];
            n_encrypted = PS2coordinates_8[7:0];
        end
        default : begin
            letter_index = 4'b0000;
            letter = 8'h00;
            letter_encrypted = 8'h00;
            m = 8'h00;
            n = 8'h00;
            m_encrypted = 8'h00;
            n_encrypted = 8'h00;
        end
    endcase
end

// delay send signal by 3 clock cycles to allow for encryption computation
always @(posedge clk) begin
    send_delay_bits <= {send_delay_bits[2:0], rx_data_valid};
end


endmodule
