`include "debouncer.v"
`include "synchronousclockscaler.v"

module DebouncedFourBitCounter(
	input wire stepButton		/* synthesis loc="P18"				*/,
	input wire oneMHzClock		/* synthesis loc="P19" 		   		*/,
	input wire reset 			/* synthesis loc="P20" 		   		*/,
	input wire direction		/* synthesis loc="P21" 		   		*/,
	output reg [3:0] counter	/* synthesis loc="P14,P15,P16,P17" 	*/
);
	
	wire debouncedStep;
	wire oneKHzClock;
	
	SynchronousClockScaler #(.BITS(6)) u1cs (
		.outclock(oneKHzClock), 
		.inclock(oneMHzClock)
	);

	Debouncer u1d (
		.debouncedSignal(debouncedStep), 
		.rawSignal(stepButton), 
		.samplingClock(oneKHzClock)
	);

	always @(negedge debouncedStep, negedge reset)
		if (!reset)
			counter = 4'b0000;
		else
			if (direction) 
				counter = counter + 1;
			else 
				counter = counter - 1;

endmodule

