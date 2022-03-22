`timescale 1ns/10ps
module ld_tb;
	reg clk, clr, read, write;
	reg PCout, Zlowout, Zhighout, MDRout, Cout, IN_Portout;
	reg LOout, HIout, MARIn,PCIn, IRIn, YIn, IncPC, HiIn, LoIn, CIn, InIn, OutIn, ZIn, CONIn, Gra, Grb, Grc;
	reg MDRIn;
	reg RIn, Rout, BAout, add,subtract,multiply,divide, andSignal, orSignal;
	
	
	parameter Default = 4'b0000, T0 = 4'b0111, T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010,
				T4 = 4'b1011, T5 = 4'b1100, T6 = 4'b1101, T7 = 4'b1110;
	reg [3:0] Present_state = Default;
	
	datapath the_datapath(clk, clr, read, write, PCout, Zlowout, Zhighout, MDRout, Cout, IN_Portout,
<<<<<<< HEAD
							LOout, HIout, MARIn, PCIn, MDRIn, IRIn, YIn, IncPC, HiIn, LoIn, CIn, InIn, OutIn, ZIn, CONIn, Gra, Grb, Grc,
							RIn, Rout, BAout, add, subtract, multiply, divide, andSignal, orSignal);
=======
					LOout, HIout, MARIn, PCIn, MDRIn, IRIn, YIn, IncPC, 
			      		HiIn, LoIn, CIn, InIn, OutIn, ZIn, CONIn, Gra, Grb, Grc,
					RIn, Rout, BAout, add, subtract, multiply, divide);
>>>>>>> 28f325d470417047eeffbd9c53529ade81a6399d
	initial
		begin
			clk = 0;
			clr = 1;
			forever #10 clk=~clk;
	end
	
	always@(posedge clk)
		begin
			case(Present_state)
				Default : #40 Present_state = T0;
				T0 : #40 Present_state = T1;
				T1 : #40 Present_state = T2;
				T2 : #40 Present_state = T3;
				T3 : #40 Present_state = T4;
				T4 : #40 Present_state = T5;
				T5 : #40 Present_state = T6;
				T6 : #40 Present_state = T7;				
			endcase
		end
	always @(Present_state)
		begin
			case(Present_state)
				Default: begin	
					PCout <=0; Zlowout <=0; MDRout <=0; 
					MARIn <= 0; ZIn <= 0; CONIn <=0; InIn <= 0; OutIn<=0;
					PCIn <=0; MDRIn <= 0; IRIn <=0; YIn <=0; 
					IncPC <=0; read <=0; write <=0; 
					Gra <=0; Grb<=0; Grc<=0;
					BAout <= 0; Cout <= 0; IN_Portout <=0; Zhighout <= 0; LOout<=0;
					HIout <= 0; HiIn <= 0; LoIn <=0; Rout <= 0; RIn<=0;
					add <= 0; subtract <=0; divide<=0; multiply <=0; andSignal<=0; orSignal<=0;
				end
				T0: begin
					clr<=0;
					IncPC <=1; 
					PCout <= 1; MARIn <=1;
					#30 PCout <= 0; MARIn <= 0;
					//IncPC, ZIn
				end
				T1 : begin
					Zlowout <=1; PCIn <=1; 
					MDRIn <=1; read <= 1; 
					#30 MDRIn <=0; read<=0; Zlowout <=0;
				end
				T2 : begin
					MDRout <=1; IRIn <= 1; 
					#30 MDRout <=0; IRIn <=0;
				end
				T3 : begin
					Grb <=1; BAout <=1; YIn<=1;
					#30 Grb <=0; BAout <=0; YIn<=0;
				end
				T4 : begin
					add <=1;
					Cout <=1; ZIn <=1;
					#30 Cout <=0; ZIn <=0; 
				end
				T5 : begin
					Zlowout <=1; MARIn <=1;
					#30 Zlowout <= 0; MARIn <=0;
				end
				T6: begin
				//need instruction
					read <=1; MDRIn <=1;
					#30 read <=0; MDRIn <=0;
				end
				T7: begin
					MDRout <= 1; Gra <=1; RIn <=1;
				end
			endcase
		end
endmodule
				
				
				
				
				
				
				
				
				
				
	
	
	

	
	
	
