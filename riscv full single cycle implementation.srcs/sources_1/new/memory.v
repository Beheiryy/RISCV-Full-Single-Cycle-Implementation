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
data[0] = 32'b0000000_00000_00000_000_00000_0001111; // fence
data[1] = 32'b000000000000_00000_001_00000_0001111; // fence.i
data[2] = 32'b000000000001_00000_000_00001_0010011; // addi x1, x0, 1
data[3] = 32'b000000000001_00001_000_00010_0010011; // addi x2, x1, 1
data[4] = 32'b0000100_00010_00000_010_00000_0100011; // sw x2, 128(x0)





    end

endmodule
