`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2023 01:33:14 AM
// Design Name: 
// Module Name: Core
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


module Core(
    input wire clk, resetn,
    input wire [31:0] instr, mem_data,
    output wire [31:0] addr_mem, data_mem, o_pc,
    output wire o_mem_write
    );
    
    // -----------------------------------IF-----------------------------///
    // PC Unit
    wire branch_ok, ex_jum, flush;
    wire pcsrc = branch_ok | ex_jum;
    wire [31:0] pc4;
    wire [31:0] alu_result; 
    PC_Unit pc_unit(.clk(clk), .resetn(resetn), .pcsrc(pcsrc), .i_pc_target(alu_result), .o_pc4(pc4), .o_pc(o_pc));
    
    
    // IF-ID pipeline
    wire [31:0] id_instr, id_pc, id_pc4;
    
    IF_ID_Reg if_id_reg(.clk(clk), .resetn(resetn), .i_if_instr(instr), .i_if_pc4(pc4), .i_if_pc(o_pc), .flush(flush), .o_id_instr(id_instr), .o_id_pc4(id_pc4), .o_id_pc(id_pc));
    
    // -----------------------------------ID-----------------------------//
    wire [6:0] opcode = id_instr[6:0];
    wire [6:0] funct7 = id_instr[31:25];
    wire [2:0] funct3 = id_instr[14:12];
    wire [4:0] rs1 = id_instr[19:15];
    wire [4:0] rs2 = id_instr[24:20];
    wire [4:0] rd = id_instr[11:7];
    
    // Registers file
    // input
    wire [4:0] wb_rd;
    wire wb_reg_write;
    wire [31:0] wb_write_data;
    // output
    wire [31:0] rd1, rd2;
    Reg_File reg_file(.clk(~clk), .resetn(resetn), .rs1(rs1), .rs2(rs2), .rd(wb_rd), .reg_write(wb_reg_write), .rd1(rd1), .rd2(rd2), .write_data(wb_write_data));
    
    
    // Immediate Decode
    // output
    wire [31:0] imm;
    Imm_Decode imm_decode(.instr(id_instr), .opcode(opcode), .o_imm(imm));
    
    // Control Unit
    // output
    wire [4:0] alu_op;
    wire [1:0] select_data_wb, branch_type;
    wire slt_instr, reg_write, is_branch, mem_write, ls_b, ls_h, compare_signed, select_alu_a, select_alu_b, select_data_compare, load_signext;
    
    Control_Unit control_unit(.opcode(opcode), .funct7(funct7), .funct3(funct3), .resetn(resetn), .slt_instr(slt_instr)
    , .reg_write(reg_write), .is_branch(is_branch), .jum(jum), .mem_write(mem_write), .ls_b(ls_b), .ls_h(ls_h)
    , .compare_signed(compare_signed), .select_alu_a(select_alu_a), .select_alu_b(select_alu_b), .select_data_compare(select_data_compare)
    , .load_signext(load_signext), .branch_type(branch_type), .select_data_wb(select_data_wb), .alu_op(alu_op));
    
    // ID-EX pipeline
    // output
    wire [31:0] ex_pc, ex_pc4, ex_rd1, ex_rd2, ex_imm;
    wire [4:0] ex_alu_op, ex_rs1, ex_rs2, ex_rd;
    wire [1:0] ex_select_data_wb, ex_branch_type;
    wire ex_slt_instr, ex_is_branch, ex_reg_write, ex_mem_write, ex_lsb, ex_lsh, ex_compare_signed,
    ex_select_alu_a, ex_select_alu_b, ex_select_data_compare, ex_load_signext;
    ID_EX_Reg id_ex_reg(.clk(clk), .resetn(resetn), .i_id_pc(id_pc), .i_id_pc4(id_pc4), .i_id_rd1(rd1), .i_id_rd2(rd2), .i_id_imm(imm)
    , .i_id_alu_op(alu_op), .i_id_rs1(rs1), .i_id_rs2(rs2), .i_id_rd(rd), .i_id_select_data_wb(select_data_wb), .i_id_branch_type(branch_type), .i_id_slt_instr(slt_instr)
    , .i_id_is_branch(is_branch), .i_id_reg_write(reg_write), .i_id_mem_write(mem_write), .i_id_jum(jum), .i_id_lsb(ls_b), .i_id_lsh(ls_h), .i_id_compare_signed(compare_signed)
    , .i_id_select_alu_a(select_alu_a), .i_id_select_alu_b(select_alu_b), .i_id_select_data_compare(select_data_compare), .i_id_load_signext(load_signext), .o_ex_pc(ex_pc)
    , .o_ex_pc4(ex_pc4), .o_ex_rd1(ex_rd1), .o_ex_rd2(ex_rd2), .o_ex_imm(ex_imm), .o_ex_alu_op(ex_alu_op), .o_ex_rs1(ex_rs1), .o_ex_rs2(ex_rs2), .o_ex_rd(ex_rd)
    , .o_ex_select_data_wb(ex_select_data_wb), .o_ex_branch_type(ex_branch_type), .o_ex_slt_instr(ex_slt_instr), .o_ex_is_branch(ex_is_branch), .o_ex_reg_write(ex_reg_write), .o_ex_mem_write(ex_mem_write)
    , .o_ex_jum(ex_jum), .o_ex_lsb(ex_lsb), .o_ex_lsh(ex_lsh), .o_ex_compare_signed(ex_compare_signed), .o_ex_select_alu_a(ex_select_alu_a), .o_ex_select_alu_b(ex_select_alu_b), .o_ex_select_data_compare(ex_select_data_compare)
    , .o_ex_load_signext(ex_load_signext));
   
    
    // ----------------------------------------------------EX-----------------------------------------//
   // Compare Unit
   // output
   wire a_lt_b, a_eq_b;
   wire [31:0] in2;
   
   // Mux select in2 for Compare Unit
   Mux2to1 select_in2_compare(.a(ex_rd2), .b(ex_imm), .select(ex_select_data_compare), .out(in2));
   Compare_Unit compare_unit(.a(ex_rd1), .b(in2), .compare_signed(ex_compare_signed), .a_lt_b(a_lt_b), .a_eq_b(a_eq_b));
   
   // Check branch
   Check_Branch check_branch(.branch_type(ex_branch_type), .is_branch(ex_is_branch), .is_eq(a_eq_b), .is_lt(a_lt_b), .yes(branch_ok));
    
   // ALU Unit
   // Mux 2 select in1 for ALU ex_rd1->fwd_alu_a, ex_rd2 -> fwd_alu_b
   wire [31:0] alu_a, alu_b, fwd_alu_a, fwd_alu_b;
   Mux2to1 select_in1_alu(.a(fwd_alu_a), .b(ex_pc), .select(ex_select_alu_a), .out(alu_a));
   // Mux 2 select in2 for ALU
   Mux2to1 select_in2_alu(.a(fwd_alu_b), .b(ex_imm), .select(ex_select_alu_b), .out(alu_b));
   
   
   ALU_Unit alu_unit(.a(alu_a), .b(alu_b), .alu_op(ex_alu_op), .result(alu_result));
   
   // Mux2 select alu_result or slt
   wire [31:0] data_ex_wb;
   Mux2to1 select_alu_slt(.a(alu_result), .b({31'd0,a_lt_b}), .select(ex_slt_instr), .out(data_ex_wb));
   
   // EX-MEM pipeline
   // ouput 
   wire mem_reg_write, mem_mem_write, mem_lsb, mem_lsh, mem_load_signext;
   wire [31:0] mem_data_mem,mem_pc4, mem_rd2, mem_data_ex_wb;
   wire [4:0] mem_rd;
   wire [1:0] mem_select_data_wb;
   EX_MEM_Reg ex_mem_reg(.clk(clk), .resetn(resetn), .i_ex_reg_write(ex_reg_write), .i_ex_mem_write(ex_mem_write), .i_ex_lsb(ex_lsb)
   , .i_ex_lsh(ex_lsh), .i_ex_load_signext(ex_load_signext), .i_ex_data_mem(fwd_alu_b), .i_ex_pc4(ex_pc4), .i_ex_data_ex_wb(data_ex_wb), .i_ex_rd(ex_rd), .i_ex_select_data_wb(ex_select_data_wb), .o_mem_reg_write(mem_reg_write)
   , .o_mem_mem_write(mem_mem_write), .o_mem_load_signext(mem_load_signext), .o_mem_lsb(mem_lsb), .o_mem_lsh(mem_lsh), .o_mem_data_mem(mem_data_mem), .o_mem_pc4(mem_pc4), .o_mem_rd(mem_rd), .o_mem_select_data_wb(mem_select_data_wb)
   , .o_mem_data_ex_wb(mem_data_ex_wb));
   
   // -------------------------------------------------MEM-----------------------------------------//
   // Load Unit
   // output
   wire [31:0] load_data;
   Load_Unit load_unit(.data_in(mem_data), .lb(mem_lsb), .lh(mem_lsh), .load_signext(mem_load_signext), .data_out(load_data));
   
   // Store Unit
   Store_Unit store_unit(.data_in(mem_data_mem), .sb(ex_lsb), .sh(ex_lsh), .data_out(data_mem));
   assign o_mem_write = mem_mem_write;
   assign addr_mem = mem_data_ex_wb;
   
   // MEM-WB pipeline
   // output
   wire [31:0] wb_data_ex_wb, wb_load_data, wb_pc4;
   wire [1:0] wb_select_data_wb;
   MEM_WB_Reg mem_wb_reg(.clk(clk), .resetn(resetn), .i_mem_data_ex_wb(mem_data_ex_wb), .i_mem_load_data(load_data), .i_mem_pc4(mem_pc4), .i_mem_rd(mem_rd)
   , .i_mem_select_data_wb(mem_select_data_wb), .i_mem_reg_write(mem_reg_write), .o_wb_data_ex_wb(wb_data_ex_wb), .o_wb_load_data(wb_load_data), .o_wb_pc4(wb_pc4), .o_wb_rd(wb_rd), .o_wb_select_data_wb(wb_select_data_wb)
   , .o_wb_reg_write(wb_reg_write));
   // --------------------------------------------------WB-------------------------------------//
   // Mux WB
   // output 
   Mux3to1 wb_mux(.a(wb_data_ex_wb), .b(wb_load_data), .c(wb_pc4), .select(wb_select_data_wb), .out(wb_write_data));
   
   // Hazard Unit
   wire [1:0] fwda_select, fwdb_select;
   Mux3to1 fwda_mux(.a(ex_rd1), .b(mem_data_ex_wb), .c(wb_write_data), .select(fwda_select), .out(fwd_alu_a));
   Mux3to1 fwdb_mux(.a(ex_rd2), .b(mem_data_ex_wb), .c(wb_write_data), .select(fwdb_select), .out(fwd_alu_b));
   
   Hazard_Unit hazard_unit(.ex_rs1(ex_rs1), .ex_rs2(ex_rs2), .mem_rd(mem_rd), .wb_rd(wb_rd), .mem_reg_write(mem_reg_write), .is_branch(is_branch), .jum(jum) 
   , .wb_reg_write(wb_reg_write), .fwda_select(fwda_select), .fwdb_select(fwdb_select), .flush(flush));
endmodule
