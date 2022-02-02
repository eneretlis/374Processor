module reg32(clr,clk,enable,D,Q);
	input [31:0] D;
	input clk;
	input clr;
	input enable;
	output reg [31:0] Q;
	always @(posedge clk) 
		begin
		if (enable)
			Q <= D;
		end
		
endmodule