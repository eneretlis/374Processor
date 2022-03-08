module SelectandEncode(input [31:0] instruction,
								input Gra,Grb,Grc,Rin,Rout,BAout,
								output [15:0] Regout, RegIn,
								output [31:0] C_sign_extended);
	wire [3:0] decoder_input;
	wire [15:0] decoder_output;
	//maybe 4*Gr
	always @(instruction)
	begin
		decoder_input = ((instruction[26:23] & {4{Gra}}) | (instruction[22:19] & {4{Grb}}) | (instruction[18:15] & {4{Grc}}));
		decoder_4_to_16 dec4(decoder_input, decoder_output);
		
		RegIn = decoder_output & {16{Rin}};
		Regout = ({16{BAout}} | {16{Rout}}) & decoder_output;
		
		C_sign_extended = {{13{instruction[18]}},instruction[18:0]};
	end
endmodule
	