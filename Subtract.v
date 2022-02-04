module subtract32 (
	input [31:0] Rb, Rc,
	output [31:0] Ra
	);
	wire [31:0] new;
	negate_32 negate(Rc,new);
	addmodule add(Rb, Rc, Ra);
	
endmodule
