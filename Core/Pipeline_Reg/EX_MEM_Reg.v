module EX_MEM_Reg(
    input wire clk, resetn,
    input wire i_ex_reg_write, i_ex_mem_write, i_ex_lsb, i_ex_lsh, i_ex_load_signext,
    input wire [31:0] i_ex_data_mem, i_ex_pc4, i_ex_data_ex_wb,
    input wire [4:0] i_ex_rd, 
    input wire [1:0] i_ex_select_data_wb,
    output reg o_mem_reg_write, o_mem_mem_write, o_mem_lsb, o_mem_lsh, o_mem_load_signext,
    output reg [31:0] o_mem_data_mem, o_mem_pc4, o_mem_data_ex_wb,
    output reg [4:0] o_mem_rd, 
    output reg [1:0] o_mem_select_data_wb
);
    always @(posedge clk or negedge resetn) begin
        if(!resetn) begin
            o_mem_load_signext <= 1'b0;
            o_mem_reg_write <= 1'b0;
            o_mem_mem_write <= 1'b0;
            o_mem_lsb <= 1'b0;
            o_mem_lsh <= 1'b0;
            o_mem_data_mem <= 32'd0;
            o_mem_pc4 <= 32'd0;
            o_mem_rd <= 5'd0;
            o_mem_select_data_wb <= 2'd0;
            o_mem_data_ex_wb <= 32'd0;
        end
        else begin
            o_mem_load_signext <= i_ex_load_signext;
            o_mem_reg_write <= i_ex_reg_write;
            o_mem_mem_write <= i_ex_mem_write;
            o_mem_lsb <= i_ex_lsb;
            o_mem_lsh <= i_ex_lsh;
            o_mem_data_mem <= i_ex_data_mem;
            o_mem_pc4 <= i_ex_pc4;
            o_mem_rd <= i_ex_rd;
            o_mem_select_data_wb <= i_ex_select_data_wb;
            o_mem_data_ex_wb <= i_ex_data_ex_wb;
        end
    end
endmodule