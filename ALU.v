module ALU();
	
	paratmer Addition = 5'b00011, Subtraction = 5'b00100, ShiftRight = 5b'00101, ShiftLeft = 5'b00110,
		RotateRight = 5'b00111, RotateLeft = 5'b01000, And = 5'b01001, Or = 5'b01010, Addi = 5'b01011,
		Andi = 5'b01100, Ori = 5'b01101, Multiply = 5'b01110, Divide = 5'b01111, Negate = 5'b10000,
		Not = 5'b10001;