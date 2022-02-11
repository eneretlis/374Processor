module subtract32 (
	input [31:0] Rb, Rc,
	output [31:0] Ra
	);
	wire [31:0] newWire;
	negate_32 negate(Rc,new);
	addmodule add_RCA_32(Ra, Rb, new);
	
endmodule
