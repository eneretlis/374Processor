module or(
	input [31:0] Ra, Rb,
	output [31:0] Rc
	);
	
	assign Rc = Ra || Rb;
endmodule
