
module st_to_mm_adapter
# (parameter WIDTH=8)
(
	input		logic							clock,
	input    logic							reset,

	output	logic							in_ready,
	input		logic							in_valid,
	input		logic		[WIDTH-1:0]		in_data,
	input		logic							in_sop,
	input		logic							in_eop,
	
	input		logic							out_read,
	input		logic							out_address,
	output 	logic							out_waitrequest,
	output	logic		[WIDTH-1:0]		out_readdata
);
		
	// register for holding received values
	logic [WIDTH-1:0]	value;
	logic 				sop_flag;
	logic 				eop_flag;

	// one-hot declaration of state machine states
	enum logic [1:0] { 
		READY_FOR_INPUT 	= 2'b01, 
		OUTPUT_READY 		= 2'b10
	} state, next_state;
	
	// state machine transition logic
	always_comb begin
		next_state = state;
		unique case(state)
			READY_FOR_INPUT:	if (in_valid)	next_state = OUTPUT_READY;
			OUTPUT_READY:		if (out_read)	next_state = READY_FOR_INPUT;
			endcase
	end
	
	// sequential logic driven by state machine
	always_ff @(posedge clock, posedge reset)
		if (reset) begin
			value <= '0;
			state <= READY_FOR_INPUT;
		end 
		else begin
			unique case(state)

					READY_FOR_INPUT:  if (next_state == OUTPUT_READY) begin
												value <= in_data;
												eop_flag <= in_eop;
												sop_flag <= in_sop;
											end
											
					OUTPUT_READY:		;
				
				endcase
			state <= next_state;
		end

	// derivation of output control signals from current state
	assign out_waitrequest = (state == READY_FOR_INPUT) || reset;
	assign in_ready = (state == READY_FOR_INPUT);
	assign out_readdata = out_address ? { eop_flag, sop_flag } : value;
	
endmodule