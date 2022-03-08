`timescale 1ns/10ps
module RAM (input clk, w, r,
				input [31:0] data_in,
				input [8:0] addr,
				output [31:0] data_out);
	reg [31:0] ram [511:0];
	always @(posedge clk)
	begin
		if(w)
		ram[addr] <= data_in;
	end
	assign data_out = r?ram[addr]:32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
end module
	