/******************************************************************************
 * Module: alu_control_unit.v
 * Project: RISCV Full Single Cycle Implementation
 * Author: Omar Beheiry | omarbeheiry@aucegypt.edu
 * Description: Decodes ALUOp and instruction function bits (funct3/funct7) 
 * to generate the specific control signal for the ALU.
 *
 * Change history: 04/12/26 Refactored to follow coding guidelines.
 *****************************************************************************/

`include "rv32i_defs.v"

module alu_control_unit (
    input [1:0] alu_op,
    input [2:0] funct3,
    input funct7,
    output reg [3:0] alu_control
);

    always @(*) begin
    // Default assignment
    alu_control = `ALU_ADD; 

    case (alu_op)
        `ALUOP_LOAD_STORE: begin
            alu_control = `ALU_ADD;
        end

        `ALUOP_BRANCH: begin
            alu_control = `ALU_SUB;
        end

        `ALUOP_RTYPE: begin
            case (funct3)
                3'b000: begin
                    if (funct7[5]) alu_control = `ALU_SUB; // SUB
                    else alu_control = `ALU_ADD; // ADD
                end

                3'b111: alu_control = `ALU_AND;
                3'b110: alu_control = `ALU_OR;
                3'b100: alu_control = `ALU_XOR;

                3'b001: alu_control = `ALU_SLL;

                3'b101: begin
                    if (funct7[5]) alu_control = `ALU_SRA; // SRA
                    else alu_control = `ALU_SRL; // SRL
                end

                3'b010: alu_control = `ALU_SLT;
                3'b011: alu_control = `ALU_SLTU;

                default: alu_control = `ALU_ADD;
            endcase
        end

        default: begin
            alu_control = `ALU_ADD;
        end
    endcase
end

endmodule