`include "alu.v"

module ALU_Demo( 
	input wire [3:0] 	opcode_n	/* synthesis loc="P10,P9,P8,P7" 	*/,
	input wire [3:0] 	a_n			/* synthesis loc="P24,P26,P27,P28" 	*/,
	input wire [3:0] 	b_n			/* synthesis loc="P20,P21,P22,P23"	*/,
	output wire [3:0] 	c			/* synthesis loc="P34,P33,P32,P31"	*/,
	output wire 		zf			/* synthesis loc="P38"				*/,
	output wire			cf			/* synthesis loc="P39"				*/,
	output wire	[3:0]	a_led		/* synthesis loc="P48,P47,P46,P45"	*/,
	output wire	[3:0]	b_led		/* synthesis loc="P4,P3,P2,P40"		*/
);

	ALU u0alu (
		.opcode(~opcode_n),
		.a(~a_n),
		.b(~b_n),
		.c(c),
		.zf(zf),
		.cf(cf)
	);

	assign a_led = ~a_n;
	assign b_led = ~b_n;
	
endmodule

