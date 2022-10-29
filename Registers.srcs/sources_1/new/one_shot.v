//Takes board clock and creates single clock when button is pressed

module one_shot(
    input clk,
    input button,
    output reg pulse
);

// module one_shot(
//     .clk(),
//     .button(),
//     .pulse()
// );

reg q;

always @(posedge button or posedge pulse) begin
    if (pulse) begin
        q <=0;
    end else begin
        q <= 1;
    end
end

always @(posedge clk) begin
    pulse <= q;
end

endmodule