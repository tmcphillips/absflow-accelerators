`ifndef RIPPLE_COUNTER
`define RIPPLE_COUNTER

`include "tflipflop.v"

module ripplecounter #(parameter SIZE=8)(
	input wire up,
	input wire reset,
	output wire [SIZE-1:0] value
);

	tflipflop u0tff (
		.clk(up),
		.t(1'b1),
		.ar(reset),
		.q(value[0]),
		.nq()
	);
	
	genvar i;
	generate
		for(i = 0; i < SIZE - 1; i = i + 1)
			begin: sizeMinusOneFlipFlops
				tflipflop uitff (
					.clk(value[i]),
					.t(1'b1),
					.ar(reset),
					.q(value[i+1]),
					.nq()
				);
			end
	endgenerate

endmodule

`endif