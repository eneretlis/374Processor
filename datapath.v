module datapath(
	//inputs and outputs correspond to testbench 
	input PCout, Zlowout, Zhighout, MDRout, R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,
	input Cout, In_Portout, LOout, HIout, 
	input MARIn, ZIn, PCIn, MDRIn, IRIn, YIn, IncPC, HiIn, LoIn, CIn,
	input read,
	input R0In, R1In, R2In, R3In, R4In, R5In, R6In, R7In, R8In, R9In, R10In, R11In, R12In, R13In, R14In, R15In, 
	input clk,
	input [4:0] opcode,
	input [31:0] Mdatain
	);
	//define bus_signal to be used as output of the 32 to 5 encoder
	wire [31:0] BusMuxOut;
	wire [4:0] bus_signal;
	wire clr;
	wire [31:0] BusMuxInR0, BusMuxInR1, BusMuxInR2, BusMuxInR3, BusMuxInR4, BusMuxInR5, BusMuxInR6, BusMuxInR7, BusMuxInR8, BusMuxInR9,
		 BusMuxInR10, BusMuxInR11, BusMuxInR12, BusMuxInR13, BusMuxInR14, BusMuxInR15, PC_Data_Out, IR_Data_Out, 
		 ZLo_Data_Out, Y_Data_Out, ZHi_Data_Out, Lo_Data_Out, Hi_Data_Out, MDR_data_out, CValue;
	wire [8:0] Address;
	//MAYBE INPUT AS TESTBENCH 
	wire read, write;
	// define registers
	
	reg32 R0(clr,clk,R0In,BusMuxOut,BusMuxInR0);
	reg32 R1(clr,clk,R1In,BusMuxOut,BusMuxInR1);
	reg32 R2(clr,clk,R2In,BusMuxOut,BusMuxInR2);
	reg32 R3(clr,clk,R3In,BusMuxOut,BusMuxInR3);
	reg32 R4(clr,clk,R4In,BusMuxOut,BusMuxInR4);
	reg32 R5(clr,clk,R5In,BusMuxOut,BusMuxInR5);
	reg32 R6(clr,clk,R6In,BusMuxOut,BusMuxInR6);
	reg32 R7(clr,clk,R7In,BusMuxOut,BusMuxInR7);
	reg32 R8(clr,clk,R8In,BusMuxOut,BusMuxInR8);
	reg32 R9(clr,clk,R9In,BusMuxOut,BusMuxInR9);
	reg32 R10(clr,clk,R10In,BusMuxOut,BusMuxInR10);
	reg32 R11(clr,clk,R11In,BusMuxOut,BusMuxInR11);
	reg32 R12(clr,clk,R12In,BusMuxOut,BusMuxInR12);
	reg32 R13(clr,clk,R13In,BusMuxOut,BusMuxInR13);
	reg32 R14(clr,clk,R14In,BusMuxOut,BusMuxInR14);
	reg32 R15(clr,clk,R15In,BusMuxOut,BusMuxInR15);
	
	reg32 PC(clr, clk, PCIn, BusMuxOut, PC_Data_Out);
	reg32 IR(clr, clk, IRIn, BusMuxOut, IR_Data_Out);
	reg32 Y(clr, clk, YIn, BusMuxOut, Y_Data_Out);
	//still unsure
	reg32 ZHI(clr, clk, ZIn, BusMuxOut, ZHi_Data_Out);
	reg32 ZLO(clr, clk, ZIn, BusMuxOut, ZLo_Data_Out);
	reg32 HI(clr, clk, HiIn, BusMuxOut, Hi_Data_Out);
	reg32 LO(clr, clk, LoIn, BusMuxOut, Lo_Data_Out);
	reg32 C(clr, clk, CIn, BusMuxOut, CValue);

	//define MDR
	MDRUnit MDR(BusMuxOut, Mdatain, read, clr, clk, MDRIn, MDR_data_out);
	
	//32-to-5 encoder
	wire [31:0] Data = {Cout, In_Portout, MDRout, PCout, Zlowout, Zhighout, LOout, HIout, R15out, R14out, 
			    R13out, R12out, R11out, R10out, R9out, R8out, R7out, R6out, R5out, R4out, R3out, R2out, R1out, R0out};
	encoder_32_to_5 Encoder1(bus_signal,Data);
	
	//32-to-1 MUX
	//add signals here 
	//PROBLEMS HERE
	bus_Mux Bus_inst(bus_signal,BusMuxInR0, BusMuxInR1, BusMuxInR2, BusMuxInR3, BusMuxInR4, BusMuxInR5, BusMuxInR6,
			 BusMuxInR7, BusMuxInR8, BusMuxInR9, BusMuxInR10, BusMuxInR11, BusMuxInR12, BusMuxInR13, BusMuxInR14, 
			 BusMuxInR15, Hi_Data_Out, Lo_Data_Out, ZHi_Data_Out, ZLo_Data_Out, PC_Data_Out, MDR_data_out, CValue, BusMuxOut);
	
	//call ALU
	ALU the_ALU(opcode,Y_Data_Out, BusMuxOut, ZHi_Data_Out, ZLo_Data_Out);
	
	//MAR 
	MAR the_MAR(clk, clr, MARIn, BusMuxOut, Address);
	//RAM 
	RAM the_RAM(clk, write, read, MDR_data_out, Address, Mdatain);
	
endmodule
