module pcReg32(
	input clk, IncPC, enable,
	input [31:0] D,
	output reg[31:0] Q);
	initial Q = 0;
	
	always @(posedge clk)
		begin	
			if(enable ==1 && IncPC == 0) Q = D;
		end
		
	always @(posedge IncPC)
		begin
		Q = Q+1;
		end
	endmodule