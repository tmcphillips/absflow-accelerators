`include "fourbitalu.v"
`include "ripplescaler.v"
`include "buttonpressdetector.v"

module FourBitCPU( 
	input wire [3:0] 	opcode_n	/* synthesis loc="P10,P9,P8,P7" 	*/,
	input wire [3:0] 	data_n		/* synthesis loc="P24,P26,P27,P28" 	*/,
	input wire			step		/* synthesis loc="P31"				*/,
	input wire 			oneMHzClock /* synthesis loc="P18"				*/,
	output reg	[3:0]	a_reg		/* synthesis loc="P48,P47,P46,P45"	*/,
	output reg	[3:0]	b_reg		/* synthesis loc="P4,P3,P2,P40"		*/,
	output reg 			zf			/* synthesis loc="P38"				*/,
	output reg			cf			/* synthesis loc="P39"				*/
);

	`include "cpu_opcodes.v"

	wire debouncedStep;
	wire [3:0] opcode = ~opcode_n;
	wire [3:0] data = ~data_n;
	
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
		.opcode(opcode),
		.a(a_reg),
		.b(b_reg),
		.c(alu_c),
		.zf(alu_zf),
		.cf(alu_cf)
	);

	always @(posedge debouncedStep)
	
		casez (opcode)

			4'b1???:		begin
								a_reg 	<= alu_c;
								zf 		<= alu_zf;
								cf 		<= alu_cf;
							end
		
			OP_LDA:			a_reg <= data;

			OP_LDB:			b_reg <= data;
			
		endcase
	
endmodule

