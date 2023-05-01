`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 09:17:34 PM
// Design Name: 
// Module Name: Imm_Decode
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


module Imm_Decode(
    input wire [31:0] instr,
    input wire [6:0] opcode,
    output reg [31:0] o_imm
    );
    
    always @(instr or opcode) begin
        casex(opcode) // check opcode
            7'b0000011: o_imm <= { {20{instr[31]}} , instr[31:20] };                                            // LW
            7'b0100011: o_imm <= { {20{instr[31]}} , instr[31:25] , instr[11:7] };                            // SW
            7'b1101111: o_imm <= { {12{instr[31]}} , instr[19:12] , instr[20] , instr[30:21] , 1'b0 };      // JAL
            7'b1100111: o_imm <= { {20{instr[31]}} , instr[31:20] };                                            // JALR
            7'b1100011: o_imm <= { {20{instr[31]}} , instr[7] , instr[30:25] , instr[11:8] , {1{1'b0}} };   // Branch
            7'b0110111: o_imm <= { instr[31:12], {12'b000000000000} };                                                      // lui
            7'b0010011: 
            begin
                if((instr[14:12] == 3'b001) | (instr[14:12] == 3'b101))                                                           // slli/srli/srlai
                        o_imm <= { {27'b0} , instr[24:20] };
                else 
                    o_imm <= { {20{instr[31]}} , instr[31:20] };                                                // ADDI/ANDI/ORI/XORI                                            
            end
            7'b0010111: o_imm <= {instr[31:12], 12'd0}; // auipc
            default: o_imm <= 32'bx;
        endcase
    end
endmodule
