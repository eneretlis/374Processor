module pcReg32(
	input clk, IncPC, enable,
	input [31:0] D,
	output reg[31:0] Q);
	initial Q = 0;
	
	always @(posedge clk)
		begin	
			if(IncPC ==1 && enable ==1) Q = Q+1;
			else if(enable ==1) Q = D;
		end
	endmodule