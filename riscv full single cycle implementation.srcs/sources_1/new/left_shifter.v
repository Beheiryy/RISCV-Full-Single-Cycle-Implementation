/******************************************************************************
 * Module: left_shifter.v
 * Project: RISCV Full Single Cycle Implementation
 * Author: Omar Beheiry | omarbeheiry@aucegypt.edu
 * Description: Performs a logical left shift by one bit on an n-bit input.
 *
 * Change history: 04/12/26 Refactored to follow coding guidelines.
 *****************************************************************************/

module left_shifter #(
    parameter DATA_WIDTH = 32
)(
    input [DATA_WIDTH-1:0] in,
    output [DATA_WIDTH-1:0] out
);

    // Shift left by 1: Append a 0 to the LSB and take the lower (n-1) bits
    assign out = {in[DATA_WIDTH-2:0], 1'b0};

endmodule