module divide_32(
	input [31:0] Ra, Rb,
	output [31:0] quotient, remainder
	);
	assign remainder = Ra%Rb;
	assign quoitent = (Ra-remainder)/Rb;
	
endmodule