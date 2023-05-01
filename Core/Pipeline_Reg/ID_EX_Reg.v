`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2023 01:38:08 AM
// Design Name: 
// Module Name: ID_EX_Reg
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


module ID_EX_Reg(
    input wire clk, resetn,
    input wire [31:0] i_id_pc, i_id_pc4, i_id_rd1, i_id_rd2, i_id_imm,
    input wire [4:0] i_id_alu_op, i_id_rs1, i_id_rs2, i_id_rd,
    input wire [1:0] i_id_select_data_wb, i_id_branch_type,
    input wire i_id_slt_instr, i_id_is_branch, i_id_reg_write, i_id_mem_write, i_id_jum, i_id_lsb, i_id_lsh
    , i_id_compare_signed, i_id_select_alu_a, i_id_select_alu_b, i_id_select_data_compare, i_id_load_signext,
    output reg [31:0] o_ex_pc, o_ex_pc4, o_ex_rd1, o_ex_rd2, o_ex_imm,
    output reg [4:0] o_ex_alu_op, o_ex_rs1, o_ex_rs2, o_ex_rd,
    output reg [1:0] o_ex_select_data_wb, o_ex_branch_type,
    output reg o_ex_slt_instr, o_ex_is_branch, o_ex_reg_write, o_ex_mem_write, o_ex_jum, o_ex_lsb, o_ex_lsh
    , o_ex_compare_signed, o_ex_select_alu_a, o_ex_select_alu_b, o_ex_select_data_compare, o_ex_load_signext
    );
    
    always @(posedge clk or negedge resetn) begin
        if(!resetn) begin
            o_ex_pc <= 32'd0;
            o_ex_pc4 <= 32'd0;
            o_ex_rd1 <= 32'dx;
            o_ex_rd2 <= 32'dx;
            o_ex_imm <= 32'dx;
            o_ex_rs1 <= 5'd0;
            o_ex_rs2 <= 5'd0;
            o_ex_rd  <= 5'd0;
            o_ex_alu_op <= 5'd0;
            o_ex_select_data_wb <= 2'd0;
            o_ex_branch_type  <= 2'd0;
            o_ex_slt_instr <= 1'b0;
            o_ex_is_branch <= 1'b0;
            o_ex_reg_write <= 1'b0;
            o_ex_mem_write <= 1'b0;
            o_ex_jum <= 1'b0;
            o_ex_lsb <= 1'b0;
            o_ex_lsh <= 1'b0;
            o_ex_compare_signed <= 1'b0;
            o_ex_select_alu_a <= 1'b0;
            o_ex_select_alu_b <= 1'b0;
            o_ex_select_data_compare <= 1'b0;
            o_ex_load_signext <= 1'b0;
        end
        else begin
            o_ex_pc <= i_id_pc;
            o_ex_pc4 <= i_id_pc4;
            o_ex_rd1 <= i_id_rd1;
            o_ex_rd2 <= i_id_rd2;
            o_ex_imm <= i_id_imm;
            o_ex_rs1 <= i_id_rs1;
            o_ex_rs2 <= i_id_rs2;
            o_ex_rd  <= i_id_rd;
            o_ex_alu_op <= i_id_alu_op;
            o_ex_select_data_wb <= i_id_select_data_wb;
            o_ex_branch_type  <= i_id_branch_type;
            o_ex_slt_instr <= i_id_slt_instr;
            o_ex_is_branch <= i_id_is_branch;
            o_ex_reg_write <= i_id_reg_write;
            o_ex_mem_write <= i_id_mem_write;
            o_ex_jum <= i_id_jum;
            o_ex_lsb <= i_id_lsb;
            o_ex_lsh <= i_id_lsh;
            o_ex_compare_signed <= i_id_compare_signed;
            o_ex_select_alu_a <= i_id_select_alu_a;
            o_ex_select_alu_b <= i_id_select_alu_b;
            o_ex_select_data_compare <= i_id_select_data_compare;
            o_ex_load_signext <= i_id_load_signext;
        end
    end
    
endmodule
