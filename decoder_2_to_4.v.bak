module decoder_2_to_4(
	input [1:0] Code,
	output [4:0] Data
	);
	always @(Code)
	begin
		case(Code)
			2'b00 : Data <= 4'b0001;
			2'b01 : Data <= 4'b0010;
			2'b10 : Data <= 4'b0100;
			2'b11 : Data <= 4'b1000;
		endcase
	end
endmodule