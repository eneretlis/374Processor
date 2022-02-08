module or_32bit(
	input [31:0] Rb, Rc,
	output [31:0] Ra
	);
	
	assign Ra = Rb || Rc;
endmodule
