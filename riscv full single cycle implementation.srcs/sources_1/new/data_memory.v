/*******************************************************************
 * 
 * Module: data_memory.v
 * Project: RISC-V Full Single Cycle Implementation
 * Author: Ahmed Saad Mohammed
 * Description: Data memory with 64 x 32-bit RAM
 * 
 * Change history: 04/12/26 - Refactored to follow Verilog coding guidelines
 * 
 *******************************************************************/

`timescale 1ns / 1ps
`include "rv32i_defs.v"

module data_memory (
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
    
    // Read logic with zero output when not reading
    assign read_data = mem_read ? data[address] : `ZERO_32_BIT;

    // Test data initialization 
    initial begin
        data[0]=32'd17;
        data[1]=32'd9;
        data[2]=32'd25;
    end

    // Write logic
    always @(posedge clk) begin
        if (mem_write) begin
            data[address] <= write_data;
        end
    end

endmodule