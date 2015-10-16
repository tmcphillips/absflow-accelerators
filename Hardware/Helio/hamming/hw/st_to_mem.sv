module st_to_mem
# (
	parameter IN_WIDTH			= 32,
	parameter WRITE_WIDTH		= 256,
	parameter ADDRESS_WIDTH		= 32,
	parameter COUNT_WIDTH 		= 3
) (
	input		logic									clock,
	input    logic									reset,

	output	logic									in_ready,
	input		logic									in_valid,
	input		logic		[IN_WIDTH-1:0]			in_data,
	input		logic									in_sop,
	input		logic									in_eop,
	
	output	logic									out_write,
	output	logic		[ADDRESS_WIDTH-1:0]	out_address,
	input 	logic									out_waitrequest,
	output	logic		[WRITE_WIDTH-1:0]		out_writedata,
	
	input 	logic									csr_write,
	input		logic		[ADDRESS_WIDTH-1:0]	csr_writedata
);
	localparam SYMBOLS_PER_WRITE = WRITE_WIDTH / IN_WIDTH;

	
	logic 	[COUNT_WIDTH-1:0] 	count;
	logic 	[IN_WIDTH-1:0] 		out_buffer[SYMBOLS_PER_WRITE];
	logic 	[ADDRESS_WIDTH-1:0]	address_base;
	logic		[ADDRESS_WIDTH-1:0]	address_offset;
	logic 	[WRITE_WIDTH-1:0] 	mem_buffer;
	
	// one-hot declaration of state machine states
	enum logic [1:0] { 
		IN_READY		= 2'b01,
		OUT_WRITE	= 2'b10
	} state, next_state;

	always_ff @(posedge clock, posedge reset)
		if (reset) begin
			address_base <= '0;
		end
		else begin
			if (csr_write) address_base <= csr_writedata;
		end
	
	always_comb begin
		next_state = state;
		unique case(state)
			IN_READY:	if (in_valid && 
									(count == SYMBOLS_PER_WRITE - 1 || in_eop)) 
									next_state = OUT_WRITE;
			OUT_WRITE: 	if (!out_waitrequest)	next_state = IN_READY;
			default:		next_state = IN_READY;
		endcase
	end	

	// sequential logic driven by state machine
	always_ff @(posedge clock, posedge reset)
		if (reset) begin
 			state				<= IN_READY;
			//out_buffer		<= '0;
			count 			<= '0;
			address_offset <= '0;
		end
		else begin
			unique case(state)

				IN_READY:	if (in_valid) begin
									out_buffer[count] <= in_data;
									if (count < SYMBOLS_PER_WRITE - 1)
										count <= count + 1;
									else begin
										count <= 0;
									end
								end
										
				OUT_WRITE:	if (next_state == IN_READY) begin
									address_offset <= address_offset + WRITE_WIDTH;
									//out_buffer <= '0; 
								end
			endcase			
			state	<= next_state;
		end

	// compose memory buffer from output buffer memory elements	
	always_comb begin
		integer i;
		for (i = 0; i < SYMBOLS_PER_WRITE; i = i + 1) begin
			mem_buffer[ ((i+1) * IN_WIDTH - 1) -: IN_WIDTH] = out_buffer[i];
		end
	end
		
	// derivation of output control signals from current state
	assign in_ready 		= (state == IN_READY);
	assign out_write 		= (state == OUT_WRITE);
	assign out_address 	= out_write ? (address_offset + address_base) : 'x;
	assign out_writedata	= out_write ? mem_buffer : 'x;
		
endmodule