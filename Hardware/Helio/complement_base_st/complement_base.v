
module complement_base (
	input			wire					clock,
	input			wire					reset,
	input			wire					write,
	input			wire	[0:7]			in_base,
	output		reg	[0:7]			out_complement
	);
	
	reg [0:7] 	complement;
	
	always @(posedge clock, posedge reset) begin
	
		if (reset) begin
			out_complement <= 8'h1F;
		end
		
		else begin
		
			if (write) begin
				case(in_base)
					"A": 		out_complement <= "T";
					"T": 		out_complement <= "A";
					"G": 		out_complement <= "C";
					"C": 		out_complement <= "G";
					default: out_complement <= 8'hF1;
				endcase
			end
			
		end
		
	end
	
endmodule
