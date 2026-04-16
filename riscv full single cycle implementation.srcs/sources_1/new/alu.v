/******************************************************************************
 * Module: alu.v
 * Project: RISCV Full Single Cycle Implementation
 * Author: Omar Beheiry | omarbeheiry@aucegypt.edu
 * Description: Arithmetic Logic Unit for the RV32I processor. Performs 
 * operations based on the 4-bit selection signal.
 *
 * Change history: 04/12/26 Refactored to follow coding guidelines.
 * Change history: 04/12/26 Rewritten to support other functions
 *****************************************************************************/

`include "rv32i_defs.v"

module alu #(
    parameter DATA_WIDTH = 32
)(
    input  [DATA_WIDTH-1:0] a,
    input  [DATA_WIDTH-1:0] b,
    input  [3:0] selection,
    output reg [DATA_WIDTH-1:0] c,

    // Flags
    output zf, // Zero
    output nf, // Negative (sign)
    output cf, // Carry
    output of  // Overflow (signed)
);

    // Wires for carry detection
    wire [DATA_WIDTH:0] add_ext = {1'b0, a} + {1'b0, b};
    wire [DATA_WIDTH:0] sub_ext = {1'b0, a} - {1'b0, b};

    wire [DATA_WIDTH-1:0] add_result  = add_ext[DATA_WIDTH-1:0];
    wire [DATA_WIDTH-1:0] sub_result  = sub_ext[DATA_WIDTH-1:0];
    wire [DATA_WIDTH-1:0] and_result  = a & b;
    wire [DATA_WIDTH-1:0] or_result   = a | b;
    wire [DATA_WIDTH-1:0] xor_result  = a ^ b;

    wire [DATA_WIDTH-1:0] sll_result  = a << b[4:0];
    wire [DATA_WIDTH-1:0] srl_result  = a >> b[4:0];
    wire [DATA_WIDTH-1:0] sra_result  = $signed(a) >>> b[4:0];

    wire [DATA_WIDTH-1:0] slt_result  = ($signed(a) < $signed(b)) ? 1 : 0;
    wire [DATA_WIDTH-1:0] sltu_result = (a < b) ? 1 : 0;

    // Internal flag registers
    reg carry_flag;
    reg overflow_flag;

    always @(*) begin
        // defaults
        c = {DATA_WIDTH{1'b0}};
        carry_flag = 1'b0;
        overflow_flag = 1'b0;

        case (selection)
            `ALU_ADD: begin
                c = add_result;
                carry_flag = add_ext[DATA_WIDTH];

                // Signed overflow: same sign inputs, different sign output
                overflow_flag = (~a[DATA_WIDTH-1] & ~b[DATA_WIDTH-1] & c[DATA_WIDTH-1]) |
                                ( a[DATA_WIDTH-1] &  b[DATA_WIDTH-1] & ~c[DATA_WIDTH-1]);
            end

            `ALU_SUB: begin
                c = sub_result;
                carry_flag = ~sub_ext[DATA_WIDTH]; // borrow handling

                // Signed overflow: different sign inputs, result sign differs from a
                overflow_flag = (~a[DATA_WIDTH-1] &  b[DATA_WIDTH-1] & c[DATA_WIDTH-1]) |
                                ( a[DATA_WIDTH-1] & ~b[DATA_WIDTH-1] & ~c[DATA_WIDTH-1]);
            end

            `ALU_AND: c = and_result;
            `ALU_OR: c = or_result;
            `ALU_XOR: c = xor_result;
            `ALU_SLL: c = sll_result;
            `ALU_SRL: c = srl_result;
            `ALU_SRA: c = sra_result;
            `ALU_SLT: c = slt_result;
            `ALU_SLTU: c = sltu_result;

            default: c = {DATA_WIDTH{1'b0}};
        endcase
    end

    // Final flags
    assign zf = (c == {DATA_WIDTH{1'b0}});
    assign nf = c[DATA_WIDTH-1];
    assign cf = carry_flag;
    assign of = overflow_flag;

endmodule