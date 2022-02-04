module negate_32(
	input [31:0] initialVal
	output [31:0] newVal
	);
	wire [31:0] temp;
	not_32 notVal(initialVal,temp);
	//adddmodule
	addMod add(temp, 32'b01, newVal);
	
endmodule