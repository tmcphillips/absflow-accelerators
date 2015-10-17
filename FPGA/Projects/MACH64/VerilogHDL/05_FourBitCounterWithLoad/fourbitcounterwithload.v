`include "ripplescaler.v"
`include "buttonpressdetector.v"
`include "updowncounter.v"

`default_nettype none

module FourBitCounterWithLoad(
	input wire			upButton_n		/* synthesis loc="P24"				*/,
	input wire 			downButton_n	/* synthesis loc="P23"				*/,
	input wire 			loadButton_n	/* synthesis loc="P22"				*/,
	input wire 			resetButton_n	/* synthesis loc="P21"				*/,
	input wire [3:0] 	dipSwitches_n	/* synthesis loc="P14,P15,P16,P17"	*/,
	input wire 			oneMHzClock		/* synthesis loc="P42" 		   		*/,
	output wire [3:0] 	counter			/* synthesis loc="P34,P33,P32,P31" 	*/
);

	wire oneKHzClock;
	wire upAck;
	wire downAck;
	wire upReq;
	wire downReq;
	
	RippleScaler #(.BITS(10)) u1rs (
		.inclock(oneMHzClock),
		.outclock(oneKHzClock) 
	);
	
	ButtonPressDetector u2bpd (
		.buttonDown(~upButton_n), 
		.ackPress(upAck),
		.clock(oneKHzClock),
		.wasPressed(upReq)
	);
	
	ButtonPressDetector u3bpd (
		.buttonDown(~downButton_n), 
		.ackPress(downAck), 
		.clock(oneKHzClock),
		.wasPressed(downReq) 
	);

	UpDownCounter #(.SIZE(4)) u4udc (
		.up(upReq), 
		.down(downReq),
		.load(~loadButton_n),
		.reset(~resetButton_n),
		.data(~dipSwitches_n),
		.clock(oneKHzClock),
		.upAck(upAck), 
		.downAck(downAck), 
		.counter(counter)
	);
				
endmodule

