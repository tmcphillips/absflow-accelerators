
module ordered_merge_avalon_st
#(DATA_WIDTH=8, CSR_WIDTH=8, SEND_ENDOFPACKET=1'b1, END_PACKET_VALUE=0)
(
	input		logic								clock,
	input    logic								reset,

	output  	logic								a_ready,
	input		logic								a_valid,
	input		logic		[DATA_WIDTH-1:0]	a_data,
	input		logic								a_startofpacket,
	input		logic								a_endofpacket,

	output  	logic								b_ready,
	input		logic								b_valid,
	input		logic		[DATA_WIDTH-1:0]	b_data,
	input		logic								b_startofpacket,
	input		logic								b_endofpacket,

	input		logic								out_ready,
	output	logic								out_valid,
	output	logic		[DATA_WIDTH-1:0]	out_data,
	output	logic								out_startofpacket,
	output	logic								out_endofpacket,
	
	input		logic		[2:0]					csr_address,
	input		logic								csr_read,
	input		logic								csr_write,
	output	logic		[CSR_WIDTH-1:0]	csr_readdata,
	input		logic		[CSR_WIDTH-1:0]	csr_writedata
);

	// one-hot state machine
	enum logic [4:0] {
		IDLE			= 5'b00001, 
		READ_A		= 5'b00010,
		READ_B		= 5'b00100,
		WRITE_DATA	= 5'b01000,
		WRITE_EOP	= 5'b10000
	} state, next_state;

	// internal registers
	logic [DATA_WIDTH-1:0] a;
	logic [DATA_WIDTH-1:0] b;
	logic [DATA_WIDTH-1:0] last_out_data;
	logic is_first;
	logic a_loaded;
	logic b_loaded;
	logic a_closed;
	logic b_closed;
	
	always_comb 
	if (csr_read)
		unique case(csr_address)
			3'b000:		csr_readdata 	= state;
			3'b001:		csr_readdata 	= { a_loaded, b_loaded, a_closed, b_closed, is_first };
			3'b010:		csr_readdata 	= a;
			3'b011:		csr_readdata  	= (DATA_WIDTH > CSR_WIDTH) ? a[DATA_WIDTH-1: CSR_WIDTH] : '0;
			3'b100:		csr_readdata 	= b;
			3'b101:		csr_readdata  	= (DATA_WIDTH > CSR_WIDTH) ? b[DATA_WIDTH-1: CSR_WIDTH] : '0;
			3'b110:		csr_readdata 	= last_out_data;
			3'b111:		csr_readdata  	= (DATA_WIDTH > CSR_WIDTH) ? last_out_data[DATA_WIDTH-1: CSR_WIDTH] : '0;
		endcase
	else
		csr_readdata = 'x;
	
	// internal signals
	logic a_is_repeat;
	logic b_is_repeat;
	
	// derivation of internal signals from incoming signals and internal state
	always_comb begin
		a_is_repeat = ~is_first && (a_data == last_out_data);
		b_is_repeat = ~is_first && (b_data == last_out_data);
	end
	
	// state machine transition logic
	always_comb begin
		next_state = state;
		unique case(state)
		
			IDLE:			if (a_valid && ~a_loaded && ~a_closed)				next_state = READ_A;
							else if (b_valid && ~b_loaded && ~b_closed)		next_state = READ_B;

			READ_A:		if (a_endofpacket && b_closed) 						next_state = WRITE_EOP;
							else if (a_endofpacket && b_loaded)					next_state = WRITE_DATA;
							else if (~a_endofpacket && ~a_is_repeat 
											&& (b_loaded | b_closed) ) 			next_state = WRITE_DATA;		
							else															next_state = IDLE;
			
			READ_B:		if (b_endofpacket && a_closed) 						next_state = WRITE_EOP;
							else if (b_endofpacket && a_loaded)					next_state = WRITE_DATA;
							else if (~b_endofpacket && ~b_is_repeat 
											&& (a_loaded | a_closed) ) 			next_state = WRITE_DATA;		
							else															next_state = IDLE;

			WRITE_DATA,
			WRITE_EOP:	if (out_ready)												next_state = IDLE;
						
		endcase
	end
	
	// sequential logic driven by state machine
	always_ff @(posedge clock, posedge reset) begin
	
		if (reset) begin
			state 			<= IDLE;
			a 					<= '0;
			b					<= '0;
			a_loaded 		<= '0;
			b_loaded 		<= '0;
			a_closed 		<= '0;
			b_closed 		<= '0;
			is_first 		<= '1;
			last_out_data 	<= '0;
		end
		
		else begin	
		
			unique case(state)
		
				IDLE:			;

				READ_A:		begin
									a <= a_data;
									if (a_endofpacket)		a_closed <= '1;
									else if (~a_is_repeat)	a_loaded <= '1;
								end

								
				READ_B:		begin
									b <= b_data;
									if (b_endofpacket) 		b_closed <= '1;
									else if (~b_is_repeat)	b_loaded <= '1;
								end
									
				WRITE_DATA:	if (next_state == IDLE) begin
									if (a <= b || b_closed) begin
										a_loaded = '0;
										last_out_data <= a;
									end
									if (b <= a || a_closed) begin
										b_loaded = '0;
										last_out_data <= b;
									end
									is_first <= '0;
								end
			
				WRITE_EOP: 	if (next_state == IDLE) begin
									a 					<= '0;
									b					<= '0;
									a_loaded 		<= '0;
									b_loaded 		<= '0;
									a_closed 		<= '0;
									b_closed 		<= '0;
									is_first 		<= '1;
									last_out_data 	<= '0;
								end
			endcase
			
			state <= next_state;
		end
	end
	
	// derivation of module outputs from current state
	always_comb begin
		a_ready				= (state == READ_A);
		b_ready				= (state == READ_B);
		out_valid			= (state == WRITE_DATA || (state == WRITE_EOP && SEND_ENDOFPACKET));
		out_endofpacket 	= (state == WRITE_EOP && SEND_ENDOFPACKET);
		out_startofpacket = '0;

		if (state == WRITE_DATA) begin
				if (!a_loaded)											out_data = b;
				else if (!b_loaded) 									out_data = b;
				else 														out_data = (a <= b) ? a : b;
		end
		
		else if 	(state == WRITE_EOP && SEND_ENDOFPACKET) 	out_data = END_PACKET_VALUE;
		
		else 																out_data = 'x;
		
	end

endmodule
