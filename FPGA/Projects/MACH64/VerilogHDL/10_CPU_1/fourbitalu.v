`ifndef FOUR_BIT_ALU
`define FOUR_BIT_ALU

module FourBitALU(
	input wire [3:0] opcode,
	input wire [3:0] a,
	input wire [3:0] b,
	output reg [3:0] c,
	output wire zf,
	output reg cf
);

	`include "cpu_opcodes.v"

	always @(opcode, a, b)
	
		begin 
			
			cf = 0;
		
			case (opcode)	// synthesis full_case
			
				OP_AND:		c = a & b;
				
				OP_OR:		c = a | b;
				
				OP_XOR:		c = a ^ b;
				
				OP_NOT_A:	c = ~a;
				
				OP_INC_A:	{cf, c[3], c[2], c[1], c[0]} = 
								{1'b0, a[3], a[2], a[1], a[0]} + 5'b00001;
				
				OP_DEC_A:	begin
								c = {1'b0, a[3], a[2], a[1], a[0]} - 5'b00001; 
								cf = (a == 0);
							end
				
				OP_SHL_A:	{cf, c[3], c[2], c[1], c[0]} = 
								{a[3], a[2], a[1], a[0], 1'b0};
				
				OP_SHR_A:	{c[3], c[2], c[1], c[0], cf} = 
								{1'b0, a[3], a[2], a[1], a[0]};
			
			endcase
		end
		
	assign zf = (c == 0);

endmodule

`endif