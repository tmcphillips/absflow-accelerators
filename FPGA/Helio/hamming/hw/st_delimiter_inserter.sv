
module st_delimiter_inserter
# (parameter WIDTH=8)
(
	input		logic							clock,
	input    logic							reset,

	output 	logic							delim_waitrequest,
	input		logic							delim_write,
	input		logic		[WIDTH-1:0]		delim_writedata,
	input		logic							delim_is_eop,

	output	logic							in_ready,
	input		logic							in_valid,
	input		logic		[WIDTH-1:0]		in_data,

	input		logic							out_ready,
	output	logic							out_valid,
	output	logic		[WIDTH-1:0]		out_data,
	output	logic							out_sop,
	output	logic							out_eop
);

	// one-hot declaration of state machine states
	enum logic [5:0] { 
		IDLE		 		= 6'b000001, 
		IN_READY 		= 6'b000010,
		DELIM_READY 	= 6'b000100,
		DATA_VALID		= 6'b001000,
		SOP_VALID		= 6'b010000,
		EOP_VALID		= 6'b100000
	} state, next_state;
	
	// state machine transition logic
	always_comb begin
		next_state = state;
		unique case(state)
		
			IDLE:				if (delim_write) 			next_state = DELIM_READY;
								else if (in_valid)		next_state = IN_READY;
								
			DELIM_READY:	if (delim_write) begin
									if (delim_is_eop) 	next_state = EOP_VALID;
									else						next_state = SOP_VALID;
								end
								else							next_state = IDLE;

			IN_READY:		if (in_valid) 				next_state = DATA_VALID;
								else 							next_state = IDLE;
			
			DATA_VALID:		if (out_ready)	begin
									if (in_valid & 
											~delim_write)	next_state = IN_READY;
									else 						next_state = IDLE;
								end
			SOP_VALID,
			EOP_VALID:		if (out_ready) begin
									if (in_valid) 			next_state = IN_READY;
									else 						next_state = IDLE;
								end
		endcase
	end
	
	// sequential logic driven by state machine
	always_ff @(posedge clock, posedge reset)
		if (reset) begin
			out_data <= '0;
			state <= IDLE;
		end
		else begin 
			if (state == IN_READY && next_state == DATA_VALID) 			
				out_data <= in_data;
			else if (state == DELIM_READY && (next_state == SOP_VALID || next_state == EOP_VALID))
				out_data <= delim_writedata;
			state <= next_state;
		end

	// derivation of output control signals from current state
	assign delim_waitrequest = (state != DELIM_READY) || reset;
	assign in_ready = (state == IN_READY);
	assign out_sop = (state == SOP_VALID);
	assign out_eop = (state == EOP_VALID);
	assign out_valid = ((state == DATA_VALID) || out_sop || out_eop);
	
endmodule