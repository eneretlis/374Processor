module and_32bit(
	input wire [31:0] Ra,
	input wire [31:0] Rb,
	output wire [31:0] Rc
	);

	
	assign Rc = Ra&&Rb;

endmodule 