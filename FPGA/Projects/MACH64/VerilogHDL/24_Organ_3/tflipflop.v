`ifndef T_FLIP_FLOP
`define T_FLIP_FLOP

module TFlipFlop(
	input wire clk,
	input wire t,
	output reg q,
	output wire nq
);

	assign nq = ~q;

	always @(negedge clk)
		if (t) q <= ~q;

endmodule

`endif