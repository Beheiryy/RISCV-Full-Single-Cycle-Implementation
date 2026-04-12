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

    // Combinational logic for ALU control signal generation
    always @(*) begin
        // Default assignment to avoid latches
        alu_control = `ALU_ADD; 

        case (alu_op)
            `ALUOP_LOAD_STORE: begin
                alu_control = `ALU_ADD;
            end

            `ALUOP_BRANCH: begin
                alu_control = `ALU_SUB;
            end

            `ALUOP_RTYPE: begin
                case (funct7)
                    1'b1: begin
                        alu_control = `ALU_SUB;
                    end
                    
                    1'b0: begin
                        if (funct3 == 3'b000) begin
                            alu_control = `ALU_ADD;
                        end
                        else if (funct3 == 3'b111) begin
                            alu_control = `ALU_AND;
                        end
                        else begin
                            alu_control = `ALU_OR;
                        end
                    end

                    default: begin
                        alu_control = `ALU_ADD;
                    end
                endcase
            end

            default: begin
                alu_control = `ALU_ADD;
            end
        endcase
    end

endmodule