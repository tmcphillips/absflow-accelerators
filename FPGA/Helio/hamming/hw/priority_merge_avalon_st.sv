
module priority_merge_avalon_st
#(WIDTH=8)
(
	input		logic							clock,
	input    logic							reset,

	output  	logic							a_ready,
	input		logic							a_valid,
	input		logic		[WIDTH-1:0]		a_data,
	input		logic							a_startofpacket,
	input		logic							a_endofpacket,
	
	output  	logic							b_ready,
	input		logic							b_valid,
	input		logic		[WIDTH-1:0]		b_data,
	input		logic							b_startofpacket,
	input		logic							b_endofpacket,

	input		logic							out_ready,
	output	logic							out_valid,
	output	logic		[WIDTH-1:0]		out_data,
	output	logic							out_startofpacket,
	output	logic							out_endofpacket
);

	// state machine states
	enum logic [1:0] { EMPTY, A_LOADED, B_LOADED, FULL } state, next_state;

	// internal registers
	logic [WIDTH-1:0] a;
	logic 				a_sop;
	logic 				a_eop;

	logic [WIDTH-1:0] b;
	logic 				b_sop;
	logic 				b_eop;
	
	// state machine transition logic
	always_comb begin
	
		next_state = state;
		
		unique case(state)
		
			EMPTY:		if 		(a_valid && b_valid)			next_state = FULL;
							else if 	(a_valid)						next_state = A_LOADED;
							else if 	(b_valid)						next_state = B_LOADED;

			A_LOADED:	if 		(out_ready && b_valid) 		next_state = B_LOADED;
							else if  (out_ready && (!b_valid))	next_state = EMPTY;
							else if  ((!out_ready) &&  b_valid)	next_state = FULL;

			B_LOADED:	if 		(out_ready && a_valid)		next_state = A_LOADED;
							else if 	(out_ready && (!a_valid))	next_state = EMPTY;
							else if 	((!out_ready) && a_valid)	next_state = FULL;
							
			FULL:			if (out_ready) 							next_state = B_LOADED;
			
		endcase
		
	end
	
	// sequential logic driven by state machine
	always_ff @(posedge clock, posedge reset) begin
	
		if (reset)
			state <= EMPTY;

		else begin
	
			unique case(state)
				EMPTY:		begin
									if (next_state == A_LOADED || next_state == FULL) begin
										a <= a_data;
										a_sop <= a_startofpacket;
										a_eop <= a_endofpacket;
									end
									if (next_state == B_LOADED || next_state == FULL) begin 	
										b <= b_data;
										b_sop <= b_startofpacket;
										b_eop <= b_endofpacket;
									end
								end
				
				A_LOADED:	if (next_state == FULL) begin
									b <= b_data;
									b_sop <= b_startofpacket;
									b_eop <= b_endofpacket;
								end

				B_LOADED:	if (next_state == FULL) begin
									a <= a_data;
									a_sop <= a_startofpacket;
									a_eop <= a_endofpacket;
								end
								
				FULL:			;
									
			endcase
		
			state <= next_state;
		
		end
	end
	
	// derivation of module outputs from current state
	always_comb begin
		
		a_ready		= (state == EMPTY || state == B_LOADED);
		b_ready		= (state == EMPTY || state == A_LOADED);
		out_valid 	= (state != EMPTY);
		
		if (state == A_LOADED || state == FULL) begin
			out_data = a;
			out_startofpacket = a_sop;
			out_endofpacket = a_eop;
		end 
		else if (state == B_LOADED) begin
			out_data = b;
			out_startofpacket = b_sop;
			out_endofpacket = b_eop;
		end
		else begin
			out_data = '0;
			out_startofpacket = '0;
			out_endofpacket = '0;
		end
	end

endmodule
