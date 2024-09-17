// testbench for scanner module
// Avery Smith, 9/15/24, avsmith@hmc.edu
// modified from Harris & Harris, Digital Design and Computer Architecture: ARM edition
`timescale 1ns/1ns
module scanner_testbench();
    logic clk, reset;
    logic [3:0] col;
    logic [3:0] row;
    logic [4:0] button;

    // instantiate device under test
    scanner dut(clk, reset, col, row, button);

    // generate clock ~12MHz
    always begin
        clk = 1; #83;
        clk = 0; #83;
    end

    initial begin
        reset = 1; #69; reset = 0;
        #20
        col = 4'b1000;
        #1110000
        col = 4'b0000;
        #1001111
        col = 4'b0001;
        #1100000
        col = 4'b0011;
        #1000100
        col = 4'b0000;
        #1000000
        col = 4'b0100;
        #1000000
        col = 4'b0000;
        #9900000
        col = 4'b0001;
        #6002000
        col = 4'b0000;
        #1100600
        col = 4'b0001;
        #1001000
        col = 4'b0000;
        #4000300
        col = 4'b0001;
        #1111111
        col = 4'b0000;
        #394271
        col = 4'b0001;
        #1462638
        col = 4'b0000;
        #4206969
        col = 4'b0001;
        #2000000
        col = 4'b0000;
    end

endmodule