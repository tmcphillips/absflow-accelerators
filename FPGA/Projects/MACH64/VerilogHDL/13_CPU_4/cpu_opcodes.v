	// opcodes == 5'b10??? for ALU operations leaving results in A
	parameter OP_AND_A_B	= 5'b10000;
	parameter OP_OR_A_B 	= 5'b10001;
	parameter OP_XOR_A_B	= 5'b10010;
	parameter OP_NOT_A 		= 5'b10011;
	parameter OP_INC_A 		= 5'b10100;
	parameter OP_DEC_A 		= 5'b10101;
	parameter OP_SHL_A 		= 5'b10110;
	parameter OP_SHR_A 		= 5'b10111;
	
	// opcodes == 5'b11??? for ALU operations leaving results in B
	parameter OP_NOT_B 		= 5'b11011;
	parameter OP_INC_B		= 5'b11100;
	parameter OP_DEC_B		= 5'b11101;
	parameter OP_SHL_B 		= 5'b11110;
	parameter OP_SHR_B 		= 5'b11111;

	// opcodes = 5'01??? for jump operations
	parameter OP_JMP 		= 5'b01000;
	parameter OP_JZ			= 5'b01001;
	parameter OP_JNZ		= 5'b01010;
	parameter OP_JC			= 5'b01011;
	parameter OP_JNC		= 5'b01100;

	// opcodes = 5'00?? for register operations
	parameter OP_NOP		= 5'b00000;
	parameter OP_LD_A 		= 5'b00001;
	parameter OP_LD_B 		= 5'b00010;