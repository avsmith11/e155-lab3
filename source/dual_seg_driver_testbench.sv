// testbench for dual_seg_driver module
// Avery Smith, 9/15/24, avsmith@hmc.edu
// modified from Harris & Harris, Digital Design and Computer Architecture: ARM edition
`timescale 1ns/1ns
module dual_seg_driver_testbench();
    logic clk, reset;
	logic [3:0] s1, s2;
	logic [6:0] seg;
	logic en1, en2;

    // instantiate device under test
    dual_seg_driver dut(clk, reset, s1, s2, seg, en1, en2);

    // generate clock ~12MHz
    always begin
        clk = 1; #83;
        clk = 0; #83;
    end
    // at start of test, load vectors
    // and pulse reset
    initial begin
        reset = 1; #69; reset = 0;
        s1 = 4'h0; s2 = 4'h0;
        #10000000
        s1 = 4'h1; s2 = 4'h0;
        #10000000
        s1 = 4'h2; s2 = 4'h1;
        #10000000
        s1 = 4'h3; s2 = 4'h2;
        #10000000
        s1 = 4'h4; s2 = 4'h3;
        #10000000
        s1 = 4'h5; s2 = 4'h4; 
        #10000000
        s1 = 4'h6; s2 = 4'h5;
        #10000000
        s1 = 4'h7; s2 = 4'h6;
        #10000000
        s1 = 4'h8; s2 = 4'h7;
        #10000000
        s1 = 4'h9; s2 = 4'h8;
        #10000000
        s1 = 4'hA; s2 = 4'h9;
        #10000000
        s1 = 4'hB; s2 = 4'hA;
        #10000000
        s1 = 4'hC; s2 = 4'hB; 
        #10000000
        s1 = 4'hD; s2 = 4'hC;
        #10000000
        s1 = 4'hE; s2 = 4'hD;
        #10000000
        s1 = 4'hF; s2 = 4'hE;
        #10000000
        s1 = 4'h0; s2 = 4'hF;      
    end
endmodule