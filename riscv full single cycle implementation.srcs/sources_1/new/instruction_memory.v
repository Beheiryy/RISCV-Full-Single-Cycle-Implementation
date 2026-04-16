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
    
    integer i;
    initial begin
        for(i = 0; i < 32; i = i + 1) begin
            instructions[i] = 0;
        end
    end

    // Test program initialization
    initial begin
    // TEST 1: Basic word store/load
//instructions[0] = 32'b00000000100000000000000010010011; 
//// addi x1, x0, 8      ? x1 = 8

//instructions[1] = 32'b00000000010100000000000100010011; 
//// addi x2, x0, 5      ? x2 = 5

//instructions[2] = 32'b00000000001000001010000000100011; 
//// sw x2, 0(x1)        ? MEM[8..11] = 5

//instructions[3] = 32'b00000000000000001010000110000011; 
//// lw x3, 0(x1)        ? x3 = 5


//// TEST 2: Byte store/load
//instructions[4] = 32'b00000000100000000000000010010011; 
//// addi x1, x0, 8      ? x1 = 8

//instructions[5] = 32'b00000000111111110000000100010011; 
//// addi x2, x0, 45    ? 45 actually no 255

//instructions[6] = 32'b00000000001000001000000100100011; 
//// sb x2, 1(x1)        ? MEM[10) because offset is doubled in store 

//instructions[7] = 32'b00000000000100001000000110000011; 
//// lb x3, 1(x1)        ? x3 takes 5 (it's already 5)


///* TEST 3: All byte offsets */
//instructions[8]  = 32'b00000000100000000000000010010011; 
//// addi x1, x0, 8      ? base = 8

//instructions[9]  = 32'b00000000000100000000000100010011; 
//// addi x2, x0, 1      ? x2 = 1
//instructions[10] = 32'b00000000001000001000000000100011; 
//// sb x2, 0(x1)        ? MEM[8] = 1

//instructions[11] = 32'b00000000001000000000000100010011; 
//// addi x2, x0, 2      ? x2 = 2
//instructions[12] = 32'b00000000001000001000000100100011; 
//// sb x2, 1(x1)        ? MEM[9] = 2

//instructions[13] = 32'b00000000001100000000000100010011; 
//// addi x2, x0, 3      ? x2 = 3
//instructions[14] = 32'b00000000001000001000001000100011; 
//// sb x2, 2(x1)        ? MEM[10] = 3

//instructions[15] = 32'b00000000010000000000000100010011; 
//// addi x2, x0, 4      ? x2 = 4
//instructions[16] = 32'b00000000001000001000001100100011; 
//// sb x2, 3(x1)        ? MEM[11] = 4

//instructions[17] = 32'b00000000000000001000001000000011; 
//// lb x4, 0(x1)        ? x4 = 1
//instructions[18] = 32'b00000000000100001000001010000011; 
//// lb x5, 1(x1)        ? x5 = 2
//instructions[19] = 32'b00000000001000001000001100000011; 
//// lb x6, 2(x1)        ? x6 = 3
//instructions[20] = 32'b00000000001100001000001110000011; 
//// lb x7, 3(x1)        ? x7 = 4

// First, let's put a "negative" value (0xFF) into memory at MEM[12]
instructions[0] = 32'b11111111111100000000000100010011; 
// addi x2, x0, -1      ? x2 = 0xFFFFFFFF
instructions[1] = 32'b00000000001000001000001000100011;
// sb x2, 8(x1)

// Test LBU (Load Byte Unsigned) - funct3 = 100
instructions[2] = 32'b00000000010000001100001110000011; 
// lbu x7, 4(x1)        ? x7 = 0x000000FF (Zero-extended)

// Test LHU (Load Halfword Unsigned) - funct3 = 101
// This loads MEM[13:12]. Let's assume MEM[13] was 0 from previous ops.
instructions[3] = 32'b00000000010000001101010000000011; 
// lhu x8, 4(x1)        ? x8 = 0x000000FF (Zero-extended halfword)

instructions[4] = 32'b00000000010000001000011010000011; 
// lb x13, 4(x1)  -> Loads MEM[12] into x13 with sign-extension

// Test LW (Load Word) from a misaligned address (Offset 1)
// We already have MEM[8]=1, MEM[9]=2, MEM[10]=3, MEM[11]=4
// A misaligned LW from 1(x1) will try to pull bytes from MEM[9, 10, 11, 12]
instructions[5] = 32'b00000000000100001010010010000011; 
// lw x9, 1(x1)         ? x9 = 0xFF040302 (If misaligned load is supported)

// Test LH (Load Halfword) from a misaligned address (Offset 3)
// This pulls from MEM[11] and MEM[12]
instructions[6] = 32'b00000000001100001001010100000011; 
// lh x10, 3(x1)        ? x10 = 0xFF04 (Sign-extended 0xFF04)

    
    end

endmodule