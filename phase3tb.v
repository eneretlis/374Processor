`timescale 1ns/10ps
module phase3_tb;
	reg Clock, Reset, Stop, Con_FF;
	
	CPU the_cpu(Clock, Reset, Stop, Con_FF);
	initial
		begin
			Clock = 0;
			Reset = 0;
			forever #10 Clock = ~Clock;
		end
endmodule
