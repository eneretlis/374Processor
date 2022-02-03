module and_32bit(
	input wire [31:0] Ra,
	input wire [31:0] Rb,
	output wire [31:0] Rc
	);

	integer a;
	for (a=0; a<32; a+1)
		begin
			assign Rc[a] = Ra[a]&&Rb[a];
		end
endmodule 