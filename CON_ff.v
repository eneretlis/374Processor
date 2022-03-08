module CON_FF(input CONin,
					input [31:0] BusMuxOut,
					input [1:0] IrBits
					output CONout);
	wire [3:0] decoderOut;
	decoder_2_to_4 dec2(IrBits,decoderOut);
	
	wire equal, notequal, greaterThan, lesThan, busOr, flipFlopIn;
	if(BusMuxOut)
		assign busOr = 1'b1;
	else
		assign busOr = 1'b0;
	
	assign equal = decoderOut[0] & busOr;
	assign notequal = decoder[1] & !busOr;
	assign greaterThan = (!BusMuxOut[31] & decoderOut[2]);
	assign lessThan = (BusMuxOut[31] & decoderOut[3]);
	
	assign flipFlopIn = (equal | notequal | greaterThan | lessThan);
	
	c_flipflip cff(flipFlopIn, CONin, CONout);
endmodule
	