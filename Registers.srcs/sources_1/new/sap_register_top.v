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

// REG/ Wire Declarations

wire one_shot_clock;
wire reset;
wire latch;
wire enable;
wire button;

wire [7:0] w_bus;
reg [7:0] w_drive_r;
 
assign clk = sys_clk;
assign button = btn[0]; //Clock pulse signal
assign reset = btn[1];
assign latch = btn[2];
assign enable = btn[3];

// Structural Coding
clock_pulser clock_pulser_inst0(
     .clk(clk),
     .button(button),
     .one_clock_pulse(one_clock_pulse)
 );

sap_register sap_register_inst0(
    .clk(one_shot_clock),
    .reset(reset),
    .DATA(w_bus),
    .REG_OUT(),
    .latch(latch),
    .enable(enable)
    );
    
always @(posedge one_shot_clock) begin
    if (reset) begin
        w_drive_r <= 8'h42; //If the reset is high, we clear the contents of the register
    end else begin
        if(latch) begin
            w_drive_r <= w_drive_r + 1; //If no reset, begin filling register with data
        end 
   end
end  

assign w_bus = (latch) ? w_drive_r : 8'bZZZZZZZZ; //when latch signal is asserted w_bus == w_drive_r if not high impedance

endmodule