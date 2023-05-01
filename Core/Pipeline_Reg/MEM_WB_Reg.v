module MEM_WB_Reg(
    input wire clk, resetn,
    input wire [31:0] i_mem_data_ex_wb, i_mem_load_data, i_mem_pc4,
    input wire [4:0] i_mem_rd,
    input wire [1:0] i_mem_select_data_wb,
    input wire i_mem_reg_write,
    output reg [31:0] o_wb_data_ex_wb, o_wb_load_data, o_wb_pc4,
    output reg [4:0] o_wb_rd, 
    output reg [1:0] o_wb_select_data_wb,
    output reg o_wb_reg_write
);
    always @(posedge clk or negedge resetn) begin
        if(!resetn) begin
            o_wb_data_ex_wb <= 32'd0;
            o_wb_load_data <= 32'd0;
            o_wb_pc4 <= 32'd0;
            o_wb_rd <= 5'd0;
            o_wb_select_data_wb <= 2'd0;
            o_wb_reg_write <= 1'b0;
        end
        else begin
            o_wb_data_ex_wb <= i_mem_data_ex_wb;
            o_wb_load_data <= i_mem_load_data;
            o_wb_pc4 <= i_mem_pc4;
            o_wb_rd <= i_mem_rd;
            o_wb_select_data_wb <= i_mem_select_data_wb;
            o_wb_reg_write <= i_mem_reg_write;
        end
    end
endmodule