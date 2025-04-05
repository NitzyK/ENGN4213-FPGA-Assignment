`timescale 1ns / 1ps

module FSM(

input wire clk, tap, view, reset,

output wire [3:0] coords // coords is 4 bit, where each of the numbrs m and n are 2 bit. m = coords[3:2], n = coords[1:0]
    );
 
// FSM 4 states
parameter IDLE=2'b00, N_SET=2'b01, M_SET=2'b10, COORDS=2'b11;
 
// current state
reg[1:0] state, nextstate;
 
always @(posedge clk) begin
   if (reset) state <= IDLE;
   else state <= nextstate; 
end      

// state transitions

reg T; // timer transition signal

always@(*) begin
    case(state)
        IDLE: begin
            if (tap) nextstate = N_SET;
            else nextstate = IDLE;
        end
        
        N_SET: begin
            if (T) nextstate = M_SET;
            else nextstate = N_SET;
        end
        
        M_SET: begin
            if (T) nextstate = COORDS; // check if all the bits of NOT LED are 1111, (check if LED = 0000)
            else nextstate = M_SET;
        end
        
        COORDS: begin
            if (tap) nextstate = N_SET;
            else nextstate = COORDS;
        end
    endcase
end

// creating 1Hz beat
wire beat;
clockDividerHB2 #(.THRESHOLD(50_000_000)) clockDividerHB_inst(
    .enable(1'b1),
    .reset(1'b0),  
    .clk(clk), 
    .beat(beat)
);
 
reg[1:0] counter;

always @ (posedge clk) begin
    if (tap) begin // if tapped, begin counter
    counter <= 2'd3
    end      
endmodule
