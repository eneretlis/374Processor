module reg32(
	input clr,
	input clk,
	input enable,
	input [31:0] D,
	output reg [31:0] Q
	);
	
	always @(posedge clk) 
	begin
		if (enable) 
			Q <= D;
		else if (clr) 
			Q = 32'b0;
	end	
endmodule