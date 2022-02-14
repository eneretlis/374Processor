module ALU(
	input [4:0] opcode,
	input [31:0] Ra, Rb,
	output reg [31:0] ZHI, ZLO
	);
	
	parameter Addition = 5'b00011, Subtraction = 5'b00100, ShiftRight = 5'b00101, ShiftLeft = 5'b00110,
		RotateRight = 5'b00111, RotateLeft = 5'b01000, And = 5'b01001, Or = 5'b01010, Multiply = 5'b01110, 
		Divide = 5'b01111, Negate = 5'b10000, Not = 5'b10001;
	always@(opcode)
		begin
			case(opcode)
				Addition: 
								begin
									Adding add_rca_32(ZLO,Ra,Rb);
									assign ZHI = 32'b0;
								end
				Subtraction : 
								begin
									Subbing subtract32(Ra,Rb,ZLO);
									assign ZHI = 32'b0;
								end
				ShiftRight : 
								begin
									Shr shift_right(Ra,Rb,ZLO);
									assign ZHI = 32'b0;
								end
				ShiftLeft : 
								begin
									Shl shift_left(Ra,Rb,ZLO);
									assign ZHI = 32'b0;
								end
				RotateRight :
								begin
									rightrotate ror(Ra,Rb,ZLO);
									assign ZHI = 32'b0;
								end
				RotateLeft : 
								begin
									leftrotate rol(Ra,Rb,ZLO);
									ZHI <= 32'b0;
								end
				And : 
								begin
									anding and_32bit(Ra,Rb,ZLO);
									ZHI = 32'b0;
								end
				Or : 
								begin
									or_32bit(Ra,Rb,ZLO);
									oring ZHI = 32'b0;
								end
				Multiply: 
								begin
									multiplying multiply_booth(Ra,Rb,ZHI,ZLO);
								end
				Divide: 
								begin
									dividing divide_32(Ra,Rb,ZHI,ZLO);
								end
				Negate: 
								begin
									negating negate_32(Ra,ZLO);
									ZHI = 32'b0;
								end
				Not: 
								begin
									notting not_32(Ra,ZLO);
									ZHI = 32'b0;
								end
		endcase
	end
endmodule