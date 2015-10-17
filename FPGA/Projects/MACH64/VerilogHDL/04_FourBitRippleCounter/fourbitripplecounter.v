`include "debouncer.v"
`include "synchronousscaler.v"
`include "ripplescaler.v"
`include "ripplecounter.v"

module FourBitRippleCounter(
	input wire stepButton		/* synthesis loc="P18"				*/,
	input wire oneMHzClock		/* synthesis loc="P19" 		   		*/,
	output wire [3:0] counter	/* synthesis loc="P14,P15,P16,P17" 	*/
);
	
	wire debouncedStep;
	wire oneKHzClock;
	
	SynchronousScaler #(.BITS(6)) u1rs (
		.outclock(oneKHzClock), 
		.inclock(oneMHzClock)
	);

	Debouncer u1d (
		.debouncedSignal(debouncedStep), 
		.rawSignal(stepButton), 
		.samplingClock(oneKHzClock)
	);

	RippleCounter #(.SIZE(4)) u1rc (
		.up(debouncedStep),
		.value(counter)
	);
			
endmodule


