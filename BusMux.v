module bus_Mux(
	input [4:0] bus_signal,
	input [31:0] 	BusMuxInR0, BusMuxInR1, BusMuxInR2, BusMuxInR3, BusMuxInR4, BusMuxInR5, BusMuxInR6, BusMuxInR7, BusMuxInR8, BusMuxInR9, 
			BusMuxInR10, BusMuxInR11, BusMuxInR12, BusMuxInR13, BusMuxInR14, BusMuxInR15,
	input [31:0] Hi_Data_Out, Lo_Data_Out, ZHi_Data_Out, ZLo_Data_Out,
	input [31:0] PC_Data_Out, MDR_Data_Out, CValue,
	output reg [31:0] BusMuxOut
	);
	always @(*) begin
	case(bus_signal)
	0: BusMuxOut = BusMuxInR0;
	1: BusMuxOut = BusMuxInR1;
	2: BusMuxOut = BusMuxInR2;
	3: BusMuxOut = BusMuxInR3;
	4: BusMuxOut = BusMuxInR4;
	5: BusMuxOut = BusMuxInR5;
	6: BusMuxOut = BusMuxInR6;
	7: BusMuxOut = BusMuxInR7;
	8: BusMuxOut = BusMuxInR8;
	9: BusMuxOut = BusMuxInR9;
	10: BusMuxOut = BusMuxInR10;
	11: BusMuxOut = BusMuxInR11;
	12: BusMuxOut = BusMuxInR12;
	13: BusMuxOut= BusMuxInR13;
	14: BusMuxOut = BusMuxInR14;
	15: BusMuxOut = BusMuxInR15;
	16: BusMuxOut = Hi_Data_Out;
	17: BusMuxOut = Lo_Data_Out;
	18: BusMuxOut = ZHi_Data_Out;
	19: BusMuxOut = ZLo_Data_Out;
	20 : BusMuxOut = PC_Data_Out;
	21: BusMuxOut = MDR_Data_Out;
	//22: BusMuxOut = In_Portout;
	23: BusMuxOut = CValue;
	default:;
	endcase
	end
endmodule
