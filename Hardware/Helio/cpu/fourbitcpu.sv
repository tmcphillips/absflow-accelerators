//`include "cpu_opcodes.sv"

module four_bit_cpu #(parameter DATA_W = 4)
(
	input logic 						clock,
	input logic							reset,
	output logic	[DATA_W-1:0]	a_reg,
	output logic	[DATA_W-1:0]	b_reg,
	output logic 	[DATA_W-1:0]	c_reg,
	output logic 						zf,
	output logic						cf,
	output logic	[DATA_W-1:0] 	pc
);

	logic [DATA_W-1:0] 	alu_r;
	logic 					alu_zf;
	logic 					alu_cf;

	logic [9:0] 	microcode [0:10];
	
	assign microcode[0]  =	{ OP_LD_A, 		4'b0100 };
	assign microcode[1]  =  { OP_LD_C, 		4'b0011 };
	assign microcode[2]  =  { OP_DEC_C,		4'bxxxx };
	assign microcode[3]  =  { OP_JNC,		4'b0110 };
	assign microcode[4]  =  { OP_LD_A,		4'b0000 };
	assign microcode[5]  =  { OP_JMP,		4'b1010 };
	assign microcode[6]  =  { OP_LD_B_A,	4'bxxxx };
	assign microcode[7]  =  { OP_ADD_A_B,	4'b0011 };
	assign microcode[8]  =  { OP_DEC_C,		4'bxxxx };
	assign microcode[9]  =  { OP_JNZ,		4'b0111 };
	assign microcode[10] =  { OP_JMP,		4'b1010 };
	
	wire [9:0] statement = microcode[pc];
	wire [5:0] opcode 	= statement[9:4];
	wire [DATA_W-1:0] arg  		= statement[DATA_W-1:0];
	
	reg [DATA_W-1:0] a_or_b_or_c_reg;
	
	always_comb
		unique casez (opcode[5:3])
			3'b10?:		a_or_b_or_c_reg = a_reg;
			3'b110:		a_or_b_or_c_reg = b_reg;
			3'b111:		a_or_b_or_c_reg = c_reg;
		endcase
	
	FourBitALU #(.DATA_W(DATA_W)) u2alu 
	(
		.opcode(opcode),
		.a(a_or_b_or_c_reg),
		.b(b_reg),
		.r(alu_r),
		.zf(alu_zf),
		.cf(alu_cf)
	);	
	
	logic inc_pc;

	always_ff @(posedge clock, posedge reset)
	
		if (reset)

			begin
				pc 		<= 	'0;
				a_reg 	<= 	'0;
				b_reg 	<= 	'0;
				c_reg		<= 	'0;
				zf 		<= 	'0;
				cf 		<= 	'0;
			end

		else 
	
			begin: opcode_handler
			
				inc_pc = '1;
				
				unique casez (opcode)

					6'b10????:	begin
										a_reg 	<= alu_r;
										zf 		<= alu_zf;
										cf 		<= alu_cf;
									end

					6'b110???:	begin
										b_reg 	<= alu_r;
										zf 		<= alu_zf;
										cf 		<= alu_cf;
									end

					6'b111???:	begin
										c_reg 	<= alu_r;
										zf 		<= alu_zf;
										cf 		<= alu_cf;
									end
				
					OP_JMP:		begin
										pc <= arg;
										inc_pc = '0;
									end
					
					OP_JZ:		if (zf) begin
										pc <= arg;
										inc_pc = '0;
									end
									
					OP_JNZ:		if (!zf) begin
										pc <= arg;
										inc_pc = '0;
									end

					OP_JC:		if (cf) begin
										pc <= arg;
										inc_pc = '0;
									end
									
					OP_JNC:		if (!cf) begin
										pc <= arg;
										inc_pc = '0;
									end
									
				 	OP_LD_A:			a_reg <= arg;

					OP_LD_B:			b_reg <= arg;
					
					OP_LD_C:			c_reg <= arg;

					OP_LD_A_B:		a_reg <= b_reg;
					
					OP_LD_B_A:		b_reg <= a_reg;
					
					OP_LD_C_A:		c_reg <= a_reg;

					OP_LD_A_C:		a_reg <= c_reg;

					OP_LD_C_B:		c_reg <= b_reg;

					OP_LD_B_C:		b_reg <= c_reg;

				endcase

				if (inc_pc) 
					pc <= pc + 1;

			end: opcode_handler
endmodule

