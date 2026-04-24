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
        data[0]  = 32'b0000000_00000_00000_000_00000_0110011 ; // add x0, x0, x0
        data[1]  = 32'b000010000000_00000_010_00001_0000011 ; // lw x1, 128(x0)
        data[2]  = 32'b000010000100_00000_010_00010_0000011 ; // lw x2, 132(x0)
        data[3]  = 32'b000010001000_00000_010_00011_0000011 ; // lw x3, 136(x0)
        data[4]  = 32'b0000000_00010_00001_110_00100_0110011 ; // or x4, x1, x2
        data[5]  = 32'b0_000000_00011_00100_000_0100_0_1100011; // beq x4, x3, 16
        data[6]  = 32'b0000000_00010_00001_000_00011_0110011 ; // add x3, x1, x2
        data[7]  = 32'b0000000_00010_00011_000_00101_0110011 ; // add x5, x3, x2
        data[8] = 32'b0000100_00101_00000_010_01100_0100011 ; // sw x5, 140(x0)
        data[9] = 32'b000010001100_00000_010_00110_0000011 ; // lw x6, 140(x0)
        data[10] = 32'b0000000_00001_00110_111_00111_0110011 ; // and x7, x6, x1
        data[11] = 32'b0100000_00010_00001_000_01000_0110011 ; // sub x8, x1, x2
        data[12] = 32'b0000000_00010_00001_000_00000_0110011 ; // add x0, x1, x2
        data[13] = 32'b0000000_00001_00000_000_01001_0110011 ; // add x9, x0, x1

        // data section (unchanged)
        data[32] = 32'd17;
        data[33] = 32'd9;
        data[34] = 32'd25;
    end

    // Write logic
    always @(negedge clk) begin
        if (mem_write) begin
            data[address] <= write_data;
        end
    end
endmodule
