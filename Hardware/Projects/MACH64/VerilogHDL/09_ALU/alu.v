`ifndef ALU
`define ALU

module ALU(
	input wire [3:0] opcode,
	input wire [3:0] a,
	input wire [3:0] b,
	output reg [3:0] c,
	output wire zf,
	output reg cf
);

	parameter OP_AND 	= 4'b1000;
	parameter OP_OR  	= 4'b1001;
	parameter OP_XOR 	= 4'b1010;
	parameter OP_NOT_A 	= 4'b1011;
	parameter OP_INC_A 	= 4'b1100;
	parameter OP_DEC_A 	= 4'b1101;
	parameter OP_SHL_A 	= 4'b1110;
	parameter OP_SHR_A 	= 4'b1111;

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
								c = a - 5'b00001; 
								cf	= (a == 0);
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