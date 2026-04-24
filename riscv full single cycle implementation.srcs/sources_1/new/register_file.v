/******************************************************************************
 * Module: register_file.v
 * Project: RISCV Full Single Cycle Implementation
 * Author: Omar Beheiry | omarbeheiry@aucegypt.edu
 * Description: 32-bit RISC-V Register File with asynchronous reset.
 * Register x0 is hardwired to zero.
 *
 * Change history: 04/12/26 Refactored to follow coding guidelines.
 *****************************************************************************/

module register_file #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 5
)(
    input clk,
    input rst,
    input reg_write,
    input [ADDR_WIDTH-1:0] read_reg_1,
    input [ADDR_WIDTH-1:0] read_reg_2,
    input [ADDR_WIDTH-1:0] write_reg,
    input [DATA_WIDTH-1:0] write_data,
    output [DATA_WIDTH-1:0] read_data_1,
    output [DATA_WIDTH-1:0] read_data_2
);

    reg [DATA_WIDTH-1:0] rf [DATA_WIDTH-1:0];

    // Combinational reads
    assign read_data_1 = rf[read_reg_1];
    assign read_data_2 = rf[read_reg_2];

    integer i;

    // Sequential write logic with asynchronous active high reset
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < DATA_WIDTH; i = i + 1) begin
                rf[i] <= 0;
            end
        end
        else begin
            // RV32I: Register x0 is hardwired to 0; write is only performed if write_reg != 0
            if (reg_write && (write_reg != 0)) begin
                rf[write_reg] <= write_data;
            end
        end
    end

endmodule