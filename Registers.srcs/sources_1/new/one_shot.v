`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2022 09:06:22 AM
// Design Name: 
// Module Name: one_shot
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module one_shot(
    input clk,
    input button,
    output reg pulse
    );

reg q;

always @(posedge button or posedge pulse) begin
    if(pulse) begin
        q <= 0;
    end else begin
        q <= 1;
    end
end

always @(posedge clk) begin
    pulse <= q;
end

endmodule
