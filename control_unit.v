`timescale 1ns/10ps
module control_unit (
	output reg Gra, Grb, Grc, RIn, BAout, Rout, // here, you will define the inputs and outputs to your Control Unit
					MARIn, PCIn, MDRIn, IRIn, YIn, IncPC, HiIn, LoIn, CIn,InIn, OutIn, ZIn, CONIn,
					PCout, Zlowout, Zhighout, MDRout, Cout, In_Portout, LOout, HIout,
					Read, Write, Clear,
					ADD, AND, SUB, DIV, SHR, SHL, ROR, ROL, OR, MUL, NEG, NOT,
	input [31:0] IR,
	input Clock, Reset, Stop, Con_FF);
	parameter Reset_state = 8'b0000, fetch0 = 8'b0001, fetch1 = 8'b0010, fetch2a = 8'b0011,
				add3 = 8'b0100, add4 = 8'b0101, add5 = 8'b0110,
				sub3 = 8'b0111, sub4 = 8'b01000, sub5 = 8'b01001,
				mul3 = 8'b01010, mul4 = 8'b01011, mul5 = 8'b01100, mul6 = 8'b01101,
				div3 = 8'b01110, div4 = 8'b01111, div5 = 8'b010000, div6 = 8'b010001,
				shr3 = 8'b010010, shr4 = 8'b010011, shr5 = 8'b010100,
				shl3 = 8'b010101, shl4 = 8'b010110, shl5 = 8'b010111,
				ror3 = 8'b011000, ror4 = 8'b011001, ror5 = 8'b011010,
				rol3 = 8'b011011, rol4 = 8'b011100, rol5 = 8'b011101,
				neg3 = 8'b011110, neg4 = 8'b011111,
				not3 = 8'b0100000, not4 = 8'b0100001,
				ld3 = 8'b0100010, ld4 = 8'b01100011, ld5 = 8'b0100100, ld6 = 8'b0100101, ld7 = 8'b0100110,
				ldi3 = 8'b0100111, ldi4 = 8'b0101000, ldi5 = 8'b0101001,
				st3 = 8'b0101010, st4 = 8'b0101011, st5 = 8'b0101100, st6 = 8'b00101101, st7 = 8'b0101110,
				addi3 = 8'b0101111, addi4 = 8'b0110000, addi5 = 8'b0110001,
				andi3 = 8'b0110010, andi4 = 8'b0110011, andi5 = 8'b0110100,
				ori3 = 8'b0110101, ori4 = 8'b0110110, ori5 = 8'b0110111,
				br3 = 8'b0111000, br4 = 8'b0111001, br5 = 8'b0111010, br6 = 8'b0111011, br7 = 8'b0111100,
				jr3 = 8'b0111101,
				jal3 = 8'b0111110, jal4= 8'b0111111,
				mfhi3 = 8'b01000000, mflo3 = 8'b01000001,
				in3 = 8'b01000010, out3 = 8'b01000011,
				and3 = 8'b01000100, and4 = 8'b01000101, and5 = 8'b01000110,
				or3 = 8'b01000111, or4 = 8'b01001000, or5 = 8'b1001001,
				halt3 = 8'b1001010, fetch2b = 8'b1001011;
	reg [8:0] Present_state = Reset_state; // adjust the bit pattern based on the number of states
	always @(posedge Clock, posedge Reset) // finite state machine; if clock or reset rising-edge
		begin
			if (Reset == 1'b1) Present_state = Reset_state;
			else begin
			case (Present_state)
				Reset_state : #40 Present_state = fetch0;
				fetch0 : #40 Present_state = fetch1;
				fetch1 : #40 Present_state = fetch2a;
				fetch2a : #40 Present_state = fetch2b;
				fetch2b : begin
								case (IR[31:27]) // inst. decoding based on the opcode to set the next state
									5'b00011 : #40 Present_state = add3; // this is the add instruction
									5'b00100 : #40 Present_state = sub3;
									5'b00101 : #40 Present_state = shr3;
									5'b00110 : #40 Present_state = shl3;
									5'b00111 : #40 Present_state = ror3;
									5'b01000 : #40 Present_state = rol3;
									5'b01001 : #40 Present_state = and3;
									5'b01010 : #40 Present_state = or3;
									5'b01011 : #40 Present_state = addi3;
									5'b01100 : #40 Present_state = andi3;
									5'b01101 : #40 Present_state = ori3;
									5'b01110 : #40 Present_state = mul3;
									5'b01111 : #40 Present_state = div3;
									5'b10000 : #40 Present_state = neg3;
									5'b10001 : #40 Present_state = not3;
									5'b10010 : #40 Present_state = br3;
									5'b10011 : #40 Present_state = jr3;
									5'b10100 : #40 Present_state = jal3;
									5'b10101 : #40 Present_state = in3;
									5'b10110 : #40 Present_state = out3;
									5'b10111 : #40 Present_state = mfhi3;
									5'b11000 : #40 Present_state = mflo3;
									5'b11010 : #40 Present_state = halt3;
									5'b00000 : #40 Present_state = ld3;
									5'b00001 : #40 Present_state = ldi3;
									5'b00010 : #40 Present_state = st3;
								endcase
							end
				add3 : #40 Present_state = add4;
				add4 : #40 Present_state = add5;
				add5 : #40 Present_state = Reset_state;
				sub3 : #40 Present_state = sub4;
				sub4 : #40 Present_state = sub5;
				sub5 : #40 Present_state = Reset_state;
				mul3 : #40 Present_state = mul4;
				mul4 : #40 Present_state = mul5;
				mul5 : #40 Present_state = mul6;
				mul6 : #40 Present_state = Reset_state;
				div3 : #40 Present_state = div4;
				div4 : #40 Present_state = div5;
				div5 : #40 Present_state = div6;
				div6 : #40 Present_state = Reset_state;
				shr3 : #40 Present_state = shr4;
				shr4 : #40 Present_state = shr5;
				shr5 : #40 Present_state = Reset_state;
				shl3 : #40 Present_state = shl4;
				shl4 : #40 Present_state = shl5;
				shl5 : #40 Present_state = Reset_state;
				ror3 : #40 Present_state = ror4;
				ror4 : #40 Present_state = ror5;
				ror5 : #40 Present_state = Reset_state;
				rol3 : #40 Present_state = rol4;
				rol4 : #40 Present_state = rol5;
				rol5 : #40 Present_state = Reset_state;
				not3 : #40 Present_state = not4;
				not4 : #40 Present_state = Reset_state;
				neg3 : #40 Present_state = neg4;
				neg4 : #40 Present_state = Reset_state;
				ld3 : #40 Present_state = ld4;
				ld4 : #40 Present_state = ld5;
				ld5 : #40 Present_state = ld6;
				ld6 : #40 Present_state = ld7;
				ld7 : #40 Present_state = Reset_state;
				ldi3 : #40 Present_state = ldi4;
				ldi4 : #40 Present_state = ldi5;
				ldi5 : #40 Present_state = Reset_state;
				st3 : #40 Present_state = st4;
				st4 : #40 Present_state = st5;
				st5 : #40 Present_state = st6;
				st6 : #40 Present_state = st7;
				st7 : #40 Present_state = Reset_state;
				addi3 : #40 Present_state = addi4;
				addi4 : #40 Present_state = addi5;
				addi5 : #40 Present_state = Reset_state;
				andi3 : #40 Present_state = andi4;
				andi4 : #40 Present_state = andi5;
				andi5 : #40 Present_state = Reset_state;
				ori3 : #40 Present_state = ori4;
				ori4 : #40 Present_state = ori5;
				ori5 : #40 Present_state = Reset_state;
				br3 : #40 Present_state = br4;
				br4 : #40 Present_state = br5;
				br5 : #40 Present_state = br6;
				br6 : #40 Present_state = br7;
				br7 : #40 Present_state = Reset_state;
				jal3 : #40 Present_state = jal4;
				jal4 : #40 Present_state = Reset_state;
				and3 : #40 Present_state = and4;
				and4 : #40 Present_state = and5;
				and5 : #40 Present_state = Reset_state;
				or3 : #40 Present_state = or4;
				or4 : #40 Present_state = or5;
				or5 : #40 Present_state = Reset_state;
				mfhi3 : #40 Present_state = Reset_state;
				mflo3 : #40 Present_state = Reset_state;
				halt3 : #40 Present_state = Reset_state;
				in3 : #40 Present_state = Reset_state;
				out3 : #40 Present_state = Reset_state;
			endcase
			end
		end
	always @(Present_state) // do the job for each state
		begin
			case (Present_state) // assert the required signals in each state
				Reset_state: begin
					Gra <= 0; Grb <= 0; Grc <= 0; YIn <= 0;
					Gra <=0;Grb <=0; Grc <=0; RIn <=0; BAout <=0; Rout <=0;//initialize the signals
					MARIn <=0; PCIn <=0; MDRIn <=0;IRIn <=0; YIn <=0; IncPC <=0; 
					HiIn <=0; LoIn <=0; CIn <=0;InIn <=0; OutIn <=0; ZIn <=0; CONIn <=0;
					PCout <=0; Zlowout <=0; Zhighout <=0; MDRout <=0; Cout <=0;
					In_Portout <=0; LOout <=0; HIout <=0;
					Read <=0; Write <=0; Clear <=0;
					ADD <=0; AND <=0; SUB <=0; DIV <=0; SHR <=0; SHL <=0; 
					ROR <=0; ROL <=0; OR <=0; MUL <=0; NEG <=0; NOT <=0;
				end
				fetch0: begin
					PCout <= 1; // see if you need to de-assert these signals
					MARIn <= 1;
					ZIn <= 0;
				end
				fetch1: begin
					PCout <= 0; MARIn <=0; IncPC <=1;
					Zlowout <=1; PCIn <=1; 
					MDRIn <=1; Read <= 1; 
					//#20 
					//IncPC <=0;
				end
				fetch2a: begin
					Zlowout <=0; Read <=0; MDRIn<=0; PCIn <=0;
					MDRout <=1; IRIn <=1; IncPC <=0;
					
				end
				add3: begin
					MDRout <= 0; IRIn <=0;
					
					Grb <= 1; Rout <= 1;
					YIn <= 1;
				end
				add4: begin
					//is it uneccessary to deassert then reassert Rout
					Grb <=0; YIn <=0;
					Grc <= 1;  ZIn <=1; ADD <=1;
				end
				add5: begin
					Grc <=0; Rout <=0; ZIn<=0; ADD<=0;
					Gra <=1; RIn <=1; Zlowout <=1;
				end
				
				sub3: begin
					MDRout <=0; IRIn<=0;
					Grb<=1; Rout<=1; YIn<=1;
				end
				sub4: begin
					Grb<=0; YIn<=0;
					Grc<=1; ZIn<=1; SUB<=1;
				end
				sub5: begin
					Grc<=0; ZIn<=0; SUB<=0; Rout <=0;
					Gra <=1; RIn <=1; Zlowout <=1;
				end
				
				mul3: begin
					MDRout <=0; IRIn<=0;
					Grb<=1; YIn<=1; Rout <=1;
				end
				mul4: begin
					Grb<=0; YIn<=0;
					Grc<=1; MUL<=1; ZIn<=1;
				end
				mul5: begin
					Grc<=0; MUL<=0; ZIn<=0; Rout <=0;
					Zlowout<=1; LoIn<=1;
				end
				mul6: begin
					Zlowout<=1; LoIn<=0;
					Zhighout<=1; HiIn<=1;
				end
				
				div3: begin
					MDRout <=0; IRIn<=0;
					Grb<=1; YIn<=1; Rout <=1;
				end
				div4: begin
					Grb<=0; YIn<=0;
					Grc<=1; DIV<=1; ZIn<=1;
				end
				div5: begin
					Grc<=0; DIV<=0; ZIn<=0; Rout <=0;
					Zlowout<=1; LoIn<=1;
				end
				div6: begin
					Zlowout<=1; LoIn<=0;
					Zhighout<=1; HiIn<=1;
				end
				
				shr3: begin
					MDRout <=0; IRIn<=0;
					Grb<=1;  YIn<=1; Rout <=1;
				end
				shr4: begin
					Grb<=0; YIn<=0; Rout<=0;
					SHR<=1; ZIn<=1;
				end
				shr5: begin
					SHR<=0; ZIn<=0;
					Zlowout<=1; Gra<=1; RIn<=1;
				end
				
				shl3: begin
					MDRout <=0; IRIn<=0;
					Grb<=1;  YIn<=1; Rout <=1;
				end
				shl4: begin
					Grb<=0; YIn<=0; Rout<=0;
					SHL<=1; ZIn<=1;
				end
				shl5: begin
					SHL<=0; ZIn<=0;
					Zlowout<=1; Gra<=1; RIn<=1;
				end
				
				ror3: begin
					MDRout <=0; IRIn<=0;
					Grb<=1; Rout<=1; YIn<=1;
				end
				ror4: begin
					Grb<=0; YIn<=0; Rout<=0;
					ROR<=1; ZIn<=1;
				end
				ror5: begin
					ROR<=0; ZIn<=0;
					Zlowout<=1; Gra<=1; RIn<=1;
				end
				
				rol3: begin
					MDRout <=0; IRIn<=0;
					Grb<=1; Rout<=1; YIn<=1;
				end
				rol4: begin
					Grb<=0; YIn<=0; Rout<=0;
					ROL<=1; ZIn<=1;
				end
				rol5: begin
					ROL<=0; ZIn<=0;
					Zlowout<=1; Gra<=1; RIn<=1;
				end
				
				neg3: begin
					MDRout <=0; IRIn<=0;
					Grb<=1; NEG<=1; ZIn<=1;
				end
				neg4: begin
					Grb<=0; NEG<=0; ZIn<=0;
					Zlowout<=1; Gra<=1; RIn<=1; 
				end
				
				not3: begin
					MDRout <=0; IRIn<=0;
					Grb<=1; NEG<=1; ZIn<=1;
				end
				not4: begin
					Grb<=0; NEG<=0; ZIn<=0;
					Zlowout<=1; Gra<=1; RIn<=1; 
				end
				
				ld3: begin
					MDRout <=0; IRIn<=0;
					Grb <=1; BAout <=1; YIn <=1;
				end
				ld4: begin
					Grb <=0; BAout <=0; YIn <=0;
					ADD<=1; Cout <=1; ZIn<=1;
				end
				ld5: begin
					ADD <=0; Cout <=0; ZIn <=0;
					Zlowout <=1; MARIn <=1;
				end
				ld6: begin
					Zlowout <=0; MARIn <=0;
					Read <=1; MDRIn<=1;
				end
				ld7: begin
					Read <=0; MDRIn <=0;
					MDRout <=1; Gra <=1; RIn <=1;
				end
				
				ldi3: begin
					MDRout <=0; IRIn<=0;
					Grb <=1; BAout <= 1; YIn <=1;
				end
				ldi4: begin
					Grb <=0; BAout <= 0; YIn <=0;
					ADD <=1; Cout<=1; ZIn<=1;
				end
				ldi5: begin
					ADD <=0; Cout<=0; ZIn<=0;
					Zlowout<=1; Gra<=1; RIn<=1;
				end
				
				st3: begin
					MDRout <=0; IRIn<=0;
					Grb <=1; BAout <=1; YIn<=1;
				end
				st4: begin
					Grb <=0; BAout <=0; YIn<=0;
					ADD<=1; Cout<=1; ZIn<=1;
				end
				st5: begin
					ADD<=0; Cout<=0; ZIn<=0;
					Zlowout<=1; MARIn<=1;
				end
				st6: begin
					Zlowout<=0; MARIn<=0;
					Gra<=1; Rout <=1; MDRIn<=1;
				end
				st7: begin
					Gra<=0; Rout <=0; MDRIn<=0;
					MDRout <=1; Write <=1;
				end
				
				addi3: begin
					MDRout <=0; IRIn<=0;
					Grb<=1; Rout<=1; YIn<=1;
				end
				addi4: begin
					Grb<=0; Rout<=0; YIn<=0;
					ADD<=1; Cout<=1; ZIn<=1;
				end
				addi5: begin
					ADD<=0; Cout<=0; ZIn<=0;
					Zlowout <=1; Gra<=1; RIn<=1;
				end
				
				andi3: begin
					MDRout <=0; IRIn<=0;
					Grb<=1; Rout<=1; YIn<=1;
				end
				andi4: begin
					Grb<=0; Rout<=0; YIn<=0;
					AND <=1; Cout<=1; ZIn<=1;
				end
				andi5: begin
					AND <=0; Cout<=0; ZIn<=0;
					Zlowout<=1; Gra<=1; RIn<=1;
				end
				
				ori3: begin
					MDRout <=0; IRIn<=0;
					Grb<=1; Rout<=1; YIn<=1;
				end
				ori4: begin
					Grb<=0; Rout<=0; YIn<=0;
					OR<=1; Cout <=1; ZIn<=1;
				end
				ori5: begin
					OR<=0; Cout <=0; ZIn<=0;
					Zlowout<=1; Gra<=1; RIn<=1;
				end
				
				br3: begin
					MDRout <=0; IRIn<=0;
					Gra<=1;  Rout <=1; CONIn <=1;
				end
				br4: begin
					Gra<=0;  Rout <=0; CONIn <=0;
					PCout <=1; YIn<=1;
				end
				br5: begin
					PCout <=0; YIn<=0;
					Cout <=1; ZIn<=1; ADD<=1;
				end
				br6: begin
					Cout <=0; ZIn<=0; ADD<=0;
					Zlowout <=1; PCIn<=1;
				end
				br7: begin
					Zlowout <=0; PCIn<=0;
					PCout<=1;
				end
				
				jr3: begin
					MDRout <=0; IRIn<=0;
					Gra <=1; Rout <=1; PCIn<=1;
				end
				
				jal3: begin
					MDRout <=0; IRIn<=0;
					PCout <=1; RIn<= 1;
				end
				jal4: begin
					PCout <=0; RIn<= 0;
					Gra <=1; Rout<= 1; PCIn <=1;
				end
				
				mfhi3: begin
					MDRout <=0; IRIn<=0;
					Gra <=1; RIn<= 1; Zhighout <=1;
				end
				
				mflo3: begin
					MDRout <=0; IRIn<=0;
					Gra <=1; RIn<= 1; Zlowout<=1;
				end
				
				in3: begin
					MDRout <=0; IRIn<=0;
				end
				
				out3: begin
					MDRout <=0; IRIn<=0;
				end
				
				and3: begin
					MDRout <=0; IRIn<=0;
					Grb<=1; YIn<=1; Rout <=1;
				end
				and4: begin
					Grb<=0; YIn<=0;
					Gra<=1;AND<=1; ZIn<=1;
				end
				and5: begin
					Gra<=0;AND<=0; ZIn<=0; Rout<=0;
					Zlowout<=1; Grc<=1; RIn<=1;
				end
				
				or3: begin
					MDRout <=0; IRIn<=0;
					Grb<=1; YIn<=1; Rout <=1;
				end
				or4: begin
					Grb<=0; YIn<=0;
					Gra<=1;OR<=1; ZIn<=1;
				end
				or5: begin
					Gra<=0;OR<=0; ZIn<=0; Rout<=0;
					Zlowout<=1; Grc<=1; RIn<=1;
				end
			endcase
		end
endmodule
