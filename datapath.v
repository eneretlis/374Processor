module datapath(
	//inputs and outputs correspond to testbench 
	input clk, clr,
	//MDR
	input read, write,
	//select for other registers
	input PCout, Zlowout, Zhighout, MDRout,
	input Cout, In_Portout, LOout, HIout, 
	//enable for others
	input MARIn, PCIn, MDRIn, IRIn, YIn, IncPC, HiIn, LoIn, CIn,InIn, OutIn, ZIn, CONIn, 
	//for select and encode logic
	input Gra, Grb, Grc, Rin, Rout, BAout,
	input add,subtract,multiply,divide, andSignal, orSignal);
	//slect and encode for general purpose registeters
	wire [15:0] RegIn, Regout;
	//Bus contents
	wire [31:0] BusMuxOut;
	//encoder signal
	wire [4:0] bus_signal;
	//define wires for the busMux, is the output of the data registers
	wire [31:0] BusMuxInR0, BusMuxInR1, BusMuxInR2, BusMuxInR3, BusMuxInR4, BusMuxInR5, BusMuxInR6, BusMuxInR7, BusMuxInR8, BusMuxInR9,
		 BusMuxInR10, BusMuxInR11, BusMuxInR12, BusMuxInR13, BusMuxInR14, BusMuxInR15, PC_Data_Out, IR_Data_Out, 
		 ZLo_Data_Out, Y_Data_Out, ZHi_Data_Out, Lo_Data_Out, Hi_Data_Out, MDR_data_out, CValue, Out_data_out, In_data_out;
	//Z data in
	wire [31:0] ZHiDataIn, ZLoDataIn;
	//select and encode 
	wire [4:0] opcode;
	wire [31:0] C_sign_exteneded;
	wire [31:0] Mdatain;
	//MAR address 
	wire [8:0] Address;	
	//CONff
	wire CONout;
	//new r0
	wire [31:0] out_to_and;
	// define registers
	//16 general purpose registers
	reg32 R0(clr,clk,RegIn[0],BusMuxOut,out_to_and);
	assign BusMuxInR0 = {16{!BAout}} & out_to_and;
	reg32 R1(clr,clk,RegIn[1],BusMuxOut,BusMuxInR1);
	reg32 R2(clr,clk,RegIn[2],BusMuxOut,BusMuxInR2);
	reg32 R3(clr,clk,RegIn[3],BusMuxOut,BusMuxInR3);
	reg32 R4(clr,clk,RegIn[4],BusMuxOut,BusMuxInR4);
	reg32 R5(clr,clk,RegIn[5],BusMuxOut,BusMuxInR5);
	reg32 R6(clr,clk,RegIn[6],BusMuxOut,BusMuxInR6);
	reg32 R7(clr,clk,RegIn[7],BusMuxOut,BusMuxInR7);
	reg32 R8(clr,clk,RegIn[8],BusMuxOut,BusMuxInR8);
	reg32 R9(clr,clk,RegIn[9],BusMuxOut,BusMuxInR9);
	reg32 R10(clr,clk,RegIn[10],BusMuxOut,BusMuxInR10);
	reg32 R11(clr,clk,RegIn[11],BusMuxOut,BusMuxInR11);
	reg32 R12(clr,clk,RegIn[12],BusMuxOut,BusMuxInR12);
	reg32 R13(clr,clk,RegIn[13],BusMuxOut,BusMuxInR13);
	reg32 R14(clr,clk,RegIn[14],BusMuxOut,BusMuxInR14);
	reg32 R15(clr,clk,RegIn[15],BusMuxOut,BusMuxInR15);
	//special registers
	reg32 PC(clr, clk, PCIn, BusMuxOut, PC_Data_Out);
	//Maybe this Should be defined somehwere
	reg32 IR(clr, clk, IRIn, BusMuxOut, IR_Data_Out);
	reg32 Y(clr, clk, YIn, BusMuxOut, Y_Data_Out);
	//still unsure
	reg32 ZHI(clr, clk, ZIn, ZHiDataIn, ZHi_Data_Out);
	reg32 ZLO(clr, clk, ZIn, ZLoDataIn, ZLo_Data_Out);
	reg32 HI(clr, clk, HiIn, BusMuxOut, Hi_Data_Out);
	reg32 LO(clr, clk, LoIn, BusMuxOut, Lo_Data_Out);
	//reg32 C(clr, clk, CIn, BusMuxOut, CValue);

	//define MDR
	MDRUnit MDR(BusMuxOut, Mdatain, read, clr, clk, MDRIn, MDR_data_out);
	
	//32-to-5 encoder
	wire [31:0] Data = {Cout, In_Portout, MDRout, PCout, Zlowout, Zhighout, LOout, HIout, Regout[15], Regout[14], 
			    Regout[13], Regout[12], Regout[11], Regout[10], Regout[9], Regout[8], Regout[7], Regout[6], Regout[5], Regout[4],
				 Regout[3], Regout[2], Regout[1], Regout[0]};
	encoder_32_to_5 Encoder1(bus_signal,Data);
	
	//32-to-1 MUX
	//PROBLEMS HERE
	bus_Mux Bus_inst(bus_signal,BusMuxInR0, BusMuxInR1, BusMuxInR2, BusMuxInR3, BusMuxInR4, BusMuxInR5, BusMuxInR6,
			 BusMuxInR7, BusMuxInR8, BusMuxInR9, BusMuxInR10, BusMuxInR11, BusMuxInR12, BusMuxInR13, BusMuxInR14, 
			 BusMuxInR15, Hi_Data_Out, Lo_Data_Out, ZHi_Data_Out, ZLo_Data_Out, PC_Data_Out, MDR_data_out, C_sign_exteneded, BusMuxOut);
	
	//call ALU
	ALU the_ALU(add,subtract, multiplySignal, divideSignal, andSignal, orSignal, shrSignal, ShlSignal,
					RorSignal, RolSignal, NegSignal, NotSignal,Y_Data_Out, BusMuxOut,ZHiDataIn, ZLoDataIn);
	//MAR 
	MARUnit the_MAR(clk, clr, MARIn, BusMuxOut, Address);
	//RAM 
	//RAM the_RAM(clk, write, read, MDR_data_out, Address, Mdatain);
	ramWizard the_ramWaizard(Address, clk, MDR_data_out, write, Mdatain);
	
	//select and Encoder
	SelectandEncode sel(IR_Data_Out, Gra,Grb,Grc,Rin,Rout,BAout,Regout, RegIn, opcode, C_sign_exteneded);
	//conff
	CON_FF the_conff(CONIn, BusMuxOut,IR_Data_Out[20:19], CONout);
	//input and output ports
	reg32 outputPort(clr,clk,OutIn,BusMuxOut, Out_data_out);
	reg32 inputPort(clr,clk,InIn,BusMuxOut, In_data_out);
	
endmodule
