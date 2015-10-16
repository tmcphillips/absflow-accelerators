`include "ripplescaler.v"
`include "buttonpressdetector.v"
`include "updowncounter.v"

`default_nettype none

module FourBitCounterWithLoad #(parameter CLOCK_SCALER_BITS=20) (
	input wire			upButton,
	input wire 			downButton,
	input wire 			loadButton,
	input wire 			resetButton,
	input wire [3:0] 	switches,
	input wire 			systemClock,
	output wire [3:0]	counter
);

	wire debouncingClock;
	wire upAck;
	wire upReq;
	wire downAck;
	wire downReq;
	
	RippleScaler #(.BITS(CLOCK_SCALER_BITS)) u1rs (
		.inclock(systemClock),
		.reset(resetButton),
		.outclock(debouncingClock) 
	);

	ButtonPressDetector u2bpd (
		.buttonDown(upButton), 
		.ackPress(upAck),
		.clock(debouncingClock),
		.reset(resetButton),
		.wasPressed(upReq)
	);	
		
	ButtonPressDetector u3bpd (
		.buttonDown(downButton), 
		.ackPress(downAck), 
		.clock(debouncingClock),
		.reset(resetButton),
		.wasPressed(downReq) 
	);

	UpDownCounter #(.SIZE(4)) u4udc (
		.up(upReq), 
		.down(downReq),
		.load(loadButton),
		.reset(resetButton),
		.data(switches),
		.clock(debouncingClock),
		.upAck(upAck), 
		.downAck(downAck), 
		.counter(counter)
	);

endmodule

