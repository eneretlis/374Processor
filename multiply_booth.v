module multiply_booth(
	input [31:0] Ra, Rb,
	output reg [31:0] HI, LO
	);
	//create wires and registers to be used in algorithm
	wire [31:0] invert_Ra;
	reg [2:0] booth_value[15:0];
	reg[32:0] partial_product [15:0];
	reg[63:0] sum_partial_product [15:0];
	reg[63:0] product;
	integer i, j;
	
	//generate twos compliment of multiplicand
	assign invert_Ra = ~Ra;
	always@(Ra or Rb or invert_Ra)
		begin
	//set booth_value
			booth_value[0] = {Rb[1],Rb[0],1'b0};
			for(i =1;i<16;i = i+1)
			begin
				booth_value[i] = {Rb[2*i+1],Rb[2*i],Rb[2*i+1]};
			end
			
			for(i = 0; i<16; i = i+1)
			begin
				case(booth_value[i])
					3'b001, 3'b010 : partial_product[i] = {Ra[32-1],Ra};
					3'b011 : partial_product[i] = {Rb,1'b0};
					3'b100 : partial_product[i] = {invert_Ra[31:0],1'b0};
					3'b101, 3'b110 : partial_product[i] = invert_Ra;
					default : partial_product[i] = 0;
				endcase
			sum_partial_product[i] = $signed(partial_product[i]);
			for(j=0;j<i;j = j+1)
			begin
				sum_partial_product[i] = {sum_partial_product[i],2'b00};
				end
			end
			
			product = sum_partial_product[0];
			for(i =1;i<16;i = i+1)
			begin
				product = product + sum_partial_product[i];
			end
			
			
			HI = product[63:32];
			LO = product[31:0];
		end
endmodule
		
	