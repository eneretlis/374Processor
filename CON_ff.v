module CON_FF(input CONin,
					input signed [31:0] BusMuxOut,
					input [1:0] IrBits,
					output CONout);
	wire [3:0] decoderOut;
	decoder_2_to_4 dec2(IrBits,decoderOut);
	
	wire equal, notequal, greaterThan, lessThan, busOr, flipFlopIn;
	assign busOr = (BusMuxOut == 32'd0) ? 1'b1 :1'b0;
	
	assign equal = decoderOut[0] & busOr;
	assign notequal = decoderOut[1] & !busOr;
	assign greaterThan = (!BusMuxOut[31] & decoderOut[2]);
	assign lessThan = (BusMuxOut[31] & decoderOut[3]);
	
	assign flipFlopIn = (equal | notequal | greaterThan | lessThan);
	
	c_flipflop cff(flipFlopIn, CONin, CONout);
endmodule
	