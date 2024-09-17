// testbench for debouncer module
// Avery Smith, 9/15/24, avsmith@hmc.edu
// modified from Harris & Harris, Digital Design and Computer Architecture: ARM edition
`timescale 1ns/1ns
module debouncer_testbench();
    logic clk, reset;
    logic [4:0] button;
    logic pulse;
    logic [3:0] deb_button;
    logic [31:0] vectornum;
    logic [4:0] testvectors[10000:0];

    // instantiate device under test
    debouncer dut(clk, reset, button, pulse, deb_button);

    // generate clock ~12MHz
    always begin
        clk = 1; #83;
        clk = 0; #83;
    end
    // at start of test, load vectors
    // and pulse reset
    initial
        begin
        $readmemb("debouncer_testbench.tv", testvectors);
        vectornum = 0;
        reset = 1; #69; reset = 0;
    end

    logic apply_tvs;

    //generate 10kHz apply apply_tvs signal
    always begin
        apply_tvs = 1; #100000;
        apply_tvs = 0; #100000;
    end

    // apply test vectors on rising edge of apply_tvs
    always @(posedge apply_tvs) begin
        #1; {button} = testvectors[vectornum];
    end

    // check results on falling edge of apply_tvs
    always @(negedge apply_tvs) begin
        vectornum = vectornum + 1;
        if (testvectors[vectornum] === 5'bx) begin
            $display("%d tests completed", vectornum);
        end
    end
endmodule