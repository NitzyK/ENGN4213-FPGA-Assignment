`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2025 17:36:45
// Design Name: 
// Module Name: finalFSM_TOP
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: wordType.v, 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module finalFSM_TOP(
input wire clk,
input wire ps2_data,
input wire ps2_clk,
input wire reset,
input wire send,
input wire task_button,
input wire rx,
input wire autoSwitch,
input wire displaySwitch,
input wire displayEnable,
input wire typeEnable,
input wire btnR,
input wire btnL,

output wire [6:0] ssdAnode,
output wire[3:0]  ssdCathode,
output wire tx,
output reg [7:0] wordindexLed,
output wire [2:0] stateled,
output wire  data_led
    );
    
    localparam [2:0] IDLE     = 3'b000;
    localparam [2:0] TASK1 = 3'b001;
    localparam [2:0] TASK2 = 3'b010;
    localparam [2:0] TYPING = 3'b011;
    localparam [2:0] SEND_REC = 3'b100;
    localparam [2:0] DISPLAY  = 3'b101;
    localparam [2:0] DISPLAY_ENCRYPT  = 3'b111;

    reg [2:0] prev_state, state,next_state;   
    
    assign stateled = state;

    wire [10:0] ps2_data_out;
    wire [7:0] ps2_scancode;
    wire [31:0] currentWord;
    reg [31:0] displayWord;
    wire [255:0] word;
    wire [2:0] word_index;
    reg [255:0] data_buffer;
    
    wire [7:0] rx_data;
        
    reg [255:0] encryptedWord;
    reg show_encrypt;
    reg [7:0] tx_data;
    reg [4:0] tx_data_count;
    reg send_enable;
    reg beat_out;
    reg beat_1;
//    reg type_enable;
    reg encrypt_ready;
    reg [4:0] rx_byte_count;
    reg fixedWord_enable;
    reg word_enable;
    
    assign data_led = encrypt_ready;
    
    
    
//****** DEBOUNCE AND SPOT INPUTS *************

    debouncer debounce_send_inst(
        .clk(clk),
        .switchIn(send),
        .debounceout(send_deb),
        .reset(reset)
        );
    
    spot spot_send_inst(
    .clk(clk),
    .spot_in(send_deb),
    .spot_out(send_spot)
    );
    
    debouncer debounce_taskbtn(
    .clk(clk),
    .switchIn(task_button),
    .debounceout(task_button_deb),
    .reset(reset)
    
    );
    
    spot spot_taskbtn_inst(
    .clk(clk),
    .spot_in(task_button_deb),
    .spot_out(task_button_spot)
    );
    
    debouncer debounce_displayswitch_inst(
    .clk(clk),
    .switchIn(displaySwitch),
    .debounceout(displaySwitch_deb),
    .reset(reset)

    
    );
    
    
        
    debouncer debounce_displayEnable_inst(
    .clk(clk),
    .switchIn(displayEnable),
    .debounceout(displayEnable_deb),
    .reset(reset)
    );
    
        debouncer debounce_typeEnable_inst(
    .clk(clk),
    .switchIn(typeEnable),
    .debounceout(typeEnable_deb),
    .reset(reset)
    );
    
    
    debouncer debounce_btnR_inst(
        .clk(clk),
        .switchIn(btnR),
        .debounceout(btnR_deb),
        .reset(reset)
        );
    
    spot spot_btnR_inst(
    .clk(clk),
    .spot_in(btnR_deb),
    .spot_out(btnR_spot)
    );
    
    debouncer debounce_btnL_inst(
        .clk(clk),
        .switchIn(btnL),
        .debounceout(btnL_deb),
        .reset(reset)
        );
    
    spot spot_btnL_inst(
    .clk(clk),
    .spot_in(btnL_deb),
    .spot_out(btnL_spot)
    );
   
   
    
// ************ PS2 Handling
    
    PS2_data_capture ps2_inst (
    .clk(clk),
    .PS2_data_in(ps2_data),
    .PS2_clk(ps2_clk),
    .PS2_data_out(ps2_data_out),
    .dv(dv)
    );
    
    ps2_decoder ps2_decode(
    .clk(clk),
    .dv(dv),
    .type_enable(typeEnable_deb),
    .ps2_data_in(ps2_data_out),
    .is_extended(ext_flag),
    .is_break(break_flag),
    .dv_dec(dv_dec),
    .scan_code(ps2_scancode)
    );
    
 wordType word_inst (
    .clk(clk),
    .dv_dec(dv_dec),
    .reset(reset),
    .ps2_scancode(ps2_scancode),
    .extended_flag(ext_flag),
    .break_flag(break_flag),
    .currentWord(currentWord),
    .word_index(word_index),
    .word(word),
    .encrypt(show_encrypt),
    .encrypted_word(encryptedWord),
    .btnR(btnR_spot),
    .btnL(btnL_spot),
    .auto_beat(beat_1hz),
    .fixedWord_enable(fixedWord_enable),
    .enable(word_enable),
    .task_btn_spot(task_button_spot)
    );
    
//****** Send Recieve handling ********   

    clockDividerHB #( .THRESHOLD(10_000_000)) pulse_send (
    
        .clk(clk),
        .enable(send_enable),
        .reset(reset),
        .beat(beat),
        .dividedClk()        
    ); 

    uart_rx uart_receiver (
        .clk(clk),
        .rx(rx),
        .data(rx_data),
        .data_valid(rx_data_valid),
        .reset(reset)
        
    );
    
     uart_tx uart_transmitter (
        .clk(clk),
        .data_in(tx_data),
        .send(beat_out),
        .tx(tx),
        .busy(busy),
        .reset(reset)
    );
    
    
  displayDriver ssd_driver_inst(
    .clk(clk),
    .displayValues(displayWord),
    .ssdAnode(ssdAnode),
    .ssdCathode(ssdCathode) 
    
    );
    
    
//********* for AUTODISPLAY    
    clockDividerHB #(.THRESHOLD(50_000_000)) oneSecClk(
        .clk(clk),
        .enable(autoSwitch),
        .reset(reset),
        .dividedClk() ,
        .beat(beat_1hz)
    );
    
//**********************STATE TRANSITION LOGIC    
    always @(*) begin 
        case(state)
        IDLE: begin if(task_button_spot) next_state = TASK1;
              else next_state = IDLE;
              end
        
        TASK1: begin
                if (task_button_spot) next_state = TASK2;
                else next_state = TASK1;
                end
        TASK2:  begin
                if (task_button_spot) next_state = TYPING;
                else next_state = TASK2;
                end       
                
        TYPING: begin if (send_spot) next_state = SEND_REC;
                else  if (task_button_spot) next_state = IDLE;
                else next_state = TYPING;
                end
                
                
        SEND_REC: begin if(encrypt_ready && !busy) next_state = DISPLAY_ENCRYPT;
                else next_state = SEND_REC;
                end
        
        DISPLAY_ENCRYPT: begin
                            if(displaySwitch_deb) next_state = DISPLAY;
//                            else if(send_spot) next_state = SEND_REC;
                            else next_state = DISPLAY_ENCRYPT;
                        end 
                        
        DISPLAY: begin
                        if(!displaySwitch_deb) next_state = DISPLAY_ENCRYPT;
//                        else if(send_spot) next_state = SEND_REC;
                        else next_state = DISPLAY;
                        end
                        
        default: next_state =IDLE;                
        endcase

    end
    
    
 // ******************* STATE OUTPUT LOGIC   
    
always @(*) begin
    // Default assignments
    displayWord = 32'hFFFFFFFF;
    show_encrypt = 0;
//    type_enable = 0;
    send_enable = 0;
    fixedWord_enable = 0;
    word_enable = 0;
    wordindexLed = (8'b1 << (word_index + 1)) - 1;
    
    
    case(state)
        IDLE: begin
            displayWord = 32'h244B2343;
            wordindexLed = 0;
        end
        TASK1: begin
            displayWord = displayEnable_deb ? {24'hFFFFFF,ps2_scancode}: 32'h0; //mealy machine
            wordindexLed = 0;
        end
        TASK2: begin
            displayWord = displayEnable_deb ? currentWord: 32'h0;
            fixedWord_enable = 1;
            word_enable = 1;
            
        end
        TYPING: begin
            displayWord = currentWord;
//            type_enable = 1;
            word_enable = 1;
        end
        SEND_REC: begin
            displayWord = {tx_data,16'hFFFF,rx_data};
            send_enable = 1;
            wordindexLed = 0;
        end
        DISPLAY_ENCRYPT: begin
            displayWord = currentWord; 
            show_encrypt = 1;
            word_enable = 1;
        end
        DISPLAY: begin
            displayWord = currentWord;
            word_enable = 1;
        end
        default: begin
            // already covered by default assignments
        end
    endcase
end
    
    
    
 // ******* MEMORY LOGIC   
    always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
              tx_data <= 0;
              tx_data_count <= 0;
              encryptedWord <= 0;
              encrypt_ready <= 0;
              rx_byte_count <=0;
        
        
        end
        
    else begin
    
    prev_state <= state;
    state <= next_state;
    beat_out <= beat_1;
    beat_1 <= beat;
    
    case(state)
        SEND_REC: begin
                        if (rx_data_valid) begin
                               encryptedWord <= {rx_data, encryptedWord[255:8]};
                                
//                                if (rx_byte_count < 31)
//                                    rx_byte_count <= rx_byte_count + 1;
//                                else
//                                    rx_byte_count <= 0;  // Reset after 32 bytes
                            
//                                if (rx_byte_count == 31)
//                                    encrypt_ready <= 1;  // Mark completion
                                    rx_byte_count <= rx_byte_count + 1;
                                  if (&rx_byte_count) begin 
                                        encrypt_ready <=1;
                                  end
                            end

                        
                        if(beat) begin 
                            tx_data <= word[8*tx_data_count +: 8];
                            tx_data_count <= tx_data_count + 1;
//                            if(!(&tx_data_count)) tx_data_count <= tx_data_count + 1;
                            
//                                else begin 
//                                    tx_data_count <= 0;
//                                end
                            
                        end
                    end   
        IDLE, TYPING,TASK1,TASK2: encrypt_ready <= 0;                   
    endcase
    end
    end
endmodule
