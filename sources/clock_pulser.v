//Combines Debounce and One-Shot into single module

module clock_pulser(
    input clk,
    input button,
    output one_clock_pulse
);

// module clock_pulser(
//     .clk(),
//     .button(),
//     .one_clock_pulse()
// );

wire pulse_debounced;
wire one_shot_clock;

debounce debounce_inst0(
    .clk(clk),
    .sw_in(button),
    .sw_debounced(pulse_debounced)
);

one_shot one_shot_inst0(
    .clk(clk),
    .button(pulse_debounced),
    .pulse(one_shot_clock)
);

assign one_clock_pulse = one_shot_clock;

endmodule