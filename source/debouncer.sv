// Avery Smith, avsmith@hmc.edu, 9/15/24
// debounce button signal with 1 ms stability period

module debouncer(input logic clk, reset, 
                 input logic [4:0] button,
                 output logic pulse,
                 output logic [3:0] deb_button
);

logic [13:0] counter; // 14 bit counter

typedef enum logic [2:0] {waiting, counting, pulsing, holding} statetype;
statetype state, nextstate;

// state register + 1.37ms counter (12MHz / 14'b11111111111111)
always_ff @(posedge clk) begin

    if (reset) begin counter <= 0; state <= waiting; end

    else if (button == 5'b10000) state <= waiting; // anytime button is released, go to waiting state
    else begin
        state <= nextstate;
        if (nextstate == counting) counter <= 0; // reset counter before counting state
        if (state == counting) counter <= counter + 1; // increment counter while in the counting state
    end
end

// nextstate logic 
always_comb
    case (state)
        waiting: nextstate = counting;

        counting: if (counter == '1) nextstate = pulsing;
                  else nextstate = counting;
        pulsing:    nextstate = holding;
        holding:  nextstate = holding;
		default: nextstate  = waiting;
    endcase

// output logic
always_comb begin
    if (state == pulsing) begin
        pulse = 1;
        deb_button = button [3:0];
	end
    else pulse = 0;
end
endmodule