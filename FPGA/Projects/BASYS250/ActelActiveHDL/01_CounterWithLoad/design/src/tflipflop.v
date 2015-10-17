`ifndef T_FLIP_FLOP
`define T_FLIP_FLOP

module TFlipFlop(
	input wire clk,
	input wire t,
	output reg q,
	output wire nq
);

	initial
		q = 1'b0;

	assign nq = ~q;

	always @(negedge clk)
		if (t) q <= ~q;

endmodule

`endif