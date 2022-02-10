module not_32(
	input [31:0] Rb,
	output [31:0] Ra
	);
	assign Ra = !Rb;
endmodule
