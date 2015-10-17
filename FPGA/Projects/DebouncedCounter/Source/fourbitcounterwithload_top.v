`ifndef FOUR_BIT_COUNTER_WITH_LOAD_TOP
`define FOUR_BIT_COUNTER_WITH_LOAD_TOP

`include "ripplescaler.v"
`include "buttonpressdetector.v"
`include "updowncounter.v"

module fourbitcounterwithload_top #(parameter CLOCK_SCALER_BITS=20) (
	input wire			upButton,
	input wire 			downButton,
	input wire 			loadButton,
	input wire 			resetButton,
	input wire [3:0] 	switches,
	input wire 			systemClock,
	output wire [3:0]	counter
);

	wire debouncingClock;
	
	ripplescaler #(.BITS(CLOCK_SCALER_BITS)) u1rs (
		.inclock(systemClock),
		.reset(resetButton),
		.outclock(debouncingClock) 
	);
	
  fourbitcounterwithload u2fbcwl(
	  .upButton(upButton),
	  .downButton(downButton),
	  .loadButton(loadButton),
	  .resetButton(resetButton),
	  .switches(switches),
	  .clock(debouncingClock),
	  .counter(counter)
  );

endmodule

`endif


