`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2026 11:22:54 AM
// Design Name: 
// Module Name: branching_unit
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
module branching_unit(
    input [2:0] funct3,
    input zf, nf, cf, of,
    output reg branch_take
    );
    
    always @(*) begin
    branch_take = 1'b0;
        case(funct3)
            `F3_BEQ:  branch_take = zf;
            `F3_BNE:  branch_take = ~zf;
            `F3_BLT:  branch_take = nf ^ of;
            `F3_BGE:  branch_take = ~(nf ^ of);
            `F3_BLTU: branch_take = ~cf;
            `F3_BGEU: branch_take = cf;
            default:  branch_take = 1'b0;
        endcase
    end
endmodule
