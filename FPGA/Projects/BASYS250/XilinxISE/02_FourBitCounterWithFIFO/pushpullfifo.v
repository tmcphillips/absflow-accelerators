`include "macros.v"

`timescale 1ns / 1ps

module PushPullFIFO #(parameter FIFO_WORD_SIZE=1, parameter FIFO_POINTER_BITS=2) (
	input wire clock,
	input wire clear,
	input wire inValue,
	input wire inReq,
	input wire outReq,	
	output reg inAck,
	output reg outAck,
	output reg outValue
 );

	reg headState;
	reg tailState;
	
	localparam WAIT_REQ_HIGH	= 1'b0;
	localparam WAIT_REQ_LOW		= 1'b1;
	
	localparam FIFO_SLOT_COUNT = 2 ** FIFO_POINTER_BITS;

	reg [FIFO_WORD_SIZE-1:0] buffer [0:FIFO_SLOT_COUNT-1];
	reg [FIFO_POINTER_BITS-1:0] headIndex;
	reg [FIFO_POINTER_BITS-1:0] tailIndex;
	
	reg [FIFO_POINTER_BITS-1:0] nextHeadIndex;

	reg wrapped;

	always @(posedge clear, posedge clock)
	
		if (clear) 
			begin		
				inAck 		= `LOW;
				headIndex	=  3'b0;
				wrapped		<= `FALSE;
				headState 	<=  WAIT_REQ_HIGH;
			end
			
		else
			case(headState)
		
				WAIT_REQ_HIGH:		if (inReq)
											begin
												nextHeadIndex = headIndex + 1;
												if ((nextHeadIndex != tailIndex) | !wrapped)
													begin
														inAck = `HIGH;
														buffer[headIndex] <= inValue;
														headIndex = nextHeadIndex;
														if (headIndex == 0) wrapped <= `TRUE;
														headState <= WAIT_REQ_LOW;
													end
											end 
								
				WAIT_REQ_LOW:		begin
											inAck = `LOW;
											if (!inReq) headState <= WAIT_REQ_HIGH;
										end
										
			endcase

	always @(posedge clear, posedge clock)
	
		if (clear) 
			begin		
				outValue		<= 0;
				outAck 		<= `LOW;
				tailIndex	= 3'b0;
				tailState 	<=  WAIT_REQ_HIGH;
			end
			
		else
			case(tailState)
		
				WAIT_REQ_HIGH: 	if (outReq & ((tailIndex != headIndex) | wrapped))
											begin
												outAck = `HIGH;
												outValue <= buffer[tailIndex];
												tailIndex = tailIndex + 1;
												if (tailIndex == 0) wrapped <= `FALSE;
												tailState <= WAIT_REQ_LOW;
											end
										
				WAIT_REQ_LOW:		begin
											outAck = `LOW;
											if (!outReq) tailState <= WAIT_REQ_HIGH;
										end
			
			endcase

endmodule
