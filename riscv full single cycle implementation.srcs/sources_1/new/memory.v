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
   
   //signed extnsion or unsigned etension
    input wire signed_ex,
    
    
    // byte, halfword, or word
    input wire [1:0] size_addressing,
   
    // Address
    input wire [7:0] address,
    
    // Data
    input wire [31:0] write_data,
    output reg [31:0] read_data
); 

    // Data RAM (64 x 32-bit)
    reg [31:0] data [0:63];
    
    //instruction read handling
    always @ (*) begin
        read_data = mem_read ? data[address[7:2]] : `ZERO_32_BIT;
    end 
    
    // Write logic
    always @(negedge clk) begin
        if(mem_read) begin
            case (size_addressing)
        2'b00: begin // Load Byte(LB)
                    if(signed_ex == 1'b1) // if signed byte, copy sign bit
                        if(address[1:0] == 2'b00)
                            read_data = {{24{data[address[7:2]][7]}},data[address[7:2]][7:0]};
                        else if(address[1:0] == 2'b01)
                            read_data = {{24{data[address[7:2]][15]}},data[address[7:2]][15:8]};
                        else if(address[1:0] == 2'b10)
                            read_data = {{24{data[address[7:2]][23]}},data[address[7:2]][23:16]};
                        else 
                            read_data = {{24{data[address[7:2]][31]}},data[address[7:2]][31:24]};
                        
                    else // otherwise, copy zeroes
                        if(address[1:0] == 2'b00)
                            read_data = {{24{1'b0}},data[address[7:2]][7:0]};
                        else if(address[1:0] == 2'b01)
                            read_data = {{24{1'b0}},data[address[7:2]][15:8]};
                        else if(address[1:0] == 2'b10)
                            read_data = {{24{1'b0}},data[address[7:2]][23:16]};
                        else 
                            read_data = {{24{1'b0}},data[address[7:2]][31:24]};
            end
            2'b01: begin // Load Half Word(LH)
                // Only allow read if address is halfword-aligned (ends in 0)
                if (address[0] == 1'b0) begin
                    if(signed_ex == 1'b1) // if signed halfword, copy sign bit
                        if(address[1] == 1'b1)
                            read_data = {{16{data[address[7:2]][31]}},data[address[7:2]][31:16]};
                        else
                            read_data = {{16{data[address[7:2]][15]}},data[address[7:2]][15:0]};
                    else // otherwise, copy zeroes
                        if(address[1] == 1'b1)
                            read_data = {{16{1'b0}},data[address[7:2]][31:16]};
                        else
                            read_data = {{16{1'b0}},data[address[7:2]][15:0]};
                end 
                else begin
                    read_data = `ZERO_32_BIT; // or trigger an alignment fault signal, but we will just put zeroes
                end
            end
            2'b10: begin // Load Word (LW)
                // Only allow read if address is word-aligned (ends in 00)
                if (address[1:0] == 2'b00) begin
                    read_data = data[address[7:2]]; 
                end else begin
                    read_data = `ZERO_32_BIT; // or trigger an alignment fault signal, but we will just put zeroes
                end
            end
           default: read_data = `ZERO_32_BIT;
        endcase
        end
    
        if (mem_write) begin
            //data[address[7:2]] <= write_data;
            case(size_addressing)
                2'b00: begin //store byte
                    if(address[1:0] == 2'b00)
                        data[address[7:2]][7:0] <= write_data[7:0];
                    else if(address[1:0] == 2'b01)
                        data[address[7:2]][15:8] <= write_data[7:0];
                    else if(address[1:0] == 2'b10)
                        data[address[7:2]][23:16] <= write_data[7:0];
                    else 
                        data[address[7:2]][31:24] <= write_data[7:0];
                end
                2'b01: begin //store halfword
                    if(address[0] == 1'b0)
                    begin
                        if(address[1] == 1'b1)
                            data[address[7:2]][31:16] <= write_data[15:0];
                        else
                            data[address[7:2]][15:0] <= write_data[15:0];
                    end
                end
                2'b10: begin //store word
                    if(address[1:0] == 2'b00)
                        data[address[7:2]] <= write_data;
                end
            endcase
        end
    end
    
    integer i;
    initial begin
        for(i = 0; i < 64; i = i + 1) begin
            data[i] = 0;
        end
    end
    
    // Test data initialization 
    initial begin
data[0]  = 32'b0000000_00000_00000_000_00000_0110011 ; // add x0, x0, x0
// added to be skipped since PC starts with 4 after reset

data[1]  = 32'b000010000000_00000_010_00001_0000011 ; // lw x1, 128(x0)
data[2]  = 32'b000010000100_00000_010_00010_0000011 ; // lw x2, 132(x0)
data[3]  = 32'b000010001000_00000_010_00011_0000011 ; // lw x3, 136(x0)

data[4]  = 32'b0000000_00010_00001_110_00100_0110011 ; // or x4, x1, x2

data[5]  = 32'b0000000_00000_00000_000_00000_0110011 ; // add x0, x0, x0

data[6]  = 32'b0_000000_00011_00100_000_0110_0_1100011; // beq x4, x3, 16

data[7]  = 32'b0000000_00010_00001_000_00011_0110011 ; // add x3, x1, x2

data[8]  = 32'b0000000_00000_00000_000_00000_0110011 ; // add x0, x0, x0

data[9]  = 32'b0000000_00010_00011_000_00101_0110011 ; // add x5, x3, x2

data[10] = 32'b0000000_00000_00000_000_00000_0110011 ; // add x0, x0, x0

// S-type split immediate: imm[11:5] | rs2 | rs1 | funct3 | imm[4:0] | opcode
// 140 = 000010001100 ? [11:5]=0000100, [4:0]=01100
data[11] = 32'b0000100_00101_00000_010_01100_0100011 ; // sw x5, 140(x0)

data[12] = 32'b000010001100_00000_010_00110_0000011 ; // lw x6, 140(x0)

data[13] = 32'b0000000_00000_00000_000_00000_0110011 ; // add x0, x0, x0

data[14] = 32'b0000000_00001_00110_111_00111_0110011 ; // and x7, x6, x1
data[15] = 32'b0100000_00010_00001_000_01000_0110011 ; // sub x8, x1, x2

data[16] = 32'b0000000_00010_00001_000_00000_0110011 ; // add x0, x1, x2
data[17] = 32'b0000000_00001_00000_000_01001_0110011 ; // add x9, x0, x1

// data section (unchanged)
data[32] = 32'd17;
data[33] = 32'd9;
data[34] = 32'd25;
    end

endmodule
