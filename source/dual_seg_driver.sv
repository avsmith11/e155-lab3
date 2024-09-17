// Avery Smith, 9/8/24, avsmith@hmc.edu
// takes in two 4-bit signals and outputs time-multiplexed signals for two 7-segment displays using ONE instance of segment_driver
module dual_seg_driver( input clk, reset,
			input logic [3:0] s1, s2,
			output logic [6:0] seg,
			output logic en1, en2
);

	logic [3:0] s;
	// generate time multiplexed signal, s
	time_mux time_mux(reset, clk, s1, s2, s, en1, en2);
	
	// send multiplexed signal to 7_seg encoder
	seg_encoder ONLY_ONE_SEGMENT_ENCODER(s, seg);
	
endmodule