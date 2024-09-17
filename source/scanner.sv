// Avery Smith, avsmith@hmc.edu, 9/14/24
// scanner and decoder logic for a 16-button pin pad
// FSM logic sets one row at a time high and reads column signals.
// if a button is pressed, it converts the row and column into a 5-bit button signal
// button is 10000 when no button is pressed and 00000 thu 01111 are different buttons
// button is only set for the first button pushed (if multiple)

module scanner(input logic clk, reset,
               input logic [3:0] col,
               output logic [3:0] row,
               output logic [4:0] button
);

typedef enum logic [3:0] {S0, S1, S2, S3, S4, S5, S6, S7} statetype;
statetype state, nextstate;

logic [9:0] counter;

// 9 bit clock divider 12MHz -> 11.72 KHz
// and state register
always_ff @(posedge clk) begin
    if (reset) begin
        counter <= 0;
        state <= S0;
    end
    else begin
        counter <= counter + 1;
        if (counter == '1) state <= nextstate; // go to next state when counter is all bits of counter are high 
    end
end


// nextstate logic
always_comb
    case (state)
        S0: if (col) nextstate = S4;
            else nextstate = S1;
        S1: if (col) nextstate = S5;
            else nextstate = S2;
        S2: if (col) nextstate = S6;
            else nextstate = S3;
        S3: if (col) nextstate = S7;
            else nextstate = S0;
        S4: if (col) nextstate = S4;
            else nextstate = S0;
        S5: if (col) nextstate = S5;
            else nextstate = S1;
        S6: if (col) nextstate = S6;
            else nextstate = S2;
        S7: if (col) nextstate = S7;
            else nextstate = S3;
        default: nextstate = S0;
    endcase

// output logic + decoder
// S0-3 set ith row high
// S4-7 set i-4th row high + check for colums
always_comb
    case (state)
		S0: begin 
			row = 4'b0001;
			button = 5'h10;
			end
		
		S1: begin
			row = 4'b0010;
			button = 5'h10;
			end
			
		S2: begin
			row = 4'b0100;
			button = 5'h10;
			end
			
		S3: begin
			row = 4'b1000;
			button = 5'h10;
			end
			
		S4: begin
			row = 4'b0001;
			if (col[0]) button = 5'h1;
            else if (col[1]) button = 5'h2;
            else if (col[2]) button = 5'h3;
            else if (col[3]) button = 5'hA;
			end
      
	   S5: 	begin
			row = 4'b0010;
			if (col[0]) button = 5'h4;
            else if (col[1]) button = 5'h5;
            else if (col[2]) button = 5'h6;
            else if (col[3]) button = 5'hB;
			end
       
	   S6: 	begin
			row = 4'b0100;
			if (col[0]) button = 5'h7;
            else if (col[1]) button = 5'h8;
            else if (col[2]) button = 5'h9;
            else if (col[3]) button = 5'hC;
			end
        
		S7: begin
			row = 4'b1000;
			if (col[0]) button = 5'hE;
            else if (col[1]) button = 5'h0;
            else if (col[2]) button = 5'hF;
            else if (col[3]) button = 5'hD;
			end
        default: button = 5'h10;
    endcase
endmodule