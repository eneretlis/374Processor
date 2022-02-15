module ALU(
	input [4:0] opcode,
	input [31:0] Ra, Rb,
	output reg [31:0] ZHI, ZLO
	);
	
	parameter Addition = 5'b00011, Subtraction = 5'b00100, ShiftRight = 5'b00101, ShiftLeft = 5'b00110,
		RotateRight = 5'b00111, RotateLeft = 5'b01000, And = 5'b01001, Or = 5'b01010, Multiply = 5'b01110, 
		Divide = 5'b01111, Negate = 5'b10000, Not = 5'b10001;
		
	wire [31:0] resultRor, resultRol, resultAdd, multLO;
	wire[63:32] multHI;
	ror rightRotate(Ra,Rb,resultRor);
	rol leftRotate(Ra,Rb,resultRol);
	add_rca_32 Adding(resultAdd, Ra, Rb);
	multiply_booth Multiplying(Ra,Rb,multHI,multLO);
	
	always@(*)
		begin
			case(opcode)
				Addition : begin
					ZLO = resultAdd;
					ZHI = 32'h00000000;
				end
				Subtraction : begin
					ZLO = Ra - Rb;
					ZHI = 32'b000;
				end
				ShiftRight : begin
					ZHI = Ra >> Rb;
					ZHI = 32'b00;
				end
				ShiftLeft : begin
					ZLO = Ra << Rb;
					ZHI = 32'b00;
				end
				RotateRight : begin
					ZLO = resultRor;
					ZHI = 32'b00;
				end
				RotateLeft : begin
					ZLO = resultRol;
					ZHI = 32'b00;
				end
				And : begin
					ZLO = Ra & Rb;
					ZHI = 32'b00;
				end
				Or : begin
					ZLO = Ra | Rb;
					ZHI = 32'b00;
				end
				Multiply : begin
					ZLO = multLO;
					ZHI = multHI;
				end
				Divide : begin
					ZHI <= Ra% Rb;
					ZLO <= (Ra-ZHI)/Rb;
				end
				Negate : begin
					ZLO = ~Rb +1;
					ZHI = 32'b00;
				end
				Not : begin
					ZLO = ~Rb;
					ZHI = 32'b00;
				end
			endcase
		end
endmodule
