/*******************************************************************
 * 
 * Module: immediate_generator.v
 * Project: RISC-V Full Single Cycle Implementation
 * Author: Ahmed Saad Mohammed
 * Description: RISC-V immediate generator for I-type (lw), S-type (sw), B-type (beq)
 * 
 * Change history: 04/12/26 - Renamed ports instruction/immediate and refactored
 * 
 *******************************************************************/

`timescale 1ns / 1ps
`include "rv32i_defs.v"

module immediate_generator (
    input  wire [31:0]  instruction,
    output reg  [31:0]  immediate
);

always @(*) begin
	case (instruction[`IR_opcode])
		`OPCODE_ARITH_I   : 	immediate = { {21{instruction[31]}}, instruction[30:25], instruction[24:21], instruction[20] };
		`OPCODE_STORE     :     immediate = { {21{instruction[31]}}, instruction[30:25], instruction[11:8], instruction[7] };
		`OPCODE_LUI       :     immediate = { instruction[31], instruction[30:20], instruction[19:12], 12'b0 };
		`OPCODE_AUIPC     :     immediate = { instruction[31], instruction[30:20], instruction[19:12], 12'b0 };
		`OPCODE_JAL       : 	immediate = { {12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:25], instruction[24:21], 1'b0 };
		`OPCODE_JALR      : 	immediate = { {21{instruction[31]}}, instruction[30:25], instruction[24:21], instruction[20] };
		`OPCODE_BRANCH    : 	immediate = { {20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
		default           : 	immediate = { {21{instruction[31]}}, instruction[30:25], instruction[24:21], instruction[20] }; // immediate_I
	endcase 
end

endmodule