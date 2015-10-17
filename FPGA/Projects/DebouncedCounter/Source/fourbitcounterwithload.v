`ifndef FOUR_BIT_COUNTER_WITH_LOAD
`define FOUR_BIT_COUNTER_WITH_LOAD

`include "ripplescaler.v"
`include "buttonpressdetector.v"
`include "updowncounter.v"

module fourbitcounterwithload (
	input wire			     upButton,
	input wire 			    downButton,
	input wire 			    loadButton,
	input wire 		     resetButton,
	input wire 			    clock,
	input wire [3:0]  switches,
	output wire [3:0]	counter,
	output wire       ack
);

	wire upReq;
	wire downReq;
	wire loadReq;

	buttonpressdetector u2bpd (
		.buttonDown(upButton), 
		.clock(clock),
		.reset(resetButton),
		.pressPulse(upReq)
	);	
		
	buttonpressdetector u3bpd (
		.buttonDown(downButton),
		.clock(clock),
		.reset(resetButton),
		.pressPulse(downReq) 
	);

	buttonpressdetector u4bpd (
		.buttonDown(loadButton),
		.clock(clock),
		.reset(resetButton),
		.pressPulse(loadReq) 
	);


	updowncounter #(.SIZE(4)) u5udc (
		.up(upReq), 
		.down(downReq),
		.load(loadReq),
		.reset(resetButton),
		.data(switches),
		.clock(clock),
		.counter(counter),
		.ack(ack)
	);

endmodule

`endif
