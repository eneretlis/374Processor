module and_32bit(
	input [31:0] Ra,
	input [31:0] Rb,
	output reg [31:0] Rc
	);

	
	assign Rc <= Ra&&Rb;

endmodule 