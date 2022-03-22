module MDRUnit(input [31:0] a, b, input read, clr, clk, enable, output [31:0] out);
	//always @(posedge clk or posedge clr)
	//a = busmux out 
	// b = mdatain
	wire [31:0] MDMuxout;
	Mux_2_to_1 MDMux (a,b,read,MDMuxout);
	reg32 MDR (clr,clk,enable,MDMuxout,out);
endmodule
