// Avery Smith, avsmith@hmc.edu, 9/15/24

//enabled shift register stores current and last input. Shifts when a new input arrives (designated by pulse)

module shift_register(input logic clk, reset, pulse, 
                      input logic [3:0] deb_button,
                      output logic [3:0] current, last
);

always_ff @(posedge clk) begin
    if (reset) begin current <= 4'h0; last <= 4'h0; end
    else if (pulse) begin
        last <= current;
        current <= deb_button;
    end
end



endmodule