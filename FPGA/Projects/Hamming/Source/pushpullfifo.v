`include "macros.v"

`timescale 1ns / 1ps

module PushPullFIFO #(parameter FIFO_WORD_SIZE=1, parameter FIFO_POINTER_BITS=2) (
	input wire clock,
	input wire clear,
	input wire put_req,
	output reg put_ack,
	input wire [FIFO_WORD_SIZE-1:0] put_value,
	input wire get_req,
	output reg get_ack,
	output reg [FIFO_WORD_SIZE-1:0] get_value
 );

	reg head_state;
	reg tail_state;
	
	localparam WAIT_REQ_HIGH	= 1'b0;
	localparam WAIT_REQ_LOW		= 1'b1;
	
	localparam FIFO_SLOT_COUNT = 2 ** FIFO_POINTER_BITS;

    // buffer storage
	reg [FIFO_WORD_SIZE-1:0] buffer [0:FIFO_SLOT_COUNT-1];
	
	// buffer element pointers
	reg [FIFO_POINTER_BITS-1:0]  head_index;
	reg [FIFO_POINTER_BITS-1:0]  tail_index;
	reg [FIFO_POINTER_BITS-1:0]  next_head_index;

	reg wrapped;    

	always @(posedge clear, posedge clock) begin : handle_put_requests
	
		if (clear)  
            
            begin
                put_ack     = 0;
                head_index  = 0;
                wrapped		<= `FALSE;
                head_state  <=  WAIT_REQ_HIGH;		
            end
            
        else 
            
            case(head_state)
		
                WAIT_REQ_HIGH:  
                
                    if (put_req) begin
                        next_head_index = head_index + 1;
                        if ((next_head_index != tail_index) | !wrapped) begin
                            put_ack = `HIGH;
                            buffer[head_index] <= put_value;
                            head_index = next_head_index;
                            if (head_index == 0) wrapped <= `TRUE;
                            head_state <= WAIT_REQ_LOW;
                        end
                    end 
                                    
                WAIT_REQ_LOW:	
                    
                    begin
                        put_ack = `LOW;
                        if (!put_req) head_state <= WAIT_REQ_HIGH;
                    end
                                            
            endcase
    
    end : handle_put_requests

    
	always @(posedge clear, posedge clock) begin : handle_get_requests
	
        if (clear)  
        
            begin
                get_value	<= 0;
                get_ack     <= 0;
                tail_index	= 0;
                tail_state  <=  WAIT_REQ_HIGH;
            end
                
        else 
        
            case(tail_state)
		
                WAIT_REQ_HIGH: 	if (get_req & ((tail_index != head_index) | wrapped)) begin
                                    get_ack = `HIGH;
                                    get_value <= buffer[tail_index];
                                    tail_index = tail_index + 1;
                                    if (tail_index == 0) wrapped <= `FALSE;
                                    tail_state <= WAIT_REQ_LOW;
                                end
                                            
                WAIT_REQ_LOW:   begin
                                    get_ack = `LOW;
                                    if (!get_req) tail_state <= WAIT_REQ_HIGH;
                                end
                
            endcase

    end : handle_get_requests
    
endmodule
