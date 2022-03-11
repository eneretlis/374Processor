module decoder_4_to_16(
	input [3:0] Code,
	output [15:0] Data
	);
	always @(Code)
	begin
		case(Code)
			4'b0000 : Data <= 16'h0001;
			4'b0001 : Data <= 16'h0002;
			4'b0010 : Data <= 16'h0004;
			4'b0011 : Data <= 16'h0008;
			4'b0100 : Data <= 16'h0010;
			4'b0101 : Data <= 16'h0020;
			4'b0110 : Data <= 16'h0040;
			4'b0111 : Data <= 16'h0080;
			4'b1000 : Data <= 16'h0100;
			4'b1001 : Data <= 16'h0200;
			4'b1010 : Data <= 16'h0400;
			4'b1011 : Data <= 16'h0800;
			4'b1100 : Data <= 16'h01000;
			4'b1101 : Data <= 16'h02000;
			4'b1110 : Data <= 16'h04000;
			4'b1111 : Data <= 16'h08000;
		endcase
	end
endmodule
			