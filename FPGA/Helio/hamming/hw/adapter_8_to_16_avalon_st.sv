
module adapter_8_to_16_avalon_st (
	input		logic					clock,                                              
	input    logic					reset,

	output  	logic					in_ready,                                                   
	input		logic					in_valid,                                           
	input		logic		[7:0]		in_data,                                                    

	input		logic					out_ready,                                          
	output	logic					out_valid,                                                  
	output	logic		[15:0]	out_data 
);

	enum logic 	[1:0]	{ ZERO_BYTES_LOADED, ONE_BYTE_LOADED, TWO_BYTES_LOADED } state, next_state;
	logic			[7:0]	first_byte, second_byte;
	
	// state machine transition logic
	always_comb begin
		next_state = state;
		unique case(state)
			ZERO_BYTES_LOADED	: 	if (in_valid) 	next_state = ONE_BYTE_LOADED;
			ONE_BYTE_LOADED	:	if (in_valid)	next_state = TWO_BYTES_LOADED;
			TWO_BYTES_LOADED	:	if (out_ready)	next_state = ZERO_BYTES_LOADED;
		endcase;
	end
	
	// sequential logic driven by state machine
	always_ff @(posedge clock, posedge reset) begin
		if (reset)
			state	<= ZERO_BYTES_LOADED;
		else begin
			unique case(state)
				ZERO_BYTES_LOADED:	if (next_state == ONE_BYTE_LOADED) first_byte <= in_data;
				ONE_BYTE_LOADED:		if (next_state == TWO_BYTES_LOADED) second_byte	<= in_data;
				TWO_BYTES_LOADED:		;
			endcase
			state <= next_state;
		end
	end
	
	// derivation of output signals from current state
	assign out_data = { first_byte, second_byte };
	assign out_valid = (state == TWO_BYTES_LOADED);
	assign in_ready = ~out_valid;
	
endmodule
