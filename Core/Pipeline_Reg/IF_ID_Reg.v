module IF_ID_Reg(
    input wire clk, resetn, flush,
    input wire [31:0] i_if_instr, i_if_pc4, i_if_pc,
    output reg [31:0] o_id_instr, o_id_pc4, o_id_pc
    );
    
    always @(posedge clk or negedge resetn) begin
        if(!resetn) begin
            o_id_pc <= 32'd0;
            o_id_instr <= 32'd0;
            o_id_pc4 <= 32'd0;
        end
        else if(flush) begin
            o_id_pc <= i_if_pc;
            o_id_pc4 <= i_if_pc4;
            o_id_instr <= 32'h00007013; // andi x0, x0, 0
        end
        else begin
            o_id_pc <= i_if_pc;
            o_id_instr <= i_if_instr;
            o_id_pc4 <= i_if_pc4;
        end
    end
    
endmodule