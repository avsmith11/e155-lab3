// Avery Smith, avsmith@hmc.edu, 9/15/24
// Top Module for HMC E155 Lab 2
// Read button presses on a 16-button pad and display current and last button push on dual seven-segment display

module top(input logic reset,
          input logic [3:0] col_in,
          output logic [3:0] row,
          output logic [6:0] seg,
          output logic en1, en2
);

logic nreset;
assign nreset = ~reset; // nreset = active high
logic [3:0] col_temp, col;


logic clk;
// generate 12MHz clk
HSOSC #(.CLKHF_DIV(2'b10)) 
    hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
	
// 2-flop input synchronizer to decrease metastability
always_ff @(posedge clk) begin 
	col_temp <= col_in;
	col <= col_temp;
end

logic [4:0] button;
// scan buttons + decode inputs  
scanner scanner_decoder(clk, nreset, col, row, button);

logic pulse;
logic [3:0] deb_button;
// debounce input singal (1ms)
debouncer debouncer(clk, nreset, button, pulse, deb_button);

logic [3:0] current, last;

// Store current and last input for segment display
shift_register SHIFT_REGISTER(clk, nreset, pulse, deb_button, current, last);


// Create and display time-muxed signal for 2 segment displays with en1, en2, and seg
dual_seg_driver dual_seg_driver(clk, nreset, last, current, seg, en1, en2);

endmodule