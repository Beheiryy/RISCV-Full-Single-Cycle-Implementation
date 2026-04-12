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
    // Instruction input
    input wire [31:0] instruction,
    
    // Immediate output
    output reg [31:0] immediate
);

    // Opcode discriminator (bits [6:5])
    wire [1:0] discriminant;
    assign discriminant = instruction[6:5];

    // Immediate generation logic
    always @(*) begin
        case (discriminant)
            `DISCRIMINANT_I_TYPE:  immediate = {{20{instruction[31]}}, instruction[31:20]}; // I-type (lw)
            `DISCRIMINANT_S_TYPE:  immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]}; // S-type (sw)  
            default: immediate = {{20{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8]}; // B-type
        endcase
    end

endmodule