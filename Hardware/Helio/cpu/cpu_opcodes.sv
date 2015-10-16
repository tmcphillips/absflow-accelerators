	
	parameter DATA_W = 4;
	
	enum logic [2:0] {
		CPU_LD		= 	3'b000,
		CPU_JMP		=	3'b001

		CPU_ALU_C	=	3'b100
		CPU_ALU_A	=	3'b101,
		CPU_ALU_B	=	3'b110,
		CPU_ALU_A_B	=	3'b111
		
	} cpu_op_t;
	
	enum logic [3:0] {
		ALU_SHR 		= 	4'b0000,
		ALU_SHL 		= 	4'b0001,
		ALU_DEC 		= 	4'b0010,
		ALU_INC 		= 	4'b0011,
		ALU_AND 		= 	4'b0100,
		ALU_OR  		= 	4'b0101,
		ALU_XOR 		= 	4'b0110,
		ALU_NOT 		= 	4'b0111,
		ALU_CMP		= 	4'b1000,
		ALU_ADD 		= 	4'b1001,
		ALU_SUB		= 	4'b1010,
		ALU_TST 		= 	4'b1011
	} alu_op_t;


	enum logic [3:0] {
		CPU_REG_A,
		CPU_REG_B
	} cpu_op_ext_t;
	
	typedef union packed {
		alu_op_t 		alu_op,
		cpu_op_ext_t	cpu_ext
	} op_ext_t;
	
	typedef struct packed {
		cpu_op_t			op,
		op_ext_t			op_ext
	} opcode_t;

	typedef struct packed {
		opcode_t					opcode,
		logic [DATA_W-1:0] 	arg
	} instruction_t;

	enum opcode_t {
		OP_AND_A_B		= { CPU_ALU_A_B, 	ALU_AND 	},
		OP_OR_A_B		= { CPU_ALU_A_B, 	ALU_OR 	},
		OP_XOR_A_B		= { CPU_ALU_A_B,	ALU_XOR	},
		OP_CMP_A_B		= { CPU_ALU_A_B,	ALU_CMP	},
		OP_ADD_A_B		= { CPU_ALU_A_B,	ALU_ADD	},
		OP_SUB_A_B		= { CPU_ALU_A_B,	ALU_SUB	},

		OP_NOT_A			= { CPU_ALU_A,		ALU_NOT 	},
		OP_INC_A			= { CPU_ALU_A,		ALU_INC 	},
		OP_DEC_A			= { CPU_ALU_A,		ALU_DEC 	},
		OP_SHL_A			= { CPU_ALU_A,		ALU_SHL 	},
		OP_SHR_A			= { CPU_ALU_A,		ALU_SHR 	},
		OP_TST_A			= { CPU_ALU_A,		ALU_TST 	},
		
		OP_NOT_B			= { CPU_ALU_B,		ALU_NOT 	},
		OP_INC_B			= { CPU_ALU_B,		ALU_INC 	},
		OP_DEC_B			= { CPU_ALU_B,		ALU_DEC 	},
		OP_SHL_B			= { CPU_ALU_B,		ALU_SHL 	},
		OP_SHR_B			= { CPU_ALU_B,		ALU_SHR 	},
		OP_TST_B			= { CPU_ALU_B,		ALU_TST 	},
		
		OP_NOT_C			= { CPU_ALU_C,		ALU_NOT 	},
		OP_INC_C			= { CPU_ALU_C,		ALU_INC 	},
		OP_DEC_C			= { CPU_ALU_C,		ALU_DEC 	},
		OP_SHL_C			= { CPU_ALU_C,		ALU_SHL 	},
		OP_SHR_C			= { CPU_ALU_C,		ALU_SHR 	},
		OP_TST_C			= { CPU_ALU_C,		ALU_TST 	},
		
		OP_PUSH_A,
		OP_PUSH_B,
		OP_PUSH_C,
		OP_POP_A,
		OP_POP_B,
		OP_POP_C,
		
		OP_JMP_
		
	} opcodes;
	

	
	
	// opcodes == 6'b100??? for double argument ALU operations leaving results in A
	parameter OP_AND_A_B		=	6'b100000;
	parameter OP_OR_A_B 		= 	6'b100001;
	parameter OP_XOR_A_B		= 	6'b100010;
	parameter OP_ADD_A_B		= 	6'b100011;

	// opcodes == 6'b101??? for single argument ALU operations leaving results in A
	parameter OP_NOT_A 		= 	6'b101000;
	parameter OP_INC_A 		= 	6'b101001;
	parameter OP_DEC_A 		= 	6'b101010;
	parameter OP_SHL_A 		= 	6'b101011;
	parameter OP_SHR_A 		= 	6'b101100;
	parameter OP_TST_A 		= 	6'b101101;
	
	// opcodes == 6'b110??? for single argument ALU operations operating on B
	parameter OP_NOT_B 		= 	6'b110000;
	parameter OP_INC_B		=	6'b110001;
	parameter OP_DEC_B		= 	6'b110010;
	parameter OP_SHL_B 		= 	6'b110011;
	parameter OP_SHR_B 		= 	6'b110100;
	parameter OP_TST_B		= 	6'b110101;

	// opcodes == 6'b111??? for single argument ALU operations operating on C
	parameter OP_NOT_C 		= 	6'b111000;
	parameter OP_INC_C		= 	6'b111001;
	parameter OP_DEC_C		= 	6'b111010;
	parameter OP_SHL_C 		= 	6'b111011;
	parameter OP_SHR_C 		= 	6'b111100;
	parameter OP_TST_C		= 	6'b111101;

	// opcodes = 6'01???? for jump operations
	parameter OP_JMP 			= 	6'b010000;
	parameter OP_JZ			= 	6'b010001;
	parameter OP_JNZ			= 	6'b010010;
	parameter OP_JC			= 	6'b010011;
	parameter OP_JNC			= 	6'b010100;

	// opcodes = 6'00???? for register operations
	parameter OP_NOP			= 6'b000000;
	parameter OP_LD_A 		= 6'b000001;
	parameter OP_LD_B 		= 6'b000010;
	parameter OP_LD_C 		= 6'b001011;
	parameter OP_LD_A_B		= 6'b000011;
	parameter OP_LD_B_A		= 6'b000100;
	parameter OP_LD_C_A		= 6'b000101;
	parameter OP_LD_A_C		= 6'b000110;
	parameter OP_LD_B_C		= 6'b000111;
	parameter OP_LD_C_B		= 6'b001000;
	