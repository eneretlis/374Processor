module ALU(
	input add, subtract, multiplySignal, divideSignal, andSignal, orSignal, shrSignal, ShlSignal,
	input RorSignal, RolSignal, NegSignal, NotSignal, 
	input [31:0] Ra, Rb,
	output reg [31:0] ZHI, ZLO
	);
	
	parameter Addition = 12'b0001, Subtraction = 12'b0010, ShiftRight = 12'b00100, ShiftLeft = 12'b001000,
		RotateRight = 12'b0010000, RotateLeft = 12'b0100000, And = 12'b01000000, Or = 12'b010000000,
		Multiply = 12'b000100000000, Divide = 12'b01000000000, Negate = 12'b010000000000, Not = 12'b100000000000;
		
	wire [31:0] resultRor, resultRol, resultAdd, multLO;
	wire[63:32] multHI;
	
	ror rightRotate(Ra,Rb,resultRor);
	rol leftRotate(Ra,Rb,resultRol);
	add_rca_32 Adding(resultAdd, Ra, Rb);
	multiply_booth Multiplying(Ra,Rb,multHI,multLO);
	wire [11:0] ALU_control;
	assign ALU_control = {NotSignal, NegSignal, divideSignal, multiplySignal, orSignal, andSignal
									rolSignal, rorSignal, shlSignal, shrSignal, subtract, add};
	always@(*)
		begin
			case(ALU_control)
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
