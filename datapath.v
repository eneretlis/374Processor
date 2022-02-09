module DataPath(
	input clk,
	input clr,
	//input wires for 35 to 5 encoder input R15out, R14out, 
	input reg [31:0] In.Port,
	output reg [31:0] Out.Port
	);
	reg [4:0] bus_signal;
	
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
	reg32 IR(clr, clk, IRIn, BusMuxOut, IR_Data_Out)
	reg32 Y(clr, clk, YIn, BusMuxOut, Y_Data_Out);
	//Z hi and lo 
	reg32 Z(clr, clk, ZIn, BusMuxOut, Z_Data_Out);
	reg32 MAR(clr, clk, MarIn, BusMuxOut, MAR_Data_Out);
	reg32 HI(clr, clk, HiIn, BusMuxOut, Hi_Data_Out);
	reg32 LO(clr, clk, LoIn, BusMuxOut, Lo_Data_Out);
	
	
	//32-to-5 encoder
	
	wire Rout = {R15out, R14out, R13out, R12out, R11out, R10out, R9out, R8out, R7out, R6out, R5out, R4out, R3out, R2out, R1out, R0out};
	32_to_5_encoder(bus_signal,{Cout, In.Portout, MDRout, PCout, Zlowout, Zhighout, LOout, HIout, Rout});
	
	//32-to-1 MUX
	//add signals here 
	busMux = (bus_signal,, BusMuxOut);
	
	
