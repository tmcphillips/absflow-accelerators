
module constant_multiplier #(parameter IN_WIDTH=8, parameter OUT_WIDTH=11, parameter MULTIPLIER=2) (
	input		logic	[IN_WIDTH-1:0]		multiplicand,
   output	logic	[OUT_WIDTH-1:0]	product
);

	always_comb
		case(MULTIPLIER)
			2: 	product 	= multiplicand << 1;
			3: 	product 	= (multiplicand << 1) + multiplicand;
			5: 	product 	= (multiplicand << 2) + multiplicand;
		endcase
		
endmodule
