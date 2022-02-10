module rol (
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
		1 : Ra <= {Rb[30:0], Rb[31]};
		2 : Ra <= {Rb[29:0], Rb[31:30]};
		3 : Ra <= {Rb[28:0], Rb[31:29]};
		4 : Ra <= {Rb[27:0], Rb[31:28]};
		5 : Ra <= {Rb[26:0], Rb[31:27]};
		6 : Ra <= {Rb[25:0], Rb[31:26]};
		7 : Ra <= {Rb[24:0], Rb[31:25]};
		8 : Ra <= {Rb[23:0], Rb[31:24]};
		9 : Ra <= {Rb[22:0], Rb[31:23]};
		10 : Ra <= {Rb[21:0], Rb[31:22]};
		11 : Ra <= {Rb[20:0], Rb[31:21]};
		12 : Ra <= {Rb[19:0], Rb[31:20]};
		13 : Ra <= {Rb[18:0], Rb[31:19]};
		14 : Ra <= {Rb[17:0], Rb[31:18]};
		15 : Ra <= {Rb[16:0], Rb[31:17]};
		16 : Ra <= {Rb[15:0], Rb[31:16]};
		17 : Ra <= {Rb[14:0], Rb[31:15]};
		18 : Ra <= {Rb[13:0], Rb[31:14]};
		19 : Ra <= {Rb[12:0],Rb[31:13]};
		20 : Ra <= {Rb[11:0],Rb[31:12]};
		21 : Ra <= {Rb[10:0],Rb[31:11]};
		22 : Ra <= {Rb[9:0],Rb[31:10]};
		23 : Ra <= {Rb[8:0],Rb[31:9]};
		24 : Ra <= {Rb[7:0],Rb[31:8]};
		25 : Ra <= {Rb[6:0],Rb[31:7]};
		26 : Ra <= {Rb[5:0],Rb[31:6]};
		27 : Ra <= {Rb[4:0],Rb[31:5]};
		28 : Ra <= {Rb[3:0],Rb[31:4]};
		29 : Ra <= {Rb[2:0],Rb[31:3]};
		30 : Ra <= {Rb[1:0],Rb[31:2]};
		31 : Ra <= {Rb[0],Rb[31:1]};
		default: Ra<= Rb;
		endcase
endmodule