
module mm_to_st_adapter
# (parameter WIDTH=8)
(
	input		logic							clock,
	input    logic							reset,

	output 	logic							in_waitrequest,
	input		logic							in_write,
	input		logic		[WIDTH-1:0]		in_writedata,
	input		logic		[1:0]				in_address,
	
	input		logic							out_ready,
	output	logic							out_valid,
	output	logic		[WIDTH-1:0]		out_data,
	output	logic							out_sop,
	output	logic							out_eop
);
	
	// register for holding the cutoff value
	logic [WIDTH-1:0] value;

	// one-hot declaration of state machine states
	enum logic [1:0] { 
		READY_FOR_INPUT 	= 2'b01, 
		OUTPUT_VALID 		= 2'b10
	} state, next_state;
	
	// state machine transition logic
	always_comb begin
		next_state = state;
		unique case(state)
			READY_FOR_INPUT:	if (in_write)				next_state = OUTPUT_VALID;
			OUTPUT_VALID:		if (out_ready) 			next_state = READY_FOR_INPUT;
		endcase
	end
	
	// sequential logic driven by state machine
	always_ff @(posedge clock, posedge reset)
		if (reset) begin
			value <= '0;
			state <= READY_FOR_INPUT;
		end
		else begin 
			if (state == READY_FOR_INPUT && next_state == OUTPUT_VALID) begin
				value <= in_writedata;
				out_sop = (in_address == 2'b10);
				out_eop = (in_address == 2'b11);
			end
			state <= next_state;
		end

	// derivation of output control signals from current state
	assign in_waitrequest = (state == OUTPUT_VALID) || reset;
	assign out_valid = (state == OUTPUT_VALID);
	assign out_data = value;
	
endmodule