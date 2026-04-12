/******************************************************************************
 * Module: alu.v
 * Project: RISCV Full Single Cycle Implementation
 * Author: Omar Beheiry | omarbeheiry@aucegypt.edu
 * Description: Arithmetic Logic Unit for the RV32I processor. Performs 
 * operations based on the 4-bit selection signal.
 *
 * Change history: 04/12/26 Refactored to follow coding guidelines.
 *****************************************************************************/

`include "rv32i_defs.v"

module alu #(
    parameter DATA_WIDTH = 32
)(
    input [DATA_WIDTH-1:0] a,
    input [DATA_WIDTH-1:0] b,
    input [3:0] selection,
    output reg [DATA_WIDTH-1:0] c,
    output zf
);

    // Combinational logic for operations
    wire [DATA_WIDTH-1:0] and_result;
    wire [DATA_WIDTH-1:0] or_result;
    wire [DATA_WIDTH-1:0] add_result;
    wire [DATA_WIDTH-1:0] sub_result;

    assign and_result = a & b;
    assign or_result  = a | b;
    assign add_result = a + b;
    assign sub_result = a - b;

    // Selection logic
    always @(*) begin
        case (selection)
            `ALU_AND: begin
                c = and_result;
            end
            
            `ALU_OR: begin
                c = or_result;
            end
            
            `ALU_ADD: begin
                c = add_result;
            end
            
            `ALU_SUB: begin
                c = sub_result;
            end
            
            default: begin
                c = {DATA_WIDTH{1'b0}};
            end
        endcase
    end

    // Zero Flag: Set if the result is zero
    assign zf = (c == {DATA_WIDTH{1'b0}});

endmodule