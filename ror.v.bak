module ror (
	input [31:0] Rb, Rc,
	output [31:0] Ra
	);
	reg [31:0] temp_reg;
	count = 0;
	temp_reg = Rc;
	while(temp_reg)
	begin	
		if(temp_reg[0]) count = count +1;
			temp_reg = temp_reg >>1;
		end
	end
	case(count)
		1 : Ra <= {Rb[0],Rb[31:1]};
		2 : Ra <= {Rb[1:0],Rb[31:2]};
		3 : Ra <= {Rb[2:0],Rb[31:3]};
		4 : Ra <= {Rb[3:0],Rb[31:4]};
		5 : Ra <= {Rb[4:0],Rb[31:5]};
		6 : Ra <= {Rb[5:0],Rb[31:6]};
		7 : Ra <= {Rb[6:0],Rb[31:7]};
		8 : Ra <= {Rb[7:0],Rb[31:8]};
		9 : Ra <= {Rb[8:0],Rb[31:9]};
		10 : Ra <= {Rb[9:0],Rb[31:10]};
		11 : Ra <= {Rb[10:0],Rb[31:11]};
		12 : Ra <= {Rb[11:0],Rb[31:12]};
		13 : Ra <= {Rb[12:0],Rb[31:13]};
		14 : Ra <= {Rb[13:0],Rb[31:14]};
		15 : Ra <= {Rb[14:0],Rb[31:15]};
		16 : Ra <= {Rb[15:0],Rb[31:16]};
		17 : Ra <= {Rb[16:0],Rb[31:17]};
		18 : Ra <= {Rb[17:0],Rb[31:18]};
		19 : Ra <= {Rb[18:0],Rb[31:19]};
		20 : Ra <= {Rb[19:0],Rb[31:20]};
		21 : Ra <= {Rb[20:0],Rb[31:21]};
		22 : Ra <= {Rb[21:0],Rb[31:22]};
		23 : Ra <= {Rb[22:0],Rb[31:23]};
		24 : Ra <= {Rb[23:0],Rb[31:24]};
		25 : Ra <= {Rb[24:0],Rb[31:25]};
		26 : Ra <= {Rb[25:0],Rb[31:26]};
		27 : Ra <= {Rb[26:0],Rb[31:27]};
		28 : Ra <= {Rb[27:0],Rb[31:28]};
		29 : Ra <= {Rb[28:0],Rb[31:29]};
		30 : Ra <= {Rb[29:0],Rb[31:30]};
		31 : Ra <= {Rb[30:0],Rb[31]};
		default: Ra<= Rb;
		endcase
endmodule