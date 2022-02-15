module Mux_2_to_1(
	input [31:0] In0,//a = busmx out
	input [31:0] In1,
	input Signal,
	output reg [31:0] Out
	);
	always @ (In0, In1)
		begin
			case(Signal)
				0: Out = In0;
				1: Out = In1;
			endcase
		end
endmodule