`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 08:53:50 PM
// Design Name: 
// Module Name: PC_Unit
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


module PC_Unit(
    input wire clk, resetn, pcsrc,
    input wire [31:0] i_pc_target,
    output wire [31:0] o_pc4, o_pc
    );
    
    reg [31:0] pc_reg;
    wire [31:0] o_pc_select;
    // Mux 2 to 1 select pc address for next instruction
    Mux2to1 pc_select(.a(o_pc4), .b(i_pc_target), .select(pcsrc), .out(o_pc_select));
    
    // pc register
    always @(posedge clk or negedge resetn) begin
        if(!resetn) pc_reg <= 32'd0;
        else pc_reg <= o_pc_select;
    end
    assign o_pc = pc_reg;
    
    // increase 4 for pc
    Full_Adder_32 pc_adder_4(.a(pc_reg), .b(32'd4), .c_in(1'b0), .c_out(), .sum(o_pc4));
endmodule 
