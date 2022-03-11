module SelectandEncode(input [31:0] instruction,
								input Gra,Grb,Grc,Rin,Rout,BAout,
								output [15:0] Regout, RegIn,
								output [4:0] opcode,
								output [31:0] C_sign_extended);
	wire [3:0] decoder_input;
	wire [15:0] decoder_output;
	assign decoder_input = ((instruction[26:23] & {4{Gra}}) | (instruction[22:19] & {4{Grb}}) | (instruction[18:15] & {4{Grc}}));
	decoder_4_to_16 decoded(decoder_input, decoder_output);
		
	assign RegIn = decoder_output & {16{Rin}};
	assign Regout = ({16{BAout}} | {16{Rout}}) & decoder_output;
		
	assign C_sign_extended = {{13{instruction[18]}},instruction[18:0]};
	assign opcode = instruction[31:27];
endmodule
	