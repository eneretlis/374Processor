`timescale 1ns/10ps
module and_tb;
	reg PCout, Zlowout, MDRout, R2out, R4out;
	reg MARIn, ZIn, PCIn, MDRIn, IRIn, YIn;
	reg IncPC, read, AND, R5In, R2In, R4In;
	reg clk;
	reg [31:0] Mdatain;
	
	parameter Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011, Reg_load2b = 4'b0100,
				Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111, T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010,
				T4 = 4'b1011, T5 = 4'b1100;
	reg [3:0] Present_state = Default;
	
	DataPath DUT(PCout, Zlowout, MDRout, R2out, R4out, MARIn, ZIn, PCIn, MDRIn, IRIn, YIn, IncPC, read, AND, R5In, R4In, clk, Mdatain);
	
	initial
		begin
			clk = 0;
			forever#10 clk=~clk;
	end
	
	always@(posedge clk)
		begin
			case(Present_state)
				Default : Present_state = Reg_load1a;
				Reg_load1a : Present_state = Reg_load1b;
				Reg_load1b : Present_state = Reg_load2a;
				Reg_load2a : Present_state = Reg_load2b;
				Reg_load2b : Present_state = Reg_load3a;
				Reg_load3a : Present_state = Reg_load3b;
				Reg_load3b : Present_state = T0;
				T0 : Present_state = T1;
				T1 : Present_state = T2;
				T2 : Present_state = T3;
				T3 : Present_state = T4;
				
			endcase
		end
	always @(Present_state)
		begin
			case(Present_state)
				Default: begin	
					PCout <=0; Zlowout <=0; MDRout <=0; R2out<=0; R4out<=0;
					MARIn<=0; ZIn<=0; PCIn<=0; MDRIn <= 0; IRIn <= 0; YIn <= 0;
					IncPC <=0; read <=0; AND <=0; R5In <=0; R2In<=0; R4In<=0; Mdatain<=32'h00000000;
				end
				Reg_load1a: begin
					Mdatain = 32'h00000022;
					read = 0; MDRIn = 0;
					#10 read <=1; MDRIn <= 0;
					#15 read <=0; MDRIn <= 0;
				end
				Reg_load1b : begin
					#10 MDRout <=1; R2In <=1;
					#15 MDRout <=0; R2In <= 0;
				end
				Reg_load2a : begin
					Mdatain = 32'h00000044;
					#10 read <= 1; MDRIn <= 1;
					#15 read<= 0; MDRIn <= 0;
				end
				Reg_load2b : begin
					#10 MDRout <=1; R4In <= 1;
					#15 MDRout<=0; R4In <=0;
				end
				Reg_load3a : begin
					Mdatain = 32'h00000026;
					#10 read <= 1; MDRIn <= 1;
					#15 read<= 0; MDRIn <= 0;
				end
				Reg_load3b : begin
					#10 MDRout <=1; R5In <= 1;
					#15 MDRout<=0; R5In <=0;
				end
				T0: begin
					PCout <= 1; MARIn <=1; IncPC<=1; ZIn<=1;
				end
				T1: begin
					Zlowout <=1; PCIn <=1; read <=1; MDRIn <=1;
					Mdatain <= 32'h4A920000;
				end
				T2: begin
					MDRout <=1; IRIn<=1;
				end
				T3: begin
					R2out <=1; YIn <=1;
				end
				T4: begin
					R4out <=1; AND <=1; ZIn<=1;
				end
				T5 : begin
					Zlowout <=1; R5In <=1;
				end
			endcase
		end
	endmodule
				
				
				
				
				
				
				
				
				
				
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
