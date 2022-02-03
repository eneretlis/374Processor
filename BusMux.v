module busMux(
	input [5:0] Select,
	input [31:0] BusMuxInR0, BusMuxInR1, BusMuxInR2, BusMuxInR3, BusMuxInR4, BusMuxInR5, BusMuxInR6, BusMuxInR7, BusMuxInR8, BusMuxInR9, BusMuxInR10, BusMuxInR11, BusMuxInR12, BusMuxInR13, BusMuxInR14, BusMuxInR14,
	input [31:0] BusMuxInHI, BusMuxInLO, BusMuxInZHi, BusMuxInZLo,
	input [31:0] BusMuxInPC, BusMuxInMDR, BusMuxInPort, Csignex,
	output [31:0] mux_out
	);
	always @(*) begin
	case(Select)
	0: mux_out = BusMuxInR0;
	1: mux_out = BusMuxInR1;
	2: mux_out = BusMuxInR2;
	3: mux_out = BusMuxInR3;
	4: mux_out = BusMuxInR4;
	5: mux_out = BusMuxInR5;
	6: mux_out = BusMuxInR6;
	7: mux_out = BusMuxInR7;
	8: mux_out = BusMuxInR8;
	9: mux_out = BusMuxInR9;
	10: mux_out = BusMuxInR10;
	11: mux_out = BusMuxInR11;
	12: mux_out = BusMuxInR12;
	13: mux_out = BusMuxInR13;
	14: mux_out = BusMuxInR14;
	15: mux_out = BusMuxInR15;
	16: mux_out = BusMuxInHI;
	17: mux_out = BusMuxInLO;
	18: mux_out = BusMuxInZHi;
	19: mux_out = BusMuxInZLo;
	20: mux_out = BusMuxInPC;
	21: mux_out = BusMuxInMDR;
	22: mux_out = BusMuxInPort;
	23: mux_out = Csignex;
	default: mux_out = 32'bx;
	endcase
	end
endmodule