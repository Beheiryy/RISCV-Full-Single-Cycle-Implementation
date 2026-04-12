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
    output branch,
    output mem_read,
    output mem_to_reg,
    output mem_write,
    output alu_src,
    output reg_write,
    output [1:0] alu_op
);

    // branch: Active if opcode bit 4 is set
    assign branch = opcode[4];

    // mem_read/mem_to_reg: Derived from opcode bit 3
    assign mem_read = ~(opcode[3]);
    assign mem_to_reg = ~(opcode[3]);

    // mem_write: Active for Store instructions (e.g., 5'b01000)
    assign mem_write = (opcode == `OPCODE_STORE);

    // alu_src: High for I-type and Loads/Stores
    assign alu_src = (opcode == `OPCODE_STORE) || (opcode == `OPCODE_LOAD);

    // reg_write: High if the instruction writes back to the register file
    assign reg_write = (opcode[3:2] != 2'b10);

    // alu_op: 2nd-level control for the ALU
    assign alu_op = (opcode[2] == 1'b1) ? 2'b10 : 
                    (opcode[4] == 1'b1) ? 2'b01 : 2'b00;

endmodule