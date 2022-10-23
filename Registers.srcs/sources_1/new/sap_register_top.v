`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2022 08:35:40 AM
// Design Name: 
// Module Name: sap_register_top
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


module sap_register_top(
input sys_clk,
input [3:0] btn,
input [3:0] sw,
output [3:0] led
    );
endmodule

wire one_shot_clock;
wire reset;
wire latch;
wire enable;

assign one_shot_clock = btn[0];
assign reset = btn[1];
assign latch = btn[2];
assign enable = btn[3];

sap_register sap_register_inst0(
    .clk(one_shot_clock),
    .reset(reset),
    .DATA(),
    .REG_OUT(),
    .latch(latch),
    .enable(enable)
    );
one_shot one_shot_inst0(
    .clk(),
    .button(),
    .pulse()
    );