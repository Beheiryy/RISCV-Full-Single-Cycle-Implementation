                                
// General                      
`define ZERO_32_BIT 32'h00000000

// PC
`define PC_INCREMENT 32'd4

// Immediate Generator
`define DISCRIMINANT_I_TYPE 2'b00
`define DISCRIMINANT_S_TYPE 2'b01

// rv32i_defs.v
`define OPCODE_LOAD  5'b00000
`define OPCODE_STORE 5'b01000
`define OPCODE_RTYPE 5'b01100

// ALUOp types
`define ALUOP_LOAD_STORE 2'b00
`define ALUOP_BRANCH     2'b01
`define ALUOP_RTYPE      2'b10

// ALU Control signals
`define ALU_ADD 4'b0000
`define ALU_SUB 4'b0001
`define ALU_AND 4'b0010
`define ALU_OR 4'b0011
`define ALU_XOR 4'b0100
`define ALU_SLL 4'b0101
`define ALU_SRL 4'b0110
`define ALU_SRA 4'b0111
`define ALU_SLT 4'b1000
`define ALU_SLTU 4'b1001



