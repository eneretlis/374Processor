module Mux_2_to_1(
	input [31:0] In0,
	input [31:0] In1,
	input Signal,
	output [31:0] Out
	);
	always @ (In0, In1)
		begin
			case(Signal)
				0: Out = In0;
				1: Out = In1;
				default: Out = 32'bx;
			endcase
		end
endmodule