
module complement_base (
	input			wire					clock,
	input			wire					reset,
	input			wire					write,
	input			wire	[0:7]			in_base,
	output		wire	[0:7]			out_complement
	);
	
	reg [0:7] 	complement;
	
	always @(posedge clock) begin
	
		if (reset) begin
			complement <= 8'h02;
		end
		
		else begin
		
			if (write) begin
				case(in_base)
					"A": complement <= "T";
					"T": complement <= "A";
					"G": complement <= "C";
					"C": complement <= "G";
				endcase
			end
			
		end
		
	end
	
	assign out_complement = complement;
	
endmodule
