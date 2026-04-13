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
// Setup a negative number for signed vs unsigned comparisons
instructions[0]  = 32'b111111111011_00000_000_11111_0010011;  // addi x31, x0, -5 -> x31 = -5 (0xFFFFFFFB)

// (BEQ)
instructions[1]  = 32'b0000000_00010_00010_000_01000_1100011;  // beq  x2, x2, 8    -> 2 == 2 (Taken, skips instr 2)
instructions[2]  = 32'b000000000000_00000_000_01010_0010011;   // addi x10, x0, 99  -> TRAP: Skipped
instructions[3]  = 32'b0000000_00010_00001_000_01000_1100011;  // beq  x1, x2, 8    -> 1 == 2 (Not Taken)
instructions[4]  = 32'b000000000001_00000_000_01011_0010011;   // addi x11, x0, 1   -> Executed: x11 = 1

// (BNE)
instructions[5]  = 32'b0000000_00010_00001_001_01000_1100011;  // bne  x1, x2, 8    -> 1 != 2 (Taken, skips instr 6)
instructions[6]  = 32'b000000000000_00000_000_01010_0010011;   // addi x10, x0, 99  -> TRAP: Skipped
instructions[7]  = 32'b0000000_00010_00010_001_01000_1100011;  // bne  x2, x2, 8    -> 2 != 2 (Not Taken)
instructions[8]  = 32'b000000000001_00000_000_01100_0010011;   // addi x12, x0, 1   -> Executed: x12 = 1

// (BLT)
instructions[9]  = 32'b0000000_00001_11111_100_01000_1100011;  // blt  x31, x1, 8   -> -5 < 1 (Taken, skips instr 10)
instructions[10] = 32'b000000000000_00000_000_01010_0010011;   // addi x10, x0, 99  -> TRAP: Skipped
instructions[11] = 32'b0000000_00001_00010_100_01000_1100011;  // blt  x2, x1, 8    -> 2 < 1 (Not Taken)
instructions[12] = 32'b000000000001_00000_000_01101_0010011;   // addi x13, x0, 1   -> Executed: x13 = 1

// (BGE)
instructions[13] = 32'b0000000_11111_00001_101_01000_1100011;  // bge  x1, x31, 8   -> 1 >= -5 (Taken, skips instr 14)
instructions[14] = 32'b000000000000_00000_000_01010_0010011;   // addi x10, x0, 99  -> TRAP: Skipped
instructions[15] = 32'b0000000_00010_00001_101_01000_1100011;  // bge  x1, x2, 8    -> 1 >= 2 (Not Taken)
instructions[16] = 32'b000000000001_00000_000_01110_0010011;   // addi x14, x0, 1   -> Executed: x14 = 1

// (BLTU)
instructions[17] = 32'b0000000_00010_00001_110_01000_1100011;  // bltu x1, x2, 8    -> 1 < 2 (Taken, skips instr 18)
instructions[18] = 32'b000000000000_00000_000_01010_0010011;   // addi x10, x0, 99  -> TRAP: Skipped
instructions[19] = 32'b0000000_00001_11111_110_01000_1100011;  // bltu x31, x1, 8   -> unsigned -5 (0xFFFFFFFB) < 1 (Not Taken)
instructions[20] = 32'b000000000001_00000_000_01111_0010011;   // addi x15, x0, 1   -> Executed: x15 = 1

// (BGEU)
instructions[21] = 32'b0000000_00001_11111_111_01000_1100011;  // bgeu x31, x1, 8   -> unsigned -5 (0xFFFFFFFB) >= 1 (Taken, skips 22)
instructions[22] = 32'b000000000000_00000_000_01010_0010011;   // addi x10, x0, 99  -> TRAP: Skipped
instructions[23] = 32'b0000000_00010_00001_111_01000_1100011;  // bgeu x1, x2, 8    -> 1 >= 2 (Not Taken)
instructions[24] = 32'b000000000001_00000_000_10000_0010011;   // addi x16, x0, 1   -> Executed: x16 = 1
    end

endmodule