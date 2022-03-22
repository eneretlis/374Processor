`timescale 1ns/1ps
module MARUnit(input clk, clr, MARIn,
					input [31:0] BusMuxOut,
					output [8:0] addr);
	wire [31:0] MAROut;
	reg32 MAR(clr,clk, MARIn,BusMuxOut,MAROut);
	assign addr = MAROut[8:0];
endmodule 