
module multiply_by_constant_avalon_st 
# (parameter IN_WIDTH=8, parameter OUT_WIDTH=11, parameter MULTIPLIER=2 )
(
	input		logic								clock,                                              
	input    logic								reset,

	output  	logic								in_ready,                                                   
	input		logic								in_valid,                                           
	input		logic		[IN_WIDTH-1:0]		in_data,
	input		logic								in_startofpacket,
	input		logic								in_endofpacket,

	input		logic								out_ready,                                          
	output	logic								out_valid,                                                 
	output	logic								out_startofpacket,
	output	logic								out_endofpacket,
	output	logic		[OUT_WIDTH-1:0]	out_data
);

	logic					[OUT_WIDTH-1:0]	product;

	enum logic [3:0] { 
		IN_READY				= 4'b0001, 
		OUT_DATA_VALID 	= 4'b0010,
		OUT_SOP_VALID 		= 4'b0100,
		OUT_EOP_VALID 		= 4'b1000
	} state, next_state; 
	
	// state machine transition logic
	always_comb begin
		next_state = state;
		unique case(state)
		
			IN_READY:			if (in_valid) begin
										if (in_startofpacket) 			next_state = OUT_SOP_VALID;
										else if (in_endofpacket) 		next_state = OUT_EOP_VALID;
										else 									next_state = OUT_DATA_VALID;
									end
									
			OUT_SOP_VALID,
			OUT_EOP_VALID,
			OUT_DATA_VALID:	if (out_ready) next_state = IN_READY;
			
		endcase
	end
	
	// sequential logic driven by state machine
	always_ff @(posedge clock, posedge reset)
		if (reset) begin
			out_data <= '0;
			state <= IN_READY;
		end
		else begin 
			if (state == IN_READY) begin
				unique case(next_state)

					OUT_DATA_VALID:	out_data <= product;

					OUT_SOP_VALID,
					OUT_EOP_VALID:		out_data <= in_data;
					
					default:				;
				endcase
			end
			state <= next_state;
		end
	
	// derivation of output signals from current state
	assign in_ready = (state == IN_READY);
	assign out_valid = ~in_ready;
	assign out_startofpacket = (state == OUT_SOP_VALID);
	assign out_endofpacket = (state == OUT_EOP_VALID);
	
	constant_multiplier #(.IN_WIDTH(IN_WIDTH), .OUT_WIDTH(OUT_WIDTH), .MULTIPLIER(MULTIPLIER)) um0 (
		.multiplicand		(in_data),
		.product
	);

endmodule
