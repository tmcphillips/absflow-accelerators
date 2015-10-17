`timescale 1ns / 1ps
`include "macros.v"

module PushPullFIFO_tb;

	// Inputs
	reg clock;
	reg clear;
	reg inValue;
	reg inReq;
	reg outReq;

	// Outputs
	wire inAck;
	wire outValue;
	wire outAck;

	// Instantiate the Unit Under Test (UUT)
	PushPullFIFO #(.FIFO_WORD_SIZE(1), .FIFO_POINTER_BITS(2)) uut (
		.clock(clock),
		.clear(clear),
		.inValue(inValue), 
		.inReq(inReq), 
		.inAck(inAck), 
		.outValue(outValue), 
		.outReq(outReq), 
		.outAck(outAck)
	);

	initial begin

		$printtimescale;
		$timeformat(-9, 10, "", 10);

		// Initialize Inputs
		clock = 0;
		clear = 0;
		inValue = 0;
		inReq = 0;
		outReq = 0;

		#2 	clear = `HIGH;
		
		#2 	clear = `LOW;
				`ASSERT(	inAck 	== 	`LOW	);
				`ASSERT(	outAck 	==		`LOW	);
		
		// put four values into empty fifo
		#2		putValue_ImmediateAck(1);
		#2		putValue_ImmediateAck(0);
		#2		putValue_ImmediateAck(1);
		#2		putValue_ImmediateAck(0);

		// take all four values leaving fifo empty
		#2		takeValue_ImmediateAck(1);
		#2		takeValue_ImmediateAck(0);
		#2		takeValue_ImmediateAck(1);
		#2		takeValue_ImmediateAck(0);
		
		// put another four values into empty fifo
		#2		putValue_ImmediateAck(0);
		#2		putValue_ImmediateAck(1);
		#2		putValue_ImmediateAck(0);
		#2		putValue_ImmediateAck(1);

		// take all four values leaving fifo empty again
		#2		takeValue_ImmediateAck(0);
		#2		takeValue_ImmediateAck(1);
		#2		takeValue_ImmediateAck(0);
		#2		takeValue_ImmediateAck(1);
		
		// put and take one value
		#2		putValue_ImmediateAck(0);
		#2		takeValue_ImmediateAck(0);
		
		// put and take one value
		#2		putValue_ImmediateAck(1);
		#2		takeValue_ImmediateAck(1);

		// put and take one value
		#2		putValue_ImmediateAck(1);
		#2		takeValue_ImmediateAck(1);

		// put and take one value
		#2		putValue_ImmediateAck(0);
		#2		takeValue_ImmediateAck(0);
				
		#6		$write("*** SUCCESS ***  Simulation ended succesfully at t = %t \n", $realtime);
				$finish;
				
	end
     
	always #1 clock = ~clock;


	task putValue_ImmediateAck(input value);
		begin
					inValue = value;
					inReq = `HIGH;
					`ASSERT(	inAck 	== 	`LOW	);
					`ASSERT(	outAck 	==		`LOW	);

			#2 	inReq = `LOW;
					`ASSERT(	inAck 	==		`HIGH	);
					`ASSERT(	outAck 	==		`LOW	);
		end
	endtask


	task takeValue_ImmediateAck(input value);
		begin
					outReq = `HIGH;
					`ASSERT(	inAck 	== 	`LOW	);
					`ASSERT(	outAck 	==		`LOW	);

			#2 	outReq = `LOW;
					`ASSERT( outValue ==		value	);
					`ASSERT(	inAck 	==		`LOW	);
					`ASSERT(	outAck 	==		`HIGH	);		
		end
	endtask
		
		
endmodule

