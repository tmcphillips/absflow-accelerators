	// opcodes == 4'b1??? for ALU operations
	parameter OP_AND_A_B	= 4'b1000;
	parameter OP_OR_A_B 	= 4'b1001;
	parameter OP_XOR_A_B	= 4'b1010;
	parameter OP_NOT_A 		= 4'b1011;
	parameter OP_INC_A 		= 4'b1100;
	parameter OP_DEC_A 		= 4'b1101;
	parameter OP_SHL_A 		= 4'b1110;
	parameter OP_SHR_A 		= 4'b1111;

	// opcodes = 4'01?? for jump operations
	parameter OP_JMP 		= 4'b0100;
	parameter OP_JZ			= 4'b0101;
	parameter OP_JNZ		= 4'b0110;

	// opcodes = 4'00?? for register operations
	parameter OP_NOP		= 4'b0000;
	parameter OP_LD_A 		= 4'b0001;
	parameter OP_LD_B 		= 4'b0010;