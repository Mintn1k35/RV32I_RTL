`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2023 02:09:13 AM
// Design Name: 
// Module Name: Check_Branch
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


module Check_Branch(
    input wire [1:0] branch_type,
    input wire is_eq, is_lt, is_branch,
    output reg yes
    );
    
    always @(*) begin
        if(is_branch) begin
            case(branch_type)
                2'b00: yes <= (is_eq) ? 1'b1 : 1'b0; // be
                2'b01: yes <= (~is_eq) ? 1'b1 : 1'b0; // bne
                2'b10: yes <= (is_lt) ? 1'b1 : 1'b0; // blt
                2'b11: yes <= (~is_lt) ? 1'b1 : 1'b0; // bge
                default: yes <= 1'b0;
            endcase
         end
         else yes <= 1'b0;
    end
    
endmodule
