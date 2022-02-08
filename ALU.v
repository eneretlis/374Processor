module ALU(
	input [4:0] opcode
	input [31:0] Ra, Rb,
	output [31:0] ZHI, ZLO
	);
	
	parameter Addition = 5'b00011, Subtraction = 5'b00100, ShiftRight = 5b'00101, ShiftLeft = 5'b00110,
		RotateRight = 5'b00111, RotateLeft = 5'b01000, And = 5'b01001, Or = 5'b01010, Addi = 5'b01011,
		Andi = 5'b01100, Ori = 5'b01101, Multiply = 5'b01110, Divide = 5'b01111, Negate = 5'b10000,
		Not = 5'b10001;
	always@(opcode)
	begin
		case(opcode)
			Addition: begin
								add_RCA_32(ZLO,Ra,Rb);
								ZHI = 32'b00;
								end
			Subtraction : begin
								subtract32(Ra,Rb,ZLO);
								ZHI = 32'b00;
								end
			ShiftRight : begin
								shift_right(Ra,Rb,ZLO);
								ZHI = 32'b00;
								end
			ShiftLeft
	