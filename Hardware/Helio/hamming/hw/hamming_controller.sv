module hamming_controller
# (parameter WIDTH					= 8	// Width of data input stream, output stream, and initial value.
)	
(
	input		logic							clock,
	input    logic							reset,

	input		logic							out_ready,
	output	logic							out_valid,
	output	logic							out_startofpacket,
	output	logic							out_endofpacket,
	output	logic		[WIDTH-1:0]		out_data,

	input		logic							csr_address,
	input		logic							csr_read,
	input		logic							csr_write,
	output	logic		[WIDTH-1:0]		csr_readdata,
	input		logic		[WIDTH-1:0]		csr_writedata,
	
	input	logic								busy
);

	/**************************************************************************/
	/*                        cutoff value r/w logic                          */
	/**************************************************************************/
	
	logic [WIDTH-1:0] initial_value;
	logic 				start_signal;
	
	// one-hot declaration of state machine states
	enum logic [3:0] { 
		IDLE		= 4'b0001,
		STARTING	= 4'b0010,
		RUNNING 	= 4'b0100,
		BUSY 		= 4'b1000
	} state, next_state;
	
	assign start_signal 			= csr_write & ~csr_address & csr_writedata[0];
		
	// logic for resetting and writing values to cutoff
	always_ff @(posedge clock, posedge reset)
		if (reset) begin
			initial_value <= 1'b1;
		end
		else begin
			if (csr_write & csr_address) initial_value <= csr_writedata;
		end
		
	always_comb 
		if (csr_read)
			unique case(csr_address)
				1'b0:		csr_readdata 	= { {28{1'b0}}, state };
				1'b1:		csr_readdata 	= initial_value;
			endcase
		else
			csr_readdata = 'x;
	
	// state machine transition logic
	always_comb begin
		next_state = state;
		unique case(state)
			IDLE:			if (start_signal)	next_state = STARTING;
			STARTING: 	if (out_ready)		next_state = RUNNING;
			RUNNING:		if (busy)			next_state = BUSY;
			BUSY:			if (~busy)			next_state = IDLE;
			default:								next_state = IDLE;
		endcase
	end
	
	// sequential logic driven by state machine
	always_ff @(posedge clock, posedge reset)
		if (reset)
 			state	<= IDLE;
		else
			state	<= next_state;

	// derivation of output control signals from current state
	assign out_valid 				= (state == STARTING);
	assign out_data 				= out_valid ? initial_value : 'x;
	assign out_startofpacket 	= out_valid ? '0 : 'x;
	assign out_endofpacket 		= out_valid ? '0 : 'x;
	
endmodule