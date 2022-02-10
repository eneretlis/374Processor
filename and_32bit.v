module and_32bit(
	input [31:0] Rb,
	input [31:0] Rc,
	output reg [31:0] Ra
	);

	
	assign Ra = Rb&&Rc;

endmodule 