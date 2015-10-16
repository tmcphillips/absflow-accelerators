`include "fourbitalu.v"
`include "ripplescaler.v"
`include "buttonpressdetector.v"

module FourBitCPU( 
	input wire			step		/* synthesis loc="P31"				*/,
	input wire			reset_n		/* synthesis loc="P32"				*/,
	input wire 			oneMHzClock /* synthesis loc="P18"				*/,
	output reg	[3:0]	a_reg		/* synthesis loc="P48,P47,P46,P45"	*/,
	output reg	[3:0]	b_reg		/* synthesis loc="P4,P3,P2,P40"		*/,
	output reg 			zf			/* synthesis loc="P38"				*/,
	output reg			cf			/* synthesis loc="P39"				*/,
	output reg	[2:0] 	pc			/* synthesis loc="P26,P27,P28" 		*/
);

	`include "cpu_opcodes.v"

	wire debouncedStep;

	wire [3:0] opcode [0:7];
	wire [3:0] arg [0:7];
	
	assign opcode[3'b000] = OP_LD_A; 		assign arg[3'b000] = 4'b1010;
	assign opcode[3'b001] = OP_DEC_A;
	assign opcode[3'b010] = OP_DEC_A;
	assign opcode[3'b011] = OP_JNZ;			assign arg[3'b011] = 4'b0001;
	assign opcode[3'b100] = OP_JMP;			assign arg[3'b100] = 4'b0000;
	
	wire [3:0] alu_c;
	wire alu_zf;
	wire alu_cf;
	
	RippleScaler #(.BITS(10)) u0rs (
		.inclock(oneMHzClock),
		.outclock(oneKHzClock)
	);
	
	ButtonPressDetector u1pbd (
		.buttonDown(~step),
		.ackPress(1'b1),
		.clock(oneKHzClock),
		.wasPressed(debouncedStep)
	);
	
	FourBitALU u2alu (
		.opcode(opcode[pc]),
		.a(a_reg),
		.b(b_reg),
		.c(alu_c),
		.zf(alu_zf),
		.cf(alu_cf)
	);	
	
	reg inc_pc;

	always @(negedge reset_n, posedge debouncedStep)
	
		if (!reset_n)

			begin
				pc 		<= 	3'b000;
				a_reg 	<= 	4'b0000;
				b_reg 	<= 	4'b0000;
				zf 		<= 	1'b0;
				cf 		<= 	1'b0;
			end

		else 
	
			begin: opcodeHandler
			
				inc_pc = 1'b1;
				
				casez (opcode[pc]) // synthesis full_case

					4'b1???:		begin
										a_reg 	<= alu_c;
										zf 		<= alu_zf;
										cf 		<= alu_cf;
									end
				
					OP_JMP:			begin
										pc <= arg[pc];
										inc_pc = 1'b0;
									end
					
					OP_JZ:			if (zf)	begin
										pc <= arg[pc];
										inc_pc = 1'b0;
									end
									
					OP_JNZ:			if (!zf) begin
										pc <= arg[pc];
										inc_pc = 1'b0;
									end
						
				 	OP_LD_A:		a_reg <= arg[pc];

					OP_LD_B:		b_reg <= arg[pc];
					
				endcase

				if (inc_pc) 
					pc <= pc + 1;

			end	
endmodule

