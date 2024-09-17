// testbench for top module
// Avery Smith, 9/15/24, avsmith@hmc.edu
// modified from Harris & Harris, Digital Design and Computer Architecture: ARM edition
`timescale 1ns/1ns
module top_testbench();
    logic reset;
    logic [3:0] col_in;
    logic [3:0] row;
    logic [6:0] seg;
    logic en1, en2;

    // instantiate device under test
    top dut(reset, col_in, row, seg, en1, en2);

    initial begin
        reset = 0; #69; reset = 1;
        #20
        col_in = 4'b0000;
        #5000000
        col_in = 4'b1000;
        #1110000
        col_in = 4'b0000;
        #1001111
        col_in = 4'b0001;
        #1100000
        col_in = 4'b0011;
        #1000100
        col_in = 4'b0000;
        #1000000
        col_in = 4'b0100;
        #1000000
        col_in = 4'b0000;
        #9900000
        col_in = 4'b0001;
        #6002000
        col_in = 4'b0000;
        #1100600
        col_in = 4'b0001;
        #1001000
        col_in = 4'b0000;
        #4000300
        col_in = 4'b0001;
        #1111111
        col_in = 4'b0000;
        #394271
        col_in = 4'b0001;
        #1462638
        col_in = 4'b0000;
        #4206969
        col_in = 4'b0001;
        #2000000
        col_in = 4'b0000;
    end

endmodule