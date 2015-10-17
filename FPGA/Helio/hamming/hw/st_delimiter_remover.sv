
module st_delimiter_remover
# (parameter WIDTH=8, parameter bit DELIMITER_VALUE_PASSTHRU=0)
(
	input		logic							clock,
	input    logic							reset,

	output	logic		[7:0]				csr_readdata,
	
	output	logic							in_ready,
	input		logic							in_valid,
	input		logic		[WIDTH-1:0]		in_data,
	input		logic							in_sop,
	input		logic							in_eop,

	input		logic							out_ready,
	output	logic							out_valid,
	output	logic		[WIDTH-1:0]		out_data
);

	logic 	sop_flag;
	logic 	eop_flag;
	
	logic		is_delimiter;
	logic		is_data;
	logic		is_delimiter_to_passthru;
	logic		is_delimiter_to_discard;
	
	assign is_delimiter = in_sop | in_eop;
	assign is_data = ~is_delimiter;
	assign is_delimiter_to_passthru = is_delimiter & DELIMITER_VALUE_PASSTHRU;
	assign is_delimiter_to_discard = is_delimiter & ~DELIMITER_VALUE_PASSTHRU;
	
	// one-hot declaration of state machine states
	enum logic [2:0] { 
		IN_READY 		= 3'b001,
		OUT_VALID		= 3'b010,
		DISCARD			= 3'b100
	} state, next_state;
	
	// state machine transition logic
	always_comb begin
		next_state = state;
		unique case(state)
			IN_READY:	if (in_valid) begin
								if (is_data || is_delimiter_to_passthru) 	next_state = OUT_VALID;
								else if (is_delimiter_to_discard) 			next_state = DISCARD;
							end
			OUT_VALID:	if (out_ready)											next_state = IN_READY;
			DISCARD:																	next_state = IN_READY;
		endcase
	end
	
	// sequential logic driven by state machine
	always_ff @(posedge clock, posedge reset)
		if (reset) begin
			out_data <= '0;
			sop_flag <= '0;
			eop_flag <= '0;
			state <= IN_READY;
		end
		else begin 
			if (state == IN_READY && next_state != IN_READY) begin 
				sop_flag <= in_sop;
				eop_flag <= in_eop;
				if (next_state == OUT_VALID) out_data <= in_data;
			end
			state <= next_state;
		end

	// derivation of output control signals from current state
	assign in_ready = (state == IN_READY);
	assign out_valid = (state == OUT_VALID);
	assign csr_readdata = { {6{1'b0}}, eop_flag, sop_flag };
	
endmodule