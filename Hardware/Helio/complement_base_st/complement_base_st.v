
module complement_base_st (

	input		wire					clock,
	input		wire					reset,
	
	output 	reg					in_ready,
	input		wire					in_valid,
	input		wire	[0:7]			in_data,
	
	input		wire					out_ready,
	output	reg					out_valid,
	output	wire	[0:7]			out_data
);

	
	always @(posedge clock, posedge reset) begin
	
		if (reset) begin
			out_valid 	<= 1'b0;
			in_ready 	<= 1'b1;
		end
		
		else begin
		
			case(out_valid)
			
				1'b0:		if (in_valid) begin 
								in_ready <= 1'b0;
								out_valid <= 1'b1;
							end
				
				1'b1:		if (out_ready) begin
								in_ready <= 1'b1;
								out_valid <= 1'b0;
							end
			endcase
			
		end
		
	end
	
	wire in_write = in_ready & in_valid;

	complement_base complement_base_0 (
		.clock						(clock),
		.reset						(reset),
		.write						(in_write),
		.in_base						(in_data),
		.out_complement			(out_data)
	);	

endmodule
