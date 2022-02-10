//shift right 
//shr Ra, Rb, Rc
//shift right Rb into Ra by count in Rc
module shift_left (
	input [31:0] Rb, Rc,
	output [31:0] Ra
	);
	assign Ra=Rb<<Rc;
endmodule