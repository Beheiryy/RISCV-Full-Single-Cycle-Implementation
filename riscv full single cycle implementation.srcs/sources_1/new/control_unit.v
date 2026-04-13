/******************************************************************************
 * Module: control_unit.v
 * Project: RISCV Full Single Cycle Implementation
 * Author: Omar Beheiry | omarbeheiry@aucegypt.edu
 * Description: Control unit for the RV32I processor. Decodes the opcode
 * to generate control signals for the datapath.
 *
 * Change history: 04/12/26 Refactored to follow coding guidelines.
 *****************************************************************************/

// Include global definitions for opcodes
`include "rv32i_defs.v"

module control_unit (
    input [4:0] opcode,
    output exit_program,
    output branch,
    output mem_read,
    output mem_write,
    output alu_src_1,
    output alu_src_2,
    output reg_write,
    output jump,
    output [1:0] alu_op,
    output [1:0] reg_write_src
);
    //exit program if fence, pause, ecall, or break
    assign exit_program = (opcode == `OPCODE_FENCE || opcode == `OPCODE_BREAK);

    // branch: Active if opcode bit 4 is set
    assign branch = (opcode == `OPCODE_BRANCH);

    // mem_read/mem_to_reg: Derived from opcode bit 3
    assign mem_read = (opcode == `OPCODE_LOAD);

    // mem_write: Active for Store instructions (e.g., 5'b01000)
    assign mem_write = (opcode == `OPCODE_STORE);

    // alu_src: High for I-type and Loads/Stores
    assign alu_src_1 = (opcode == `OPCODE_JAL || opcode == `OPCODE_AUIPC);
    assign alu_src_2 = (opcode == `OPCODE_STORE) || (opcode == `OPCODE_LOAD) || (opcode == `OPCODE_ARITH_I) || (opcode == `OPCODE_JAL) || (opcode == `OPCODE_JALR) || (opcode == `OPCODE_AUIPC);

    // reg_write: High if the instruction writes back to the register file
    assign reg_write =
                        (opcode == `OPCODE_ARITH_R)  ||
                        (opcode == `OPCODE_ARITH_I)  ||
                        (opcode == `OPCODE_LOAD)     ||
                        (opcode == `OPCODE_LUI)      ||
                        (opcode == `OPCODE_AUIPC)    ||
                        (opcode == `OPCODE_JAL)      ||
                        (opcode == `OPCODE_JALR);
    
    // jump
    assign jump = (opcode == `OPCODE_JAL || opcode == `OPCODE_JALR);

    // alu_op: 2nd-level control for the ALU
    assign alu_op = (opcode == `OPCODE_BRANCH) ? `ALUOP_BRANCH : // BRANCH
                    (opcode == `OPCODE_ARITH_I || opcode == `OPCODE_ARITH_R) ? `ALUOP_ARITHMATIC : // ARITHMATIC R & I
                     `ALUOP_ADD;
                    
    // reg_write_src: Source of data for the register file
    assign reg_write_src = (opcode == `OPCODE_LOAD) ? 2'b00 :
                           (opcode == `OPCODE_LUI) ? 2'b01 :
                           (opcode == `OPCODE_JAL || opcode == `OPCODE_JALR) ? 2'b10 : 2'b11;

endmodule