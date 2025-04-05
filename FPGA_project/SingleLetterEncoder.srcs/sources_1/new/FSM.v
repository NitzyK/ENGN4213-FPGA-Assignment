`timescale 1ns / 1ps

module FSM(

input wire clk, tap, view, reset,

output reg [3:0] coords // coords is 4 bit, where each of the numbrs m and n are 2 bit. m = coords[3:2], n = coords[1:0]
    );
 
// FSM 4 states
parameter IDLE=2'b00, N_SET=2'b01, M_SET=2'b10;
 
// current state
reg[1:0] state, nextstate;
 
always @(posedge clk) begin
   if (reset) state <= IDLE;
   else state <= nextstate; 
end      

// state transitions

reg T; // timer transition signal

reg[1:0] counter;

// creating 1Hz beat
wire beat;
clockDividerHB2 #(.THRESHOLD(50_000_000)) clockDividerHB_inst(
    .enable(1'b1),
    .reset(1'b0),  
    .clk(clk), 
    .beat(beat)
);

always @ (posedge clk) begin
    if (tap) begin // if tapped, begin counter
    counter <= 2'd3;
    end
    else if (counter > 0 & beat) begin
    counter <= counter - 1'b1; // count down 3 seconds
    end  
end   

always@(*) begin
    case(state)
        IDLE: begin
            if (tap) nextstate = N_SET;
            else nextstate = IDLE;
        end
        
        N_SET: begin
            if (counter == 2'b0) nextstate = M_SET;
            else nextstate = N_SET;
        end
        
        M_SET: begin
            if (tap) nextstate = N_SET;
            else nextstate = M_SET;
        end
    endcase
end




always @(*) begin
    case(state)
        IDLE: coords = 4'b1111;
        N_SET:  begin
                 if (tap & coords[1:0] <= 5)
                            coords[1:0] <= coords[1:0] + 2'b1;
                end
        M_SET: begin
                 if (tap & coords[3:2] <= 5)
                            coords[3:2] <= coords[3:2] + 2'b1;
               end
        default: coords <= 4'b0000;
    endcase
end

 

    
          
endmodule
