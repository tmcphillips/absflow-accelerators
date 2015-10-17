`include "macros.v"
`timescale 1us/1ns

module FourBitCounterWithLoad_tb();
	
	reg upButton;
	reg downButton;
	reg loadButton;
	reg resetButton;
	reg [3:0] switches;
	reg clock;
	wire [3:0] counter;
	
	FourBitCounterWithLoad #(.CLOCK_SCALER_BITS(2)) u0dut (
		.upButton(upButton),
		.downButton(downButton),
		.loadButton(loadButton),
		.resetButton(resetButton),
		.switches(switches),
		.systemClock(clock),
		.counter(counter)
	);

	wire upReq 								= u0dut.upReq;
	wire upAck 								= u0dut.upAck;
	wire downReq 							= u0dut.downReq;
	wire downAck 							= u0dut.downAck;
	wire debouncingClock 				= u0dut.debouncingClock;

	// generate system clock signal
	always #1 clock = ~clock;
		
	initial begin

		// set time format
		$printtimescale;
		$timeformat(-6, 10, "", 10);

		// initialize system input signals
		clock 		= `LOW;
		upButton		= `LOW;
		downButton	= `LOW;
		loadButton	= `LOW;
		resetButton = `LOW;
		switches		= 4'b0000;

		#20	resetButton = `HIGH;
		#10	resetButton = `LOW;
				`ASSERT(counter == 0);

		#20	upButton = `HIGH;
		#5		upButton = `LOW;
				`ASSERT(counter == 0);

		#20	upButton = `HIGH;
		#40	upButton = `LOW;
				`ASSERT(counter == 1);
										
		#20	upButton = `HIGH;
		#40	upButton = `LOW;
				`ASSERT(counter == 2); 

		#20	switches = 11;
		#10	loadButton = `HIGH;
		#20	loadButton = `LOW;
				`ASSERT(counter == 11);

		#20	downButton = `HIGH;
		#5		downButton = `LOW;
				`ASSERT(counter == 11);
				
		#20	downButton = `HIGH;
		#40	downButton = `LOW;
				`ASSERT(counter == 10);

		#20;

		$write("*** SUCCESS ***  Simulation ended succesfully at t = %t \n", $realtime);
		$finish;

	end
	
endmodule

