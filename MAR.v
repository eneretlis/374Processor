`timescale 1ns/1ps
module MARUnit(input clk, clr, MARIn,
					input [31:0] BusMuxOut,
					output [8:0] addr);
	wire [31:0] MAROut;
	Reg32 MAR(clk,clr,MARIn,BusMuxOut,MAROut);
	assign addr = MAROut[8:0];
endmodule 