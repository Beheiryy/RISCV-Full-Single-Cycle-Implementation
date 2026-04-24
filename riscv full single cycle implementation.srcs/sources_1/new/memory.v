`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2026 04:36:58 PM
// Design Name: 
// Module Name: memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "rv32i_defs.v"
module memory(
// Clocks
    input wire clk,
    
    // Control signals
    input wire mem_read,
    input wire mem_write,    
   
    // Address
    input wire [5:0] address,
    
    // Data
    input wire [31:0] write_data,
    output wire [31:0] read_data
); 

    // Data RAM (64 x 32-bit)
    reg [31:0] data [0:63];
    assign read_data = mem_read ? data[address] : `ZERO_32_BIT;
    
    integer i;
    initial begin
        for(i = 0; i < 64; i = i + 1) begin
            data[i] = 0;
        end
    end
    
    // Test data initialization 
    initial begin
// Setup a negative number for signed vs unsigned comparisons
data[0]  = 32'b111111111011_00000_000_11111_0010011;  // addi x31, x0, -5 -> x31 = -5 (0xFFFFFFFB)

// (BEQ)
data[1]  = 32'b0000000_00010_00010_000_01000_1100011;  // beq  x2, x2, 8    -> 2 == 2 (Taken, skips instr 2)
data[2]  = 32'b000000000000_00000_000_01010_0010011;   // addi x10, x0, 99  -> TRAP: Skipped
data[3]  = 32'b0000000_00010_00001_000_01000_1100011;  // beq  x1, x2, 8    -> 1 == 2 (Not Taken)
data[4]  = 32'b000000000001_00000_000_01011_0010011;   // addi x11, x0, 1   -> Executed: x11 = 1

// (BNE)
data[5]  = 32'b0000000_00010_00001_001_01000_1100011;  // bne  x1, x2, 8    -> 1 != 2 (Taken, skips instr 6)
data[6]  = 32'b000000000000_00000_000_01010_0010011;   // addi x10, x0, 99  -> TRAP: Skipped
data[7]  = 32'b0000000_00010_00010_001_01000_1100011;  // bne  x2, x2, 8    -> 2 != 2 (Not Taken)
data[8]  = 32'b000000000001_00000_000_01100_0010011;   // addi x12, x0, 1   -> Executed: x12 = 1

// (BLT)
data[9]  = 32'b0000000_00001_11111_100_01000_1100011;  // blt  x31, x1, 8   -> -5 < 1 (Taken, skips instr 10)
data[10] = 32'b000000000000_00000_000_01010_0010011;   // addi x10, x0, 99  -> TRAP: Skipped
data[11] = 32'b0000000_00001_00010_100_01000_1100011;  // blt  x2, x1, 8    -> 2 < 1 (Not Taken)
data[12] = 32'b000000000001_00000_000_01101_0010011;   // addi x13, x0, 1   -> Executed: x13 = 1

// (BGE)
data[13] = 32'b0000000_11111_00001_101_01000_1100011;  // bge  x1, x31, 8   -> 1 >= -5 (Taken, skips instr 14)
data[14] = 32'b000000000000_00000_000_01010_0010011;   // addi x10, x0, 99  -> TRAP: Skipped
data[15] = 32'b0000000_00010_00001_101_01000_1100011;  // bge  x1, x2, 8    -> 1 >= 2 (Not Taken)
data[16] = 32'b000000000001_00000_000_01110_0010011;   // addi x14, x0, 1   -> Executed: x14 = 1

// (BLTU)
data[17] = 32'b0000000_00010_00001_110_01000_1100011;  // bltu x1, x2, 8    -> 1 < 2 (Taken, skips instr 18)
data[18] = 32'b000000000000_00000_000_01010_0010011;   // addi x10, x0, 99  -> TRAP: Skipped
data[19] = 32'b0000000_00001_11111_110_01000_1100011;  // bltu x31, x1, 8   -> unsigned -5 (0xFFFFFFFB) < 1 (Not Taken)
data[20] = 32'b000000000001_00000_000_01111_0010011;   // addi x15, x0, 1   -> Executed: x15 = 1

// (BGEU)
data[21] = 32'b0000000_00001_11111_111_01000_1100011;  // bgeu x31, x1, 8   -> unsigned -5 (0xFFFFFFFB) >= 1 (Taken, skips 22)
data[22] = 32'b000000000000_00000_000_01010_0010011;   // addi x10, x0, 99  -> TRAP: Skipped
data[23] = 32'b0000000_00010_00001_111_01000_1100011;  // bgeu x1, x2, 8    -> 1 >= 2 (Not Taken)
data[24] = 32'b000000000001_00000_000_10000_0010011;   // addi x16, x0, 1   -> Executed: x16 = 1
    end

    // Write logic
    always @(negedge clk) begin
        if (mem_write) begin
            data[address] <= write_data;
        end
    end
endmodule
