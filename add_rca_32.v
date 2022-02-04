module add_rca_32 (output c_out, output [31:0] sum, input [31:0] a,b, input c_in);
	wire c_in4, c_in8, c_in12, c_in16, c_in20, c_in24, c_in28, c_out;
	add_rca_4 M1 (c_in4, sum[3:0], a[3:0], b[3:0], c_in);
	add_rca_4 M2 (c_in8, sum[7:4], a[7:4], b[7:4], c_in4);
	add_rca_4 M3 (c_in12, sum[11:8], a[11:8], b[11:8], c_in8);
	add_rca_4 M4 (c_in16, sum[15:12], a[15:12], b[15:12], c_in12);
	add_rca_4 M5 (c_in20, sum[19:16], a[19:16], b[19:16], c_in16);
	add_rca_4 M6 (c_in24, sum[23:20], a[23:20], b[23:20], c_in20);
	add_rca_4 M7 (c_in28, sum[27:24], a[27:24], b[27:24], c_in24);
	add_rca_4 M8 (c_out, sum[31:28], a[31:28], b[31:28], c_in28);
end module

module add_rca_4 (output c_out, output [3:0] sum, input [3:0] a,b, input c_in);
	wire c_in2, c_in3, c_in4;
	add_full M1 (c_in2, sum[0], a[0],b[0],c_in);
	add_full M2 (c_in3, sum[1], a[1],b[1],c_in2);
	add_full M3 (c_in4, sum[2], a[2],b[2],c_in3);
	add_full M4 (c_out, sum[3], a[3],b[3],c_in4);
end module

module add_full(output c_out, sum, input a,b,c_in);
	wire w1,w2,w3;
	add_half M1 (w2,w1,a,b);
	add_half M2 (w3,sum,c_in,w1);
	or M3 (c_out,w2,w3);
end module

module add_half(output c_out,sum,input a, b);
	xor M1 (sum,a,b);
	and M2 (c_out,a,b);
endmodule
