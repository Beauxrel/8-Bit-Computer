`timescale 1ns / 1ps

module sap_register_top(
input sys_clk,
input [3:0] btn,
input [3:0] sw,
output [3:0] led,
output [6:0] jc,
output ca
    );

// REG/ Wire Declarations

wire one_shot_clock;
wire reset;
wire latch;
wire enable;
wire button;

wire [7:0] w_bus;
reg [7:0] w_drive_r;

wire [7:0] register_output;

//Display Wires
wire [7:0] disp0,disp1;
wire displayClock;
 
assign clk = sys_clk;
assign button = btn[0]; //Clock pulse signal
assign reset = btn[1];
assign latch = btn[2];
assign enable = btn[3];

// Structural Coding
clock_pulser clock_pulser(
     .clk(clk),
     .button(button),
     .one_clock_pulse(one_shot_clock)
 );

sap_register sap_register_A(
    .clk(one_shot_clock),
    .reset(reset),
    .DATA(w_bus),
    .REG_OUT(register_output),
    .latch(latch),
    .enable(enable)
    );
    
nibble_to_seven_seg nibble0(
		.nibblein(register_output[3:0]),
		.segout(disp0)
	);	 
	
nibble_to_seven_seg nibble1(
		.nibblein(register_output[7:4]),
		.segout(disp1)
	);	

clk_wiz_0 clock_wizard_0
   (
    // Clock out ports
    .clk_out1(clk_12),     // output clk_out1
    // Status and control signals
    .reset(1'b0), // input reset
    .locked(),       // output locked
   // Clock in ports
    .clk_in1(sys_clk)      // input clk_in1
);
	 
clkdiv displayClockGen(
		.clk(clk_12),
		.clkout(displayClock)
	);

seven_seg_mux display(
		.clk(displayClock),
		.disp0(disp0),
		.disp1(disp1),
		.segout(jc),
		.disp_sel(ca)
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