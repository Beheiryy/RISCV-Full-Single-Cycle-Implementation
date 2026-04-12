/*******************************************************************
 * 
 * Module: instruction_memory.v
 * Project: RISC-V Full Single Cycle Implementation
 * Author: Ahmed Saad Mohammed
 * Description: Instruction memory with 64 x 32-bit ROM
 * 
 * Change history: 04/12/26 - Refactored to follow Verilog coding guidelines
 * 
 *******************************************************************/

`timescale 1ns / 1ps

module instruction_memory (
    // Address
    input wire [5:0] address,
    
    // Instruction output
    output wire [31:0] instruction_word
);

    // Instruction ROM (64 x 32-bit)
    reg [31:0] instructions [0:63];
    
    // Read logic
    assign instruction_word = instructions[address];

    // Test program initialization
    initial begin
        instructions[0]  = 32'b000000000000_00000_010_00001_0000011;  // lw x1, 0(x0)
        instructions[1]  = 32'b000000000100_00000_010_00010_0000011;  // lw x2, 4(x0)  
        instructions[2]  = 32'b000000001000_00000_010_00011_0000011;  // lw x3, 8(x0)
        instructions[3]  = 32'b0000000_00010_00001_110_00100_0110011;  // or x4, x1, x2
        instructions[4]  = 32'b0_000000_00011_00100_000_0100_0_1100011; // beq x4, x3, 4
        instructions[5]  = 32'b0000000_00010_00001_000_00011_0110011;  // add x3, x1, x2
        instructions[6]  = 32'b0000000_00010_00011_000_00101_0110011;  // add x5, x3, x2
        instructions[7]  = 32'b0000000_00101_00000_010_01100_0100011;  // sw x5, 12(x0)
        instructions[8]  = 32'b000000001100_00000_010_00110_0000011;  // lw x6, 12(x0)
        instructions[9]  = 32'b0000000_00001_00110_111_00111_0110011;  // and x7, x6, x1
        instructions[10] = 32'b0100000_00010_00001_000_01000_0110011;  // sub x8, x1, x2
        instructions[11] = 32'b0000000_00010_00001_000_00000_0110011;  // add x0, x1, x2
        instructions[12] = 32'b0000000_00001_00000_000_01001_0110011;  // add x9, x0, x1
    end

endmodule