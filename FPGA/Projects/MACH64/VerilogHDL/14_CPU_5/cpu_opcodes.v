	// opcodes == 6'b10???? for ALU operations leaving results in A
	parameter OP_AND_A_B	= 6'b101000;
	parameter OP_OR_A_B 	= 6'b101001;
	parameter OP_XOR_A_B	= 6'b101010;
	parameter OP_ADD_A_B	= 6'b101011;

	parameter OP_NOT_A 		= 6'b100011;
	parameter OP_INC_A 		= 6'b100100;
	parameter OP_DEC_A 		= 6'b100101;
	parameter OP_SHL_A 		= 6'b100110;
	parameter OP_SHR_A 		= 6'b100111;
	
	// opcodes == 6'b11???? for ALU operations leaving results in B
	parameter OP_NOT_B 		= 6'b110011;
	parameter OP_INC_B		= 6'b110100;
	parameter OP_DEC_B		= 6'b110101;
	parameter OP_SHL_B 		= 6'b110110;
	parameter OP_SHR_B 		= 6'b110111;

	// opcodes = 6'01???? for jump operations
	parameter OP_JMP 		= 6'b010000;
	parameter OP_JZ			= 6'b010001;
	parameter OP_JNZ		= 6'b010010;
	parameter OP_JC			= 6'b010011;
	parameter OP_JNC		= 6'b010100;

	// opcodes = 6'00???? for register operations
	parameter OP_NOP		= 6'b000000;
	parameter OP_LD_A 		= 6'b000001;
	parameter OP_LD_B 		= 6'b000010;