module ALU(
	input add, subtract, multiply, divide, andSignal, orSignal,
	input [31:0] Ra, Rb,
	output reg [31:0] ZHI, ZLO
	);
	
	parameter Addition = 7'b01000, Subtraction = 7'b00100, ShiftRight = 7'b00101, ShiftLeft = 7'b00110,
		RotateRight = 7'b00111, RotateLeft = 7'b01000, And = 7'b010000, Or = 7'b0100000, Multiply = 7'b00010, 
		Divide = 7'b00001, Negate = 7'b10000, Not = 7'b10001;
		
	wire [31:0] resultRor, resultRol, resultAdd, multLO;
	wire[63:32] multHI;
	
	ror rightRotate(Ra,Rb,resultRor);
	rol leftRotate(Ra,Rb,resultRol);
	add_rca_32 Adding(resultAdd, Ra, Rb);
	multiply_booth Multiplying(Ra,Rb,multHI,multLO);
	wire [6:0] ALU_control;
	assign ALU_control = {orSignal,andSignal, add, subtract, multiply, divide};
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
