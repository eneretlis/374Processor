module c_flipflop(input D, C,
						output reg Q);
	always @(posedge C)
	begin 
		Q <= D;
	end
endmodule
