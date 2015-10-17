
module adapter_16_to_8_avalon_st (
	input		logic					clock,
	input    logic					reset,

	output  	logic					in_ready,
	input		logic					in_valid,
	input		logic		[15:0]	in_data,

	input		logic					out_ready,
	output	logic					out_valid,
	output	logic		[7:0]		out_data
);

	enum logic 	[1:0]	{ ZERO_BYTES_LOADED, TWO_BYTES_LOADED, ONE_BYTE_LOADED } state, next_state;
	logic			[7:0]	first_byte, second_byte;
		
	// state machine transition logic
	always_comb begin
		next_state = state;
		unique case(state)
			ZERO_BYTES_LOADED	: 	if (in_valid) 	next_state = TWO_BYTES_LOADED;
			TWO_BYTES_LOADED	:	if (out_ready)	next_state = ONE_BYTE_LOADED;
			ONE_BYTE_LOADED	:	if (out_ready)	next_state = ZERO_BYTES_LOADED;
		endcase;
	end
	
	// sequential logic driven by state machine
	always_ff @(posedge clock, posedge reset) begin
		if (reset)
			state <= ZERO_BYTES_LOADED;
		else begin
			if (state == ZERO_BYTES_LOADED && next_state == TWO_BYTES_LOADED) begin
				first_byte 	<= in_data[15:8];
				second_byte	<= in_data[7:0];
			end
			state <= next_state;
		end
	end

	// derivation of output signals from current state
	always_comb begin
		in_ready = (state == ZERO_BYTES_LOADED);
		out_valid = ~in_ready;
		unique case(state)
			ZERO_BYTES_LOADED: 	out_data 	= 8'bxxxx_xxxx;
			TWO_BYTES_LOADED:		out_data 	= first_byte;
			ONE_BYTE_LOADED:		out_data 	= second_byte;			
		endcase;
	end
	
endmodule
