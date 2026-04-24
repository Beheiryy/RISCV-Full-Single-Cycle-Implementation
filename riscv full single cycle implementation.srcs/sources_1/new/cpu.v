`timescale 1ns / 1ps
`include "rv32i_defs.v"

module cpu (
    input wire clk,
    input wire reset
);

    // ============================================================
    // IF stage
    // ============================================================
    wire [31:0] pc;
    wire [31:0] pc_in;
    wire [31:0] pc_plus4;
    wire [31:0] instruction;

    assign pc_plus4 = pc + `PC_INCREMENT;

    // Change: PC is now stored with the reusable register module.
    register #(.n(32)) pc_reg (
        .clk(clk),
        .reset(reset),
        .load(1'b1),
        .data(pc_in),
        .out(pc)
    );

    // ============================================================
    // IF/ID pipeline register
    // ============================================================
    wire [31:0] IF_ID_pc;
    wire [31:0] IF_ID_pc_plus4;
    wire [31:0] IF_ID_instruction;

    register #(.n(64)) IF_ID_rg (
        .clk(~clk),
        .reset(reset),
        .load(1'b1),
        .data({pc, instruction}),
        .out({IF_ID_pc, IF_ID_instruction})
    );

    assign IF_ID_pc_plus4 = IF_ID_pc + `PC_INCREMENT;

    // ============================================================
    // ID stage
    // ============================================================
    wire [31:0] read_data_1, read_data_2;
    wire [31:0] immediate_output;
    wire [31:0] sl_output;

    wire branch;
    wire mem_read;
    wire mem_write;
    wire alu_src_1;
    wire alu_src_2;
    wire reg_write;
    wire jump;
    wire exit_program;
    wire [1:0] alu_op;
    wire [1:0] reg_write_src;

    control_unit cu(
        .opcode(IF_ID_instruction[`IR_opcode]),
        .exit_program(exit_program),
        .branch(branch),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_src_1(alu_src_1),
        .alu_src_2(alu_src_2),
        .reg_write(reg_write),
        .jump(jump),
        .alu_op(alu_op),
        .reg_write_src(reg_write_src)
    );

    immediate_generator ig(
        .instruction(IF_ID_instruction),
        .immediate(immediate_output)
    );

    // Change: branch offset preparation stays in ID stage.
    left_shifter #(.DATA_WIDTH(32)) sl(
        .in(immediate_output),
        .out(sl_output)
    );

    // Change: register file reads happen from IF/ID instruction.
    // Write-back comes from MEM/WB.
    wire [31:0] write_data;
    wire [4:0]  MEM_WB_rd;
    wire        MEM_WB_reg_write;
    wire [1:0]  MEM_WB_reg_write_src;

    register_file #(.DATA_WIDTH(32), .ADDR_WIDTH(5)) rf(
        .clk(~clk),
        .rst(reset),
        .read_reg_1(IF_ID_instruction[`IR_rs1]),
        .read_reg_2(IF_ID_instruction[`IR_rs2]),
        .write_reg(MEM_WB_rd),
        .write_data(write_data),
        .reg_write(MEM_WB_reg_write),
        .read_data_1(read_data_1),
        .read_data_2(read_data_2)
    );

    // ============================================================
    // ID/EX pipeline register
    // ============================================================
    wire [31:0] ID_EX_pc;
    wire [31:0] ID_EX_pc_plus4;
    wire [31:0] ID_EX_read_data_1;
    wire [31:0] ID_EX_read_data_2;
    wire [31:0] ID_EX_immediate_output;
    wire [31:0] ID_EX_instruction;
    wire [31:0] ID_EX_sl_output;

    wire ID_EX_branch;
    wire ID_EX_mem_read;
    wire ID_EX_mem_write;
    wire ID_EX_alu_src_1;
    wire ID_EX_alu_src_2;
    wire ID_EX_reg_write;
    wire ID_EX_jump;
    wire [1:0] ID_EX_alu_op;
    wire [1:0] ID_EX_reg_write_src;
    wire [4:0] ID_EX_rs1, ID_EX_rs2;

    register #(.n(32)) ID_EX_pc_rg (
        .clk(clk), .reset(reset), .load(1'b1),
        .data(EX_MEM_flush ? `ZERO_32_BIT : IF_ID_pc),
        .out(ID_EX_pc)
    );

    register #(.n(32)) ID_EX_pc_plus4_rg (
        .clk(clk), .reset(reset), .load(1'b1),
        .data(IF_ID_pc_plus4),
        .out(ID_EX_pc_plus4)
    );

    register #(.n(32)) ID_EX_rdata1_rg (
        .clk(clk), .reset(reset), .load(1'b1),
        .data(EX_MEM_flush ? `ZERO_32_BIT : read_data_1),
        .out(ID_EX_read_data_1)
    );

    register #(.n(32)) ID_EX_rdata2_rg (
        .clk(clk), .reset(reset), .load(1'b1),
        .data(EX_MEM_flush ? `ZERO_32_BIT : read_data_2),
        .out(ID_EX_read_data_2)
    );

    register #(.n(32)) ID_EX_imm_rg (
        .clk(clk), .reset(reset), .load(1'b1),
        .data(EX_MEM_flush ? `ZERO_32_BIT : immediate_output),
        .out(ID_EX_immediate_output)
    );

    register #(.n(32)) ID_EX_inst_rg (
        .clk(clk), .reset(reset), .load(1'b1),
        .data(EX_MEM_flush ? `NOP : IF_ID_instruction),
        .out(ID_EX_instruction)
    );
    
    register #(.n(32)) ID_EX_sl_output_rg(
        .clk(clk), .reset(reset), .load(1'b1),
        .data(EX_MEM_flush ? `ZERO_32_BIT : sl_output),
        .out(ID_EX_sl_output)
    );

    register #(.n(1)) ID_EX_branch_rg (
        .clk(clk), .reset(reset), .load(1'b1),
        .data(EX_MEM_flush ? 1'b0 : branch),
        .out(ID_EX_branch)
    );

    register #(.n(1)) ID_EX_mem_read_rg (
        .clk(clk), .reset(reset), .load(1'b1),
        .data(EX_MEM_flush ? 1'b0 : mem_read),
        .out(ID_EX_mem_read)
    );

    register #(.n(1)) ID_EX_mem_write_rg (
        .clk(clk), .reset(reset), .load(1'b1),
        .data(EX_MEM_flush ? 1'b0 : mem_write),
        .out(ID_EX_mem_write)
    );

    register #(.n(1)) ID_EX_alu_src_1_rg (
        .clk(clk), .reset(reset), .load(1'b1),
        .data(EX_MEM_flush ? 1'b0 : alu_src_1),
        .out(ID_EX_alu_src_1)
    );

    register #(.n(1)) ID_EX_alu_src_2_rg (
        .clk(clk), .reset(reset), .load(1'b1),
        .data(EX_MEM_flush ? 1'b0 : alu_src_2),
        .out(ID_EX_alu_src_2)
    );

    register #(.n(1)) ID_EX_reg_write_rg (
        .clk(clk), .reset(reset), .load(1'b1),
        .data(EX_MEM_flush ? 1'b0 : reg_write),
        .out(ID_EX_reg_write)
    );

    register #(.n(1)) ID_EX_jump_rg (
        .clk(clk), .reset(reset), .load(1'b1),
        .data(EX_MEM_flush ? 1'b0 : jump),
        .out(ID_EX_jump)
    );

    register #(.n(2)) ID_EX_alu_op_rg (
        .clk(clk), .reset(reset), .load(1'b1),
        .data(EX_MEM_flush ? 2'b00 : alu_op),
        .out(ID_EX_alu_op)
    );

    register #(.n(2)) ID_EX_reg_write_src_rg (
        .clk(clk), .reset(reset), .load(1'b1),
        .data(EX_MEM_flush ? 2'b00 : reg_write_src),
        .out(ID_EX_reg_write_src)
    );
    
    register #(.n(5)) ID_EX_rs1_rg(
        .clk(clk), .reset(reset), .load(1'b1),
        .data(IF_ID_instruction[`IR_rs1]),
        .out(ID_EX_rs1)
    );
    
    register #(.n(5)) ID_EX_rs2_rg(
        .clk(clk), .reset(reset), .load(1'b1),
        .data(IF_ID_instruction[`IR_rs2]),
        .out(ID_EX_rs2)
    );

    // ============================================================
    // EX stage
    // ============================================================
    wire [3:0] alu_sel;
    wire [31:0] alu_output;
    wire [31:0] alu_operand_a;
    wire [31:0] alu_operand_b;
    wire [31:0] branch_target;
    wire branch_take;
    wire zf, cf, nf, of;
    wire forward_a, forward_b;
    
    forwarding_unit fu(
        .MEM_WB_rd(MEM_WB_rd),
        .ID_EX_rs1(ID_EX_rs1),
        .ID_EX_rs2(ID_EX_rs2),
        .MEM_WB_reg_write(MEM_WB_reg_write),
        .forward_a(forward_a), 
        .forward_b(forward_b)
    );

    alu_control_unit acu(
        .alu_op(ID_EX_alu_op),
        .funct3(ID_EX_instruction[`IR_funct3]),
        .funct7(ID_EX_instruction[30]),
        .is_sub(ID_EX_instruction[5]),
        .alu_control(alu_sel)
    );

    assign alu_operand_a =
        (ID_EX_alu_src_1) ? ID_EX_pc : 
        (forward_a) ? write_data : ID_EX_read_data_1;

    assign alu_operand_b =
        (ID_EX_alu_src_2) ? ID_EX_immediate_output : 
        (forward_b) ? write_data : ID_EX_read_data_2;

    alu #(.DATA_WIDTH(32)) alu(
        .a(alu_operand_a),
        .b(alu_operand_b),
        .selection(alu_sel),
        .c(alu_output),
        .zf(zf),
        .cf(cf),
        .nf(nf),
        .of(of)
    );

    branching_unit bu(
        .funct3(ID_EX_instruction[`IR_funct3]),
        .zf(zf), .cf(cf), .nf(nf), .of(of),
        .branch_take(branch_take)
    );

    assign branch_target = ID_EX_pc + ID_EX_sl_output;

    // ============================================================
    // EX/MEM pipeline register
    // ============================================================
    wire [31:0] EX_MEM_pc_plus4;
    wire [31:0] EX_MEM_alu_output;
    wire [31:0] EX_MEM_read_data_2;
    wire [31:0] EX_MEM_immediate_output;
    wire [31:0] EX_MEM_branch_target;
    wire [31:0] EX_MEM_instruction;
    wire [4:0]  EX_MEM_rd;

    wire EX_MEM_branch;
    wire EX_MEM_branch_take;
    wire EX_MEM_mem_read;
    wire EX_MEM_mem_write;
    wire EX_MEM_reg_write;
    wire EX_MEM_jump;
    wire EX_MEM_flush;
    wire [1:0] EX_MEM_reg_write_src;

    register #(.n(32)) EX_MEM_pc_plus4_rg (
        .clk(~clk), .reset(reset), .load(1'b1),
        .data(ID_EX_pc_plus4),
        .out(EX_MEM_pc_plus4)
    );

    register #(.n(32)) EX_MEM_alu_output_rg (
        .clk(~clk), .reset(reset), .load(1'b1),
        .data(alu_output),
        .out(EX_MEM_alu_output)
    );

    register #(.n(32)) EX_MEM_rdata2_rg (
        .clk(~clk), .reset(reset), .load(1'b1),
        .data((forward_b) ? write_data : ID_EX_read_data_2),
        .out(EX_MEM_read_data_2)
    );

    register #(.n(32)) EX_MEM_imm_rg (
        .clk(~clk), .reset(reset), .load(1'b1),
        .data(ID_EX_immediate_output),
        .out(EX_MEM_immediate_output)
    );

    register #(.n(32)) EX_MEM_branch_target_rg (
        .clk(~clk), .reset(reset), .load(1'b1),
        .data(branch_target),
        .out(EX_MEM_branch_target)
    );

    register #(.n(32)) EX_MEM_inst_rg (
        .clk(~clk), .reset(reset), .load(1'b1),
        .data(ID_EX_instruction),
        .out(EX_MEM_instruction)
    );

    register #(.n(5)) EX_MEM_rd_rg (
        .clk(~clk), .reset(reset), .load(1'b1),
        .data(ID_EX_instruction[`IR_rd]),
        .out(EX_MEM_rd)
    );

    register #(.n(1)) EX_MEM_branch_rg (
        .clk(~clk), .reset(reset), .load(1'b1),
        .data(ID_EX_branch),
        .out(EX_MEM_branch)
    );

    register #(.n(1)) EX_MEM_branch_take_rg (
        .clk(~clk), .reset(reset), .load(1'b1),
        .data(branch_take),
        .out(EX_MEM_branch_take)
    );

    register #(.n(1)) EX_MEM_mem_read_rg (
        .clk(~clk), .reset(reset), .load(1'b1),
        .data(ID_EX_mem_read),
        .out(EX_MEM_mem_read)
    );

    register #(.n(1)) EX_MEM_mem_write_rg (
        .clk(~clk), .reset(reset), .load(1'b1),
        .data(ID_EX_mem_write),
        .out(EX_MEM_mem_write)
    );

    register #(.n(1)) EX_MEM_reg_write_rg (
        .clk(~clk), .reset(reset), .load(1'b1),
        .data(ID_EX_reg_write),
        .out(EX_MEM_reg_write)
    );

    register #(.n(1)) EX_MEM_jump_rg (
        .clk(~clk), .reset(reset), .load(1'b1),
        .data(ID_EX_jump),
        .out(EX_MEM_jump)
    );

    register #(.n(2)) EX_MEM_reg_write_src_rg (
        .clk(~clk), .reset(reset), .load(1'b1),
        .data(ID_EX_reg_write_src),
        .out(EX_MEM_reg_write_src)
    );

    // ============================================================
    // MEM stage
    // ============================================================
    wire [31:0] mem_output;
    assign instruction = mem_output;
    assign EX_MEM_flush = EX_MEM_jump || (EX_MEM_branch && EX_MEM_branch_take);
    memory mem(
        .clk(clk),
        .mem_read(clk | EX_MEM_mem_read),
        .mem_write((~clk) & EX_MEM_mem_write),
        .address(clk ? pc[7:2] : EX_MEM_alu_output[7:2]),
        .write_data(EX_MEM_read_data_2),
        .read_data(mem_output)
    );

    // ============================================================
    // MEM/WB pipeline register
    // ============================================================
    wire [31:0] MEM_WB_pc_plus4;
    wire [31:0] MEM_WB_alu_output;
    wire [31:0] MEM_WB_mem_output;
    wire [31:0] MEM_WB_immediate_output;
    wire [31:0] MEM_WB_instruction;

    register #(.n(32)) MEM_WB_pc_plus4_rg (
        .clk(clk), .reset(reset), .load(1'b1),
        .data(EX_MEM_pc_plus4),
        .out(MEM_WB_pc_plus4)
    );

    register #(.n(32)) MEM_WB_alu_output_rg (
        .clk(clk), .reset(reset), .load(1'b1),
        .data(EX_MEM_alu_output),
        .out(MEM_WB_alu_output)
    );

    register #(.n(32)) MEM_WB_mem_output_rg (
        .clk(clk), .reset(reset), .load(1'b1),
        .data(mem_output),
        .out(MEM_WB_mem_output)
    );

    register #(.n(32)) MEM_WB_immediate_output_rg (
        .clk(clk), .reset(reset), .load(1'b1),
        .data(EX_MEM_immediate_output),
        .out(MEM_WB_immediate_output)
    );

    register #(.n(32)) MEM_WB_instruction_rg (
        .clk(clk), .reset(reset), .load(1'b1),
        .data(EX_MEM_instruction),
        .out(MEM_WB_instruction)
    );

    register #(.n(5)) MEM_WB_rd_rg (
        .clk(clk), .reset(reset), .load(1'b1),
        .data(EX_MEM_rd),
        .out(MEM_WB_rd)
    );

    register #(.n(1)) MEM_WB_reg_write_rg (
        .clk(clk), .reset(reset), .load(1'b1),
        .data(EX_MEM_reg_write),
        .out(MEM_WB_reg_write)
    );

    register #(.n(2)) MEM_WB_reg_write_src_rg (
        .clk(clk), .reset(reset), .load(1'b1),
        .data(EX_MEM_reg_write_src),
        .out(MEM_WB_reg_write_src)
    );

    // ============================================================
    // WB stage
    // ============================================================
    assign write_data =
        (MEM_WB_reg_write_src == 2'b00) ? MEM_WB_mem_output :
        (MEM_WB_reg_write_src == 2'b01) ? MEM_WB_immediate_output :
        (MEM_WB_reg_write_src == 2'b10) ? MEM_WB_pc_plus4 :
                                          MEM_WB_alu_output;

    // ============================================================
    // PC update
    // ============================================================
    assign pc_in =
        (exit_program) ? pc :
        (EX_MEM_jump) ? EX_MEM_alu_output :
        (EX_MEM_branch & EX_MEM_branch_take) ? EX_MEM_branch_target :
        pc_plus4;

    // Change: no stalls are added.
    // Change: no forwarding logic is implemented here yet.
    // Change: no flush logic is implemented yet.

endmodule