module encoder_32_to_5(
	output reg [4:0] Code,
	input [31:0] Data
	);
	always @(Data)
	begin
		if(Data == 32'h00000001) Code = 0; else
		if(Data == 32'h00000002) Code = 1; else
		if(Data == 32'h00000004) Code = 2; else
		if(Data == 32'h00000008) Code = 3; else
		if(Data == 32'h00000010) Code = 4; else
		if(Data == 32'h00000020) Code = 5; else
		if(Data == 32'h00000040) Code = 6; else
		if(Data == 32'h00000080) Code = 7; else
		if(Data == 32'h00000100) Code = 8; else
		if(Data == 32'h00000200) Code = 9; else
		if(Data == 32'h00000400) Code = 10; else
		if(Data == 32'h00000800) Code = 11; else
		if(Data == 32'h00001000) Code = 12; else
		if(Data == 32'h00002000) Code = 13; else
		if(Data == 32'h00004000) Code = 14; else
		if(Data == 32'h00008000) Code = 15; else
		if(Data == 32'h00010000) Code = 16; else
		if(Data == 32'h00020000) Code = 17; else
		if(Data == 32'h00040000) Code = 18; else
		if(Data == 32'h00080000) Code = 19; else
		if(Data == 32'h00100000) Code = 20; else
		if(Data == 32'h00200000) Code = 21; else
		if(Data == 32'h00400000) Code = 22; else
		if(Data == 32'h00800000) Code = 23; else
		if(Data == 32'h01000000) Code = 24; else Code = 31;
	
	end
endmodule