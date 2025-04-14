`timescale 1ns / 1ps

module coordinateGeneratorFSM(
    input wire clk, tap, reset,
    output reg [5:0] coordinates,
    output reg [2:0] stateLED,
    output reg error
);
////////////////////////////////Overview//////////////////////////////////////////////
// this module takes in a timed button press sequence and generates coordinates (m,n).

///////////////////////////////Parameter Declaration//////////////////////////////////
parameter IDLE=3'b000, N_SET=3'b001, M_SET=3'b010, DISPLAY=3'b011, ERROR=3'b100;

////////////////////////////////Internal Signal Declaration//////////////////////////
reg [1:0] counter1; 
reg [1:0] counter2;
wire beat;
reg[2:0] prevstate, state, nextstate;
reg [2:0] n,m;

////////////////////////////////Timing////////////////////////////////////////////////

// 1Hz beat

clockDividerHB #(.THRESHOLD(50_000_000)) clockDividerHB_inst(
 .enable(1'b1),
 .reset(1'b0),.clk(clk),.beat(beat)
);

// Counter1: 
// 3 second timer to handle timing of transition from N_SET to M_SET
    always @(posedge clk) begin 
        if (reset) begin // if reset, set counter1 to 0
            counter1 <= 2'd0;
        end

        else if (tap) begin  // if tap, reset counter1 to 0 
            counter1 <= 2'd0;
        end
        else if (beat && counter1 < 2'd3) begin // Increment counter1 on each beat (3 second counter)
            counter1 <= counter1 + 1'b1;
        end
    end

// Counter2:
// 3 second timer to handle timing of transition from M_SET to DISPLAY



    always @(posedge clk) begin
        if (reset) begin // if reset seto counter2 to 0
            counter2 <= 2'd0;
        end
        
        else if (state == M_SET && tap) begin // reset counter 2 on tap AND only if state is M_SET
            counter2 <= 2'd0;
        end
        else if (beat && counter2 < 2'd3) begin // Increment counter on each beat (3 second counter)
            counter2 <= counter2 + 1'b1;
        end
    end


/////////////////////////////////Finite State Machine///////////////////////////////////////////

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
        IDLE: begin // if tap then transition from IDLE to N_SET
            if (tap) nextstate = N_SET;
            else nextstate = IDLE;
        end
        
        N_SET: begin // if 3 seconds pass in N_SET with tap inactive, transition to M_SET
            if (counter1 == 2'd2) nextstate = M_SET;
            else if (tap && n == 3'd5) nextstate = ERROR;
            else nextstate = N_SET;
        end
        
        M_SET: begin // if 3 seconsd pass in M_SET with tap inactive, transition to DISPLAY
            if (counter2 == 2'd2) nextstate = DISPLAY;
            else if (tap && m == 3'd5) nextstate = ERROR;
            else nextstate = M_SET;
        end
        
        DISPLAY: begin // if tap pressed (a new sequence) transition back to N_SET
            if (tap) nextstate = N_SET;
            else nextstate = DISPLAY;
        end
        
        ERROR: begin // if tap sequence is invalid 
            if (tap) nextstate = N_SET;
            else nextstate = ERROR;
        end
        
    endcase
end

// output logic
always @(posedge clk) begin
    case(state)
        IDLE:   
            begin // initialise n,m to 0
                stateLED <= 3'b001; 
                n <= 3'b000;
                m <= 3'b000;
            end
            
        N_SET:  
            begin 
                stateLED <= 3'b010; 
                if (prevstate != N_SET) begin // set n to 1 and m to 0 upon entry (to account for first tap)
                    n <= 3'b001;
                    m <= 3'b000;
                end    
                else if (tap && n < 3'd6) n <= n + 3'b001;// increment for every tap
                
                
            end
            
        M_SET: 
            begin 
                stateLED <= 3'b011; 
                if (prevstate != M_SET)  m <= 3'b000;
                else if (tap && m < 3'd6) m <= m + 3'b001; // increment for every tap
            end
        
        DISPLAY: 
            begin
               stateLED <= 3'b100;
            end
            
        ERROR: 
            begin 
                stateLED <= 3'b101;
                n <= 3'b000;
                m <= 3'b000;
            end
             
        default: 
            begin
            n <= 3'b000;
            m <= 3'b000;
            end
    endcase
    coordinates <= {m,n};
end



endmodule
