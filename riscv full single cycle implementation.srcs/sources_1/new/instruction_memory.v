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

        // (SW, LW, BEQ)
        instructions[0]  = 32'b0000000_00100_00000_010_00000_0100011;  // sw   x4, 0(x0)     -> Mem[0] = 4
        instructions[1]  = 32'b000000000000_00000_010_00101_0000011;   // lw   x5, 0(x0)     -> x5 = Mem[0] = 4
        instructions[2]  = 32'b0000000_00100_00101_000_01000_1100011;  // beq  x5, x4, 8     -> 4 == 4 (True). PC = PC + 8 (Skips instr 3)
        
        instructions[3]  = 32'b111111111111_00000_000_00101_0010011;   // addi x5, x0, -1    -> Skipped! x5 remains 4.
        
        // (ADD, SUB)
        instructions[4]  = 32'b0000000_00010_00001_000_00110_0110011;  // add  x6, x1, x2    -> 1 + 2 = 3
        instructions[5]  = 32'b0100000_00110_00101_000_00111_0110011;  // sub  x7, x5, x6    -> 4 - 3 = 1
        
        // (OR, AND, XOR)
        instructions[6]  = 32'b0000000_00111_00110_110_01000_0110011;  // or   x8, x6, x7    -> 3 | 1 = 3 (0011 | 0001 = 0011)
        instructions[7]  = 32'b0000000_00111_00110_111_01001_0110011;  // and  x9, x6, x7    -> 3 & 1 = 1 (0011 & 0001 = 0001)
        instructions[8]  = 32'b0000000_01001_01000_100_01010_0110011;  // xor  x10, x8, x9   -> 3 ^ 1 = 2 (0011 ^ 0001 = 0010)
        
        // (ADDI, XORI, ORI, ANDI)
        instructions[9]  = 32'b111111111011_01010_000_01011_0010011;   // addi x11, x10, -5  -> 2 - 5 = -3 (0xFFFFFFFD)
        instructions[10] = 32'b000000000011_01011_100_01100_0010011;   // xori x12, x11, 3   -> -3 ^ 3 = -2 (0xFFFFFFFE)
        instructions[11] = 32'b000000000001_01100_110_01101_0010011;   // ori  x13, x12, 1   -> -2 | 1 = -1 (0xFFFFFFFF)
        instructions[12] = 32'b000000001111_01101_111_01110_0010011;   // andi x14, x13, 15  -> -1 & 15 = 15 (0xF)
        
        // (SLL, SLLI, SRL, SRLI)
        instructions[13] = 32'b0000000_00010_01110_001_01111_0110011;  // sll  x15, x14, x2  -> 15 << 2 = 60
        instructions[14] = 32'b0000000_00001_01111_001_10000_0010011;  // slli x16, x15, 1   -> 60 << 1 = 120
        instructions[15] = 32'b0000000_00010_10000_101_10001_0110011;  // srl  x17, x16, x2  -> 120 >> 2 = 30
        instructions[16] = 32'b0000000_00001_10001_101_10010_0010011;  // srli x18, x17, 1   -> 30 >> 1 = 15
        
        // (SRAI, SRA)
        instructions[17] = 32'b0100000_00001_01011_101_10011_0010011;  // srai x19, x11, 1   -> -3 >>> 1 = -2 
                                                                       // (0xFFFFFFFD >>> 1 = 0xFFFFFFFE)
        instructions[18] = 32'b0100000_00001_10011_101_10100_0110011;  // sra  x20, x19, x1  -> -2 >>> 1 = -1 
                                                                       // (0xFFFFFFFE >>> 1 = 0xFFFFFFFF)
        
        // (SLT, SLTU, SLTI, SLTIU)
        instructions[19] = 32'b0000000_00001_10100_010_10101_0110011;  // slt  x21, x20, x1  -> -1 < 1 = 1
        instructions[20] = 32'b0000000_00001_10100_011_10110_0110011;  // sltu x22, x20, x1  -> unsigned(-1) < 1 = 0 
                                                                       // (unsigned -1 is heavily > 1)
        instructions[21] = 32'b000000001010_00010_010_10111_0010011;   // slti x23, x2, 10   -> 2 < 10 = 1
        instructions[22] = 32'b000000000101_10100_011_11000_0010011;   // sltiu x24, x20, 5  -> unsigned(-1) < 5 = 0
            
    end

endmodule