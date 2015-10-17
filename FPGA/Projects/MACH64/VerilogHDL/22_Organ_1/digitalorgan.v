`include "ripplescaler.v"

module DigitalOrgan(
	input wire 			oneMHzClock		/* synthesis LOC="P43" 				*/,
	input wire [1:4]	button_n		/* synthesis LOC="P21,P22,P23,P24" 	*/,
	output wire 		rca				/* synthesis LOC="P31"				*/
);

	wire [1:4] noteSource;
	wire [1:4] noteButton = ~button_n;

	RippleScaler #(.BITS(12)) u0rs  (
		.inclock(oneMHzClock),
		.outclock(noteSource[1])
	);

	RippleScaler #(.BITS(1)) u1rs  (
		.inclock(noteSource[1]),
		.outclock(noteSource[2])
	);

	RippleScaler #(.BITS(1)) u2rs  (
		.inclock(noteSource[2]),
		.outclock(noteSource[3])
	);

	RippleScaler #(.BITS(1)) u3rs  (
		.inclock(noteSource[3]),
		.outclock(noteSource[4])
	);

	assign rca = noteSource[1] & noteButton[1] |
				 noteSource[2] & noteButton[2] |
				 noteSource[3] & noteButton[3] |
				 noteSource[4] & noteButton[4];

endmodule

