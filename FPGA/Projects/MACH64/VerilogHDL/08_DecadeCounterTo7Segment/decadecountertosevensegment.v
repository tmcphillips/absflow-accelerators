`include "ripplescaler.v"
`include "buttonpressdetector.v"
`include "updowncounter.v"
`include "hexdigittosevensegment.v"
`include "bcddecadecounter.v"

module DecadeCounterToSevenSegment(
	input wire stepButton_n		/* synthesis loc="P14"				*/,
	input wire oneMHzClock		/* synthesis loc="P43"				*/,
	output wire	 		a		/* synthesis loc="P20"				*/,
	output wire	 		b		/* synthesis loc="P21"				*/,
	output wire	 		c		/* synthesis loc="P22"				*/,
	output wire	 		d		/* synthesis loc="P23"				*/,
	output wire	 		e		/* synthesis loc="P24"				*/,
	output wire	 		f		/* synthesis loc="P26"				*/,
	output wire	 		g		/* synthesis loc="P27"				*/
);

	wire oneKHzClock;
	wire stepAck;
	wire stepReq;

	wire [3:0] counter;

	RippleScaler #(.BITS(10)) u1rs (
		.inclock(oneMHzClock),
		.outclock(oneKHzClock) 
	);

	ButtonPressDetector u2bpd (
		.buttonDown(~stepButton_n), 
		.ackPress(1'b1),
		.clock(oneKHzClock),
		.wasPressed(stepReq)
	);
	
	BcdDecadeCounter u4udc (
		.clock(stepReq), 
		.q(counter)
	);
	
	HexDigitToSevenSegment u1hdtss (
		.digit(counter), 
		.segments({a,b,c,d,e,f,g})
	);

endmodule
