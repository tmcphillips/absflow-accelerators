module lowpass_filter_avalon_st
# (parameter IN_WIDTH				= 8,	// Width of data input stream
	parameter OUT_WIDTH				= 8,	// Width of cutoff value and output stream 
	parameter DEFAULT_CUTOFF		= -1,	// By default let everything through.
	parameter FORWARD_DELIMITERS 	= 0,	// Set to zero to discard incoming data with startofpacket==1 or endofpacket==1
	parameter EOP_ON_EXCEED 		= 0,	// Set to 1 to generate a delimiter with endofpacket==1 when the cutoff is exceeded.
	parameter NEW_EOP_VALUE			= 0	// Value of the delimiter generated when the cutoff is exceeded.
)	
(
	input		logic								clock,
	input    logic								reset,

	output  	logic								in_ready,
	input		logic								in_valid,
	input		logic								in_startofpacket,
	input		logic								in_endofpacket,
	input		logic		[IN_WIDTH-1:0]		in_data,

	input		logic								out_ready,
	output	logic								out_valid,
	output	logic								out_startofpacket,
	output	logic								out_endofpacket,
	output	logic		[OUT_WIDTH-1:0]	out_data,

	input		logic								cutoff_write,
	input		logic		[OUT_WIDTH-1:0]	cutoff_writedata,

	input		logic								cutoff_read,
	output	logic		[OUT_WIDTH-1:0]	cutoff_readdata,
	
	output	logic								wait_for_eop
);

	/**************************************************************************/
	/*                        cutoff value r/w logic                          */
	/**************************************************************************/
	
	// register for holding the cutoff value
	logic [IN_WIDTH-1:0] 	cutoff;
	logic [OUT_WIDTH-1:0]	data;
	
	logic in_sop_valid;
	logic in_eop_valid;
	logic in_data_valid;
	
	// logic for resetting and writing values to cutoff
	always_ff @(posedge clock, posedge reset)
		if (reset) begin
			cutoff <= DEFAULT_CUTOFF;
		end
		else begin
			if (cutoff_write) cutoff <= cutoff_writedata;
		end
	
	// output cutoff value when requested
	assign cutoff_readdata = cutoff_read ? cutoff : 'x;
	
	
	/**************************************************************************/
	/*                       filter state machine logic                       */
	/**************************************************************************/

	// one-hot declaration of state machine states
	enum logic [5:0] { 
		WAIT_FOR_DATA		= 6'b000001,
		FORWARD_DATA 		= 6'b000010,
		FORWARD_SOP 		= 6'b000100,
		FORWARD_EOP 		= 6'b001000,
		OUTPUT_NEW_EOP		= 6'b010000,
		WAIT_FOR_EOP		= 6'b100000
	} state, next_state;
	
	// state machine transition logic
	always_comb begin
		
		in_sop_valid 	= in_valid & in_startofpacket & FORWARD_DELIMITERS;
		in_eop_valid 	= in_valid & in_endofpacket & FORWARD_DELIMITERS;
		in_data_valid 	= in_valid & ~in_startofpacket & ~in_endofpacket;

		next_state = state;
		
		unique case(state)
		
			WAIT_FOR_DATA:		if (in_data_valid) begin
										if (in_data <= cutoff)		next_state = FORWARD_DATA;
										else if (EOP_ON_EXCEED)		next_state = OUTPUT_NEW_EOP;
									end
									else if (in_sop_valid) 			next_state = FORWARD_SOP;
									else if (in_eop_valid) 			next_state = FORWARD_EOP;
										
			FORWARD_DATA,	
			FORWARD_SOP,
			FORWARD_EOP:		if (out_ready) 					next_state = WAIT_FOR_DATA;
									
			OUTPUT_NEW_EOP:	if (out_ready)						next_state = WAIT_FOR_EOP;
			
			WAIT_FOR_EOP:		if (in_valid & in_endofpacket)	next_state = WAIT_FOR_DATA;
						
			default:														next_state = WAIT_FOR_DATA;
		
		endcase
	end
	
	// sequential logic driven by state machine
	always_ff @(posedge clock, posedge reset)
		if (reset) begin
			data 				<= '0;
 			state 			<= WAIT_FOR_DATA;
		end
		else begin 
			if (state == WAIT_FOR_DATA) begin
				unique case(next_state)

					FORWARD_DATA,
					FORWARD_SOP,
					FORWARD_EOP:		data <= in_data;


					OUTPUT_NEW_EOP:	data <= NEW_EOP_VALUE;
					
					default:				;
	
				endcase
			end
			state <= next_state;
		end

	// derivation of output control signals from current state
	assign in_ready 				= (state == WAIT_FOR_DATA || state == WAIT_FOR_EOP);
	assign out_valid 				= ~in_ready;
	assign out_data 				= out_valid ? data : 'x;
	assign out_startofpacket 	= out_valid ? (state == FORWARD_SOP) : 'x;
	assign out_endofpacket 		= out_valid ? (state == FORWARD_EOP || state == OUTPUT_NEW_EOP) : 'x;
	assign wait_for_eop			= (state == WAIT_FOR_EOP);
	
endmodule