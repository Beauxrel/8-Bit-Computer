`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2022 08:36:47 AM
// Design Name: 
// Module Name: sap_register
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

//Generic Register
module sap_register(
    input clk,
    input reset,
    input [7:0] DATA, // 8-bit data port. Connects to W-bus
    output [7:0] REG_OUT, // 8-bits could be 4 depending on register.
    input latch,
    input enable
);
    
//instantiation
//    sap_register sap_register_inst0(
//.clk(),
//.reset(),
//.DATA(),
//.REG_OUT(),
//.latch(),
//.enable()
//    );

reg [7:0] r;

//if reset low and latch low register does not change with clk
//if latch is high DATA is latched to register
//DATA port is 4/8 bit input or output

always @(posedge(clk)) begin
    if (reset) begin
        r <= 0; //If the reset is high, we clear the contents of the register
    end else begin
        if(latch) begin
            r <= DATA; //If no reset, begin filling register with data
        end 
   end
end  

assign DATA = (enable)? r : 8'bZZZZZZZZ; //DATA port direction dependent on enable port
                                         //If enable is high contents of r -> Data port (write / output)
                                         //If enable is low; high impedance; Data port (Read / input) 
assign REG_OUT = r; // register r renamed to REG_OUT                                         

endmodule
