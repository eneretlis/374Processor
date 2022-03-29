module CPU(
	input [31:0] IR,
	input Clock, Reset, Stop, Con_FF);
	
	wire Gra, Grb, Grc, RIn, BAout, Rout, 
		MARIn, PCIn, MDRIn, IRIn, YIn, IncPC, HiIn, LoIn, CIn,InIn, OutIn, ZIn, CONIn,
		PCout, Zlowout, Zhighout, MDRout, Cout, In_Portout, LOout, HIout,
		Read, Write, Clear,
		ADD, AND, SUB, DIV, SHR, SHL, ROR, ROL, OR, MUL, NEG, NOT;
	
	control_unit the_controlUnit(Gra, Grb, Grc, RIn, BAout, Rout, 
					MARIn, PCIn, MDRIn, IRIn, YIn, IncPC, HiIn, LoIn, CIn,InIn, OutIn, ZIn, CONIn,
					PCout, Zlowout, Zhighout, MDRout, Cout, In_Portout, LOout, HIout,
					Read, Write, Clear,
					ADD, AND, SUB, DIV, SHR, SHL, ROR, ROL, OR, MUL, NEG, NOT,
					IR, Clock, Reset, Stop, Con_FF);
					
	datapath the_datapath(Clock, Reset, Read, Write, PCout, Zlowout, Zhighout,
									MDRout, Cout, In_Portout, LOout, HIout, MArIn,
									PCIn, MDRIn, IRIn, YIn, IncPC, HiIn, LoIn, CIn,
									InIn, OutIn, ZIn, CONIn, Gra, Grb, Grc, RIn, Rout, BAout,
									ADD, SUB, MUL, DIV, AND, OR, SHR, SHL, ROR, ROL, NEG, NOT);
	endmodule
		