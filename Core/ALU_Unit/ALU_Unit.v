`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 09:38:56 PM
// Design Name: 
// Module Name: ALU_Unit
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


module ALU_Unit(
    input wire [31:0] a,
    input wire [31:0] b,
    input wire [4:0] alu_op,
    output reg [31:0] result
    );
    
    wire [31:0] and_result, or_result, xor_result, shift_result, adder_result;
    wire c_out;
    assign and_result = a & b;
    assign xor_result = a ^ b;
    assign or_result = a | b;
    
    Shift shift(a, b[4:0], alu_op[3], alu_op[4], shift_result);
    Full_Adder_32 adder(a, b, alu_op[4], c_out,adder_result);
    
    always @(*) begin
        casex(alu_op[2:0])
            3'b000: result = adder_result;
            3'b001: result = shift_result;
            3'b010: result = b;
            3'b100: result = xor_result;
            3'b110: result = or_result;
            3'b111: result = and_result;
            default: result = 32'bx;
        endcase
    end
endmodule
