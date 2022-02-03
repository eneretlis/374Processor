module and_32bit(
	input wire [31:0] Ra,
	input wire [31:0] Rb,
	output wire [31:0] Rc
	);

	integer i;
	for (i=0; i<32; i+1)
		begin
			assign Rc[i] = Ra[i]&Rb[i];
		end
endmodule 