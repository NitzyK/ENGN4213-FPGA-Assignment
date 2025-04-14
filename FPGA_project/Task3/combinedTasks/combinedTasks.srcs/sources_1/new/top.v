`timescale 1ns / 1ps

module top(
input wire clk,reset, btn1, btnE, btnW, task1, task2, task3, encrypterSelector, view, encrypt, rx, send,
output wire tx,
//output wire [2:0] m_coords,
//output wire [2:0] n_coords,
output wire [2:0] stateLED,
output reg [1:0] state,
output wire [7:0] tx_LED,
//output wire [1:0] counter,
output wire [6:0] ssdAnode,
output wire [3:0] ssdCathode
);

wire btn1_debounced;
wire btn1_processed;
wire [2:0] task_selector;
wire [2:0] mode_selector;
assign task_selector = {task1, task2, task3};
assign mode_selector = {encrypterSelector, encrypt, view};

// debounce and spot btn1
debouncer debouncer_btn1_inst( .switchIn(btn1), .clk(clk), .reset(1'b0), .debounceout(btn1_debounced) );
spot spot_btn1_inst( .clk(clk), .spot_in(btn1_debounced), .spot_out(btn1_processed) );

// debounce and spot btnE
debouncer debouncer_btnE_inst( .switchIn(btnE), .clk(clk), .reset(1'b0), .debounceout(btnE_debounced) );
spot spot_btnE_inst( .clk(clk), .spot_in(btnE_debounced), .spot_out(btnE_processed) );

// debounce and spot btnW
debouncer debouncer_btnW_inst( .switchIn(btnW), .clk(clk), .reset(1'b0), .debounceout(btnW_debounced) );
spot spot_btnW_inst( .clk(clk), .spot_in(btnW_debounced), .spot_out(btnW_processed) );

// debounce and spot send
debouncer debouncer_send_inst( .switchIn(send), .clk(clk), .reset(1'b0), .debounceout(send_debounced) );
spot spot_send_inst( .clk(clk), .spot_in(send_debounced), .spot_out(send_processed) );


//////////// TASK SELECTOR ////////////////////////////
parameter IDLE=2'b00, TASK1=2'b01, TASK2=2'b10, TASK3=2'b11;

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
wire [15:0] PS2_1, PS2_2, PS2_3, PS2_4, PS2_5, PS2_6, PS2_7, PS2_8;

//task2
reg [7:0] letter_1, letter_2, letter_3, letter_4;
wire [5:0] coordinates_1, coordinates_2, coordinates_3, coordinates_4;
reg [31:0] wordLetters; 
reg [23:0] T2_coordinates;
wire [31:0] wordLetters_encrypted;
wire [23:0] T2_coordinates_encrypted;
wire [3:0] index;
reg [7:0] m, n, m_encrypted, n_encrypted, letter, letter_encrypted;

///task3
wire [7:0] rx_data;
reg [7:0] tx_data_reg;
wire [7:0] tx_data; /// encrypted to be sent 
assign  tx_data = tx_data_reg;
reg [7:0] encrytionIn;
wire [7:0] seed;
wire [7:0] T3_letter_encrypted;
assign  tx_LED = T3_letter_encrypted;//////////////////////////////////////////////////////////////////////////////////

assign m_coords = T1_coordinates[5:3];
assign n_coords = T1_coordinates[2:0];

always @(posedge clk) begin
///////////////////////////TASK1 multiplexing/////////////////////////
    if (state == TASK1) begin
        T1_coordinates <= coordinates;
        T1_coordinatesPS2 <= PS2_1;
        case (view)
            1'b0: T1_displayValues <= {T1_letter, 8'h00, 8'h00, 8'h00};
            1'b1: T1_displayValues <= {T1_letter, 8'h00, T1_coordinatesPS2[15:8], T1_coordinatesPS2[7:0]};
        endcase
    end
///////////////////////////TASK2 multiplexing/////////////////////////    
    else if (state == TASK2) begin
        letter_1 <= 8'h2B; 
        letter_2 <= 8'h1C; 
        letter_3 <= 8'h1B; 
        letter_4 <= 8'h2c; 
        wordLetters <= {letter_1, letter_2, letter_3, letter_4};
        T2_coordinates <= {coordinates_1, coordinates_2, coordinates_3, coordinates_4};
        
        
        case(mode_selector)
            3'b000: T2_displayValues <= wordLetters;
            3'b001: T2_displayValues <= {letter, 8'h00, m, n};
            3'b010: T2_displayValues <= wordLetters_encrypted; //
            3'b011: T2_displayValues <= {letter_encrypted, 8'h00, m_encrypted, n_encrypted};
            3'b100: T2_displayValues <= wordLetters;// 
            3'b101: T2_displayValues <= {letter, 8'h00, m, n}; 
            3'b110: T2_displayValues <= wordLetters_encrypted;
            3'b111: T2_displayValues <= {letter_encrypted, 8'h00, m_encrypted, n_encrypted};
            default: T2_displayValues <= {8'h00, 8'h00, 8'h00, 8'h00};
        endcase      
          
    end
///////////////////////////TASK3 multiplexing/////////////////////////    
    else if (state == TASK3) begin
         if (rx_data_valid) begin
            letter_1 <= rx_data; // in PS2 hex
         end
         
         else if (send_processed) begin
            tx_data_reg <= T3_letter_encrypted;
         end
         
         begin
         T3_coordinates <= coordinates;
         T3_displayValues <= {seed, 8'h00, PS2_1[15:8], PS2_1[7:0]};
        end
    end
end


////////////////////////////////////////////////////////////////////////////////////////////


///////////////////////////// Global Module Instantiations /////////////////////////////////

// coordinateGenerator
coordinateGeneratorFSM coordGenFSM_inst( .clk(clk), .reset(reset), .tap(btn1_processed), .stateLED(stateLED), .coordinates(coordinates), .error(error) );

// toPS2 modules and routing
wire [5:0] toPS2_1coordinates = (state == TASK1) ? T1_coordinates : 
                                (state == TASK2) ? T2_coordinates[23:18] :
                                (state == TASK3) ? T3_coordinates :
                                6'd0;                                  
toPS2 toPS2_1( .coordinates(toPS2_1coordinates), .PS2coordinates(PS2_1) ); ////// convert binary coordinates to PS2
toPS2 toPS2_2( .coordinates(T2_coordinates[17:12]), .PS2coordinates(PS2_2) );
toPS2 toPS2_3( .coordinates(T2_coordinates[11:6]), .PS2coordinates(PS2_3) );
toPS2 toPS2_4( .coordinates(T2_coordinates[5:0]), .PS2coordinates(PS2_4) );

toPS2 toPS2_5( .coordinates(T2_coordinates_encrypted[23:18]), .PS2coordinates(PS2_5) ); ///// convert binary encrypted coordinates to PS2
toPS2 toPS2_6( .coordinates(T2_coordinates_encrypted[17:12]), .PS2coordinates(PS2_6) );
toPS2 toPS2_7( .coordinates(T2_coordinates_encrypted[11:6]), .PS2coordinates(PS2_7) );
toPS2 toPS2_8( .coordinates(T2_coordinates_encrypted[5:0]), .PS2coordinates(PS2_8) );



// polybiusSquare
polybiusSquare polybiusSquare_inst( .coordinates(T1_coordinates), .letter(T1_letter));

// displayDriver
wire [31:0] taskDisplayValues = (state == TASK1) ? T1_displayValues : 
                                (state == TASK2) ? T2_displayValues :
                                (state == TASK3) ? T3_displayValues :
                                32'd0;
displayDriver displayDriver_inst( .clk(clk), .displayValues(taskDisplayValues), .ssdAnode(ssdAnode), .ssdCathode(ssdCathode) );

eastWestShifter #(.max_index(4'd3)) EWShifter ( .clk(clk), .reset(reset), .btnE(btnE_processed), .btnW(btnW_processed), .index(index) );


ps2ToCoord ps2ToCoord_1 ( .letter(letter_1), .coordinates(coordinates_1) );
ps2ToCoord ps2ToCoord_2 ( .letter(letter_2), .coordinates(coordinates_2) );
ps2ToCoord ps2ToCoord_3 ( .letter(letter_3), .coordinates(coordinates_3) );
ps2ToCoord ps2ToCoord_4 ( .letter(letter_4), .coordinates(coordinates_4) );

lvl2Encrypter lvl2Encrypter_inst( .encrypterSelector(encrypterSelector), .wordCoords(T2_coordinates), .wordLetters_encrypted(wordLetters_encrypted), .wordCoords_encrypted(T2_coordinates_encrypted) );

/////////////////////////////// UART /////////////////////


uart_rx uart_rx_inst( .clk(clk), .rx(rx), .data(rx_data), .data_valid(rx_data_valid), .reset(reset) );

uart_tx uart_tx_inst( .clk(clk), .tx(tx) , .busy(busy), .reset(reset), .send(send_processed), .data_in(tx_data) ); //.send(send_spot)

///////////////////// Level 3 encrypter ////////////////////
lvl3Encrypter2 lvl3Encrypter( .coordinates(coordinates_1), .m_seed(T3_coordinates[5:3]), .n_seed(T3_coordinates[2:0]), .letter_encrypted(T3_letter_encrypted), .seed(seed) );

///////////////////////////////////////////////////////////

 
///////////////////////////////// letter selection for letter view ///////////////////////////

always @(*) begin
    case(index)
        4'd0 : begin
            letter = letter_1;
            letter_encrypted = wordLetters_encrypted[31:24];
            m = PS2_1[15:8];
            n = PS2_1[7:0];
            m_encrypted = PS2_5 [15:8];
            n_encrypted = PS2_5 [7:0];
        end 
        4'd1 : begin
            letter = letter_2;
            letter_encrypted = wordLetters_encrypted[23:16];
            m = PS2_2[15:8];
            n = PS2_2[7:0];
            m_encrypted = PS2_6 [15:8];
            n_encrypted = PS2_6 [7:0];
        end
        4'd2 : begin
            letter = letter_3;
            letter_encrypted = wordLetters_encrypted[15:8];
            m = PS2_3[15:8];
            n = PS2_3[7:0];
            m_encrypted = PS2_7 [15:8];
            n_encrypted = PS2_7 [7:0];
        end
        4'd3 : begin
            letter = letter_4;
            letter_encrypted = wordLetters_encrypted[7:0];
            m = PS2_4[15:8];
            n = PS2_4[7:0];
            m_encrypted = PS2_8 [15:8];
            n_encrypted = PS2_8 [7:0];
        end
        default : begin
            letter = 8'h00;
            letter_encrypted = 8'h00;
            m = 8'h00;
            n = 8'h00;
            m_encrypted = 8'h00;
            n_encrypted = 8'h00;
        end
    endcase
end




endmodule
