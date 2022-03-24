`timescale 1ns/10ps
module control_unit (
	output reg Gra, Grb, Grc, Rin, BAout, Rout, // here, you will define the inputs and outputs to your Control Unit
					MARIn, PCIn, MDRIn, IRIn, YIn, IncPC, HiIn, LoIn, CIn,InIn, OutIn, ZIn, CONIn,
					PCout, Zlowout, Zhighout, MDRout, Cout, In_Portout, LOout, HIout,
					Read, Write, Clear,
					ADD, AND, SUB, DIV, SHR, SHL, ROR, ROL, OR, MUL, NEG, NOT,
	input [31:0] IR,
	input Clock, Reset, Stop, Con_FF);
	parameter Reset_state = 8'b0000, fetch0 = 8'b0001, fetch1 = 8'b0010, fetch2 = 8'b0011,
				add3 = 8'b0100, add4 = 8'b0101, add5 = 8'b0110,
				sub3 = 8'b0111, sub4 = 8'b01000, sub5 = 8'b01001,
				mul3 = 8'b01010, mul4 = 8'b01011, mul5 = 8'b01100, mul6 = 8'b01101,
				div3 = 8'b01110, div4 = 8'b01111, div5 = 8'b010000, div6 = 8'b010001,
				shr3 = 8'b010010, shr4 = 8'b010011, shr5 = 8'010100,
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
				in3 = 8'b01000010, out3 = 8'b01000011;
	reg [3:0] Present_state = Reset_state; // adjust the bit pattern based on the number of states
	always @(posedge Clock, posedge Reset) // finite state machine; if clock or reset rising-edge
		begin
			if (Reset == 1’b1) Present_state = Reset_state;
			else case (Present_state)
				Reset_state : Present_state = fetch0;
				fetch0 : Present_state = fetch1;
				fetch1 : Present_state = fetch2;
				fetch2 : begin
								case (IR[31:27]) // inst. decoding based on the opcode to set the next state
									5'b00011 : Present_state = add3; // this is the add instruction
									5'b00100 : Present_state = sub3;
									5'b00101 : Present_state = shr3;
									5'b00110 : Present_state = shl3;
									5'b00111 : Present_state = ror3;
									5'b01000 : Present_state = rol3;
									5'b01001 : Present_state = and3;
									5'b01010 : Present_state = or3;
								endcase
							end
				add3 : Present_state = add4;
				add4 : Present_state = add5;
				sub3 : Present_state = sub4;
				sub4 : Present_state = sub5;
				mul3 : Present_state = mul4;
				mul4 : Present_state = mul5;
				mul5 : Present_state = mul6;
				div3 : Present_state = div4;
				div4 : Present_state = div5;
				div5 : Present_state = div6;
				shr3 : Present_state = shr4;
				shr4 : Present_state = shr5;
				shl3 : Present_state = shl4;
				shl4 : Present_state = shl5;
				ror3 : Present_state = ror4;
				ror4 : Present_state = ror5;
				rol3 : Present_state = rol4;
				rol4 : Present_state = rol5;
				not3 : Present_state = not4;
				neg3 : Present_state = neg4;
				ld3 : Present_state = ld4;
				ld4 : Present_state = ld5;
				ld5 : Present_state = ld6;
				ld6 : Present_state = ld7;
				ldi3 : Present_state = ldi4;
				ldi4 : Present_state = ldi5;
				st3 : Present_state = st4;
				st4 : Present_state = st5;
				st5 : Present_state = st6;
				st6 : Present_state = st7;
			endcase
		end
	always @(Present_state) // do the job for each state
		begin
			case (Present_state) // assert the required signals in each state
				Reset_state: begin
					Gra <= 0; Grb <= 0; Grc <= 0; Yin <= 0; // initialize the signals
					⁞
				end
				fetch0: begin
					PCout <= 1; // see if you need to de-assert these signals
					MARin <= 1;
					IncPC <= 1;
					Zin <= 0;
				end
				add3: begin
					Grb <= 1; Rout <= 1;
					Yin <= 0;
				end
				⁞
			endcase
		end
endmodule
