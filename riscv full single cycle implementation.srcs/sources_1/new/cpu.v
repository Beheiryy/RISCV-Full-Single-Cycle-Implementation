/*******************************************************************
 * 
 * Module: cpu.v
 * Project: Risc Full Single Cycle Implementation 
 * Author: Ahmed Saad Mohammed
 * Description: Risc Full Single Cycle Implementation
 * 
 * Change history: 04/12/26 - Refactored to follow Verilog coding guidelines
 * 
 *******************************************************************/

`timescale 1ns / 1ps
`include "rv32i_defs.v"

module cpu (
    // Clocks
    input wire clk,
    
    // Resets  
    input wire reset
);

    // Program counter
    reg [31:0] pc;
    
    // Internal wires
    wire [31:0] instruction;
    wire [31:0] read_data_1;
    wire [31:0] read_data_2; 
    wire [31:0] write_data;
    wire [31:0] alu_output;
    wire [31:0] immediate_output;
    wire [31:0] dmem_output;
    wire [31:0] sl_output;
    wire [31:0] pc_plus4;
    wire [31:0] branch_target;
    wire [31:0] pc_in;
    
    // Control signals
    wire branch;
    wire mem_read;
    wire mem_to_reg;
    wire mem_write;
    wire alu_src;
    wire reg_write;
    wire zf;
    wire [1:0] alu_op;
    wire [3:0] alu_sel;
    
    wire exitProgramSignal;

    // PC calculation
    assign pc_plus4 = pc + `PC_INCREMENT;
    assign branch_target = pc + sl_output;
    assign pc_in = reset ? `ZERO_32_BIT :
                   (exitProgramSignal == 1'b1) ? pc :  
    ((branch & zf) ? branch_target : pc_plus4);

    // Write data mux
    assign write_data = mem_to_reg ? dmem_output : alu_output;

    // Instruction memory
    instruction_memory imem(
        .address(pc[7:2]),
        .instruction_word(instruction)
    );

    // Control unit
    control_unit cu(
        .opcode(instruction[`IR_opcode]),
        .exitProgramSignal(exitProgramSignal),
        .branch(branch),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .alu_op(alu_op)
    );

    // ALU control unit
    alu_control_unit acu(
        .alu_op(alu_op),
        .funct3(instruction[`IR_funct3]),
        .funct7(instruction[30]),
        .is_sub(instruction[5]),
        .alu_control(alu_sel)
    );

    // Immediate generator
    immediate_generator immediate_generator(
        .instruction(instruction),
        .immediate(immediate_output)
    );

    // Shift left for branch target
    left_shifter #(.DATA_WIDTH(32)) sl(
        .in(immediate_output),
        .out(sl_output)
    );

    // Register file
    register_file #(.DATA_WIDTH(32), .ADDR_WIDTH(5)) rf(
        .clk(clk),
        .rst(reset),
        .read_reg_1(instruction[`IR_rs1]),
        .read_reg_2(instruction[`IR_rs2]),
        .write_reg(instruction[`IR_rd]),
        .write_data(write_data),
        .reg_write(reg_write),
        .read_data_1(read_data_1),
        .read_data_2(read_data_2)
    );

    // ALU
    alu #(.DATA_WIDTH(32)) alu (
        .a(read_data_1),
        .b(alu_src ? immediate_output : read_data_2),
        .selection(alu_sel),
        .c(alu_output),
        .zf(zf)
    );

    // Data memory
    data_memory dmem(
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(alu_output[7:2]),
        .write_data(read_data_2),
        .read_data(dmem_output)
    );

    // Sequential PC update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= `ZERO_32_BIT;
        end else begin
            pc <= pc_in;
        end
    end

endmodule