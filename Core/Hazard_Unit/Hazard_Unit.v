`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2023 07:05:16 PM
// Design Name: 
// Module Name: Hazard_Unit
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


module Hazard_Unit(
    input wire [4:0] ex_rs1, ex_rs2, mem_rd, wb_rd,
    input wire mem_reg_write, wb_reg_write, is_branch, jum,
    output reg [1:0] fwda_select, fwdb_select,
    output wire flush
    );
    
    assign flush = is_branch | jum;
    always @(*) begin
        // Forwarding for in_a of ALU
        if ((mem_rd == ex_rs1) & (mem_reg_write == 1'b1) & (ex_rs1 != 5'd0)) fwda_select = 2'b01;
        else if((wb_rd == ex_rs1) & (wb_reg_write == 1'b1) & (ex_rs1 != 5'd0)) fwda_select = 2'b10;
        else fwda_select = 2'b00;
        
        // Forwarding for in_b of ALU
        if((mem_rd == ex_rs2) & (mem_reg_write == 1'b1) & (ex_rs2 != 5'd0)) fwdb_select = 2'b01;
        else if((wb_rd == ex_rs2) & (wb_reg_write == 1'b1) & (ex_rs2 != 5'd0)) fwdb_select = 2'b10;
        else fwdb_select = 2'b00;
        
        
    end
    
endmodule
