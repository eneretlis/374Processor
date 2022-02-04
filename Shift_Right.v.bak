//shift right 
//shr Ra, Rb, Rc
//shift right Rb into Ra by count in Rc
module shift_right (
	input [31:0] Rb, Rc,
	output [31:0] Ra
	);
	reg [31:0] temp_reg;
	count = 0;
	temp_reg = Rc;
	while(temp_reg)
		begin
		if(temp_reg[0]) count = count +1;
			temp_reg = temp _reg >> 1;
		end
	end
	
	Ra = Rb;
	integer i;
	for(i = count; i; i = i-1)
	begin
		Ra >> 1;
	end
	
endmodule