`timescale 1ns/10ps
module tb_and();
	reg [31:0] Ra, Rb, out1;
	
	and_32bit A1(Ra,Rb,out1);
	initial begin
		#100 $finish;
	end
	initial
	Ra = 32'b01;
	Rb = 32'b010;
	begin
	$display(out1);
	end
endmodule