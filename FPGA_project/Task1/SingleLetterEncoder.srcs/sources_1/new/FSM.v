`timescale 1ns / 1ps

module FSM(

input wire clk, tap, reset,
output reg [1:0] counter, // used for debugging
output reg [2:0] n_coords,
output reg [2:0] m_coords,
output reg [2:0] stateLED // used for debugging
    );
 
// ### FSM 4 states ###
parameter IDLE=2'b00, N_SET=2'b01, M_SET=2'b10, DISPLAY = 2'b11;

 // ###  state transitioner ###
reg[1:0] prevstate, state, nextstate;
 
always @(posedge clk) begin
   if (reset) state <= IDLE;
   else begin
   state <= nextstate;
   prevstate <= state;
   end
end      


// ### creating 1Hz beat ###
wire beat;
clockDividerHB2 #(.THRESHOLD(50_000_000)) clockDividerHB_inst(
    .enable(1'b1),
    .reset(1'b0),  
    .clk(clk), 
    .beat(beat)
);

// ### Counter 1 ###
// to handle timing of transition from N_SET to M_SET

    always @(posedge clk) begin
        if (reset) begin
            counter <= 2'd0;
        end
        //else if (tap || (state != nextstate)) begin
        
        else if (tap) begin
            // Reset counter to 0 on tap or state change
            counter <= 2'd0;
        end
        else if (beat && counter < 2'd3) begin
            // Increment counter on each beat, up to 3
            counter <= counter + 1'b1;
        end
    end


// ### Counter 2 ### 
// Counter (handle timing of transition from M_SET to DISPLAY

reg [1:0] counter2; 

    always @(posedge clk) begin
        if (reset) begin
            counter2 <= 2'd0;
        end
        //else if (tap || (state != nextstate)) begin
        
        else if (state == M_SET && tap) begin
            // Reset counter to 0 on tap or state change
            counter2 <= 2'd0;
        end
        else if (beat && counter2 < 2'd3) begin
            // Increment counter on each beat, up to 3
            counter2 <= counter2 + 1'b1;
        end
    end

// ### STATE TRANSITIONS ###

always@(*) begin
    case(state)
        IDLE: begin // if tap then transition from IDLE to N_SET
            if (tap) nextstate = N_SET;
            else nextstate = IDLE;
        end
        
        N_SET: begin // if 2 seconds pass in N_SET with tap inactive, transition to M_SET
            if (counter == 2'd2) nextstate = M_SET;
            else nextstate = N_SET;
        end
        
        M_SET: begin // if 2 seconsd pass in M_SET with tap inactive, transition to DISPLAY
            if (counter2 == 2'd2) nextstate = DISPLAY;
            else nextstate = M_SET;
        end
        
        DISPLAY: begin // if tap pressed (a new sequence) transition back to N_SET
            if (tap) nextstate = N_SET;
            else nextstate = DISPLAY;
        end
        
    endcase
end


always @(posedge clk) begin
    case(state)
        IDLE:   
            begin // initialise n_coords and m_coords to 0
                n_coords <= 3'b000;
                m_coords <= 3'b000;
                stateLED <= 3'b001; // debugging
            end
            
        N_SET:  
            begin // if entering state N_SET for first time set coords to 1
                stateLED <= 3'b010; // debugging
                if (prevstate != N_SET) begin
                    n_coords <= 3'b001;
                end
                
                else if (tap && n_coords < 3'd5) begin // increment for every tap (max 5 taps) 
                    n_coords <= n_coords + 3'b001;
                end
            end
            
        M_SET: 
            begin // if entering state N_SET for first time set coords back to 0
                stateLED <= 3'b100; // debugging
                if (prevstate != M_SET) begin
                    m_coords <= 3'b000;
                end
                
                else if (tap && m_coords < 3'd5) begin // increment for every tap until 5 
                     m_coords <= m_coords + 3'b001;  
                end
            end
        
        DISPLAY: 
            begin
                stateLED <= 3'b111; // debugging
            end
             
        default: 
            begin
            n_coords <= 3'b000;
            m_coords <= 3'b000;
            end
            
    endcase
end

endmodule
