`ifndef RIPPLE_COUNTER
`define RIPPLE_COUNTER

`include "tflipflop.v"

module RippleCounter #(parameter SIZE=8)(
	input wire up,
	output wire [SIZE-1:0] value
);

	TFlipFlop u0tff (
		.clk(up),
		.t(1'b1),
		.q(value[0])
	);
	
	genvar i;
	generate
		for(i = 0; i < SIZE - 1; i = i + 1)
		
			TFlipFlop uitff (
				.clk(value[i]),
				.t(1'b1),
				.q(value[i+1])
			);

	endgenerate

endmodule

`endif