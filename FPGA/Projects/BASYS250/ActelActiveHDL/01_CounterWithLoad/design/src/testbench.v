`timescale 1ms/1us

module testbench();
	
	reg upButton;
	reg downButton;
	reg loadButton;
	reg resetButton;
	reg [3:0] switches;
	reg testClock;
	wire [3:0] counter;
	
	FourBitCounterWithLoad #(.CLOCK_SCALER_BITS(2)) u0sut (
		.upButton(upButton),
		.downButton(downButton),
		.loadButton(loadButton),
		.resetButton(resetButton),
		.switches(switches),
		.systemClock(testClock),
		.counter(counter)
	);

	
	parameter HIGH 	= 1'b1;
	parameter LOW	= 1'b0;
	
	initial
		begin
			
			upButton	= LOW;
			downButton	= LOW;
			loadButton	= LOW;
			resetButton = LOW;
			switches	= 4'b0000;
			
			#20  	resetButton = HIGH;
			#30		resetButton = LOW;
			
			#100	upButton	= HIGH;
			#400	upButton	= LOW;

			#200	upButton	= HIGH;
			#200	upButton	= LOW;

		end
	
endmodule