`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 09:43:30 PM
// Design Name: 
// Module Name: Control_Unit
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


module Control_Unit(
    input wire [6:0] opcode,
    input wire [6:0] funct7,
    input wire [2:0] funct3,
    input wire resetn,
    output reg [4:0] alu_op,
    output reg [1:0] select_data_wb,
    output reg [1:0] branch_type,
    output reg slt_instr, reg_write, is_branch, jum, mem_write, ls_b, ls_h
    , compare_signed, select_alu_a, select_alu_b, select_data_compare, load_signext
    );
    
    always @(negedge resetn) begin
        alu_op = 5'bxxxxx;
        select_data_wb = 2'bxx;
        slt_instr = 1'b0;
        reg_write = 1'b0;
        branch_type = 2'bxx;
        is_branch = 1'b0;
        jum = 1'b0;
        mem_write = 1'b0;
        compare_signed = 1'bx;
        select_alu_a = 1'bx;
        select_alu_b = 1'bx;
        select_data_compare = 1'bx;
        ls_b = 1'bx;
        ls_h = 1'bx;
        load_signext = 1'bx;
    end
    
    always @(*) begin
        case(opcode)
            7'b0110011: begin // R-type
                reg_write = 1'b1;
                mem_write = 1'b0;
                is_branch = 1'b0;
                jum = 1'b0;
                select_data_wb = 2'b00;
                select_alu_a = 1'b0;
                select_alu_b = 1'b0;
                ls_b = 1'b0;
                ls_h = 1'b0;
                load_signext = 1'bx;
                slt_instr = 1'b0;
                    case(funct7)
                        7'b0000000: begin
                            case(funct3)
                                3'b000: alu_op = 5'b0x000; // add
                                3'b001: alu_op = 5'b00001; // sll
                                3'b010: begin              // slt
                                    compare_signed = 1'b1;
                                    slt_instr = 1'b1;
                                    select_data_compare = 1'b0;
                                    alu_op = 5'bxxxxx;
                                end
                                3'b011: begin              // sltu
                                    compare_signed = 1'b0;
                                    slt_instr = 1'b1;
                                    select_data_compare = 1'b0;
                                    alu_op = 5'bxxxxx;
                                end
                                3'b100: alu_op = 5'bxx100; // xor
                                3'b101: alu_op = 5'b01001; // srl
                                3'b110: alu_op = 5'bxx110; // or
                                3'b111: alu_op = 5'bxx111; // and
                            endcase
                        end
                        7'b0100000: begin // sra/sub
                            case(funct3)
                                3'b000: alu_op = 5'b1x000; // sub
                                3'b101: alu_op = 5'b1x001; // sra
                            endcase
                        end
                    endcase
            end
            7'b0010011: begin // I-type
                reg_write = 1'b1;
                mem_write = 1'b0;
                is_branch = 1'b0;
                jum = 1'b0;
                select_data_wb = 2'b00;
                select_alu_a = 1'b0;
                select_alu_b = 1'b1;
                ls_b = 1'b0;
                ls_h = 1'b0;
                load_signext = 1'bx;
                slt_instr = 1'b0;
                case(funct3)
                    3'b000: alu_op = 5'b0x000; // addi
                    3'b010: begin              // slti
                        compare_signed = 1'b1;
                        slt_instr = 1'b1;
                        select_data_compare = 1'b1;
                        alu_op = 5'bxxxxx;
                    end
                    3'b011: begin               // sltiu
                        compare_signed = 1'b0;
                        select_data_compare = 1'b1;
                        alu_op = 5'bxxxxx; 
                        slt_instr = 1'b1;
                    end
                    3'b100: alu_op = 5'bxx100; // xori
                    3'b110: alu_op = 5'bxx110; // ori
                    3'b111: alu_op = 5'bxx111; // andi
                    3'b001:begin               // slli
                        alu_op = 5'b00001; 
                    end
                    3'b101:                 // sr
                    begin
                        case(funct7)
                            7'b0000000: alu_op = 5'b01001; // srli
                            7'b0100000: alu_op = 5'b1x001; // srai
                            default:    alu_op = 5'bxxxxx;
                        endcase
                    end             
                endcase
            end
            7'b1100011: begin // B-type
                alu_op = 5'b0x000;
                select_data_wb = 2'bxx;
                slt_instr = 1'b0;
                reg_write = 1'b0;
                is_branch = 1'b1;
                jum = 1'b0;
                mem_write = 1'b0;
                select_alu_a = 1'b1;
                select_alu_b = 1'b1;
                select_data_compare = 1'b0;
                ls_b = 1'b0;
                ls_h = 1'b0;
                load_signext = 1'bx;
                case(funct3)
                    3'b000:begin  // beg
                        compare_signed = 1'b1;
                        branch_type = 2'b00;
                    end
                    3'b001: begin // bne
                        compare_signed = 1'b1;
                        branch_type = 2'b01;
                    end
                    3'b100: begin // blt
                        compare_signed = 1'b1;
                        branch_type = 2'b10;
                    end
                    3'b101: begin // bge
                        compare_signed = 1'b1;
                        branch_type = 2'b11;
                    end
                    3'b110: begin // bltu
                        compare_signed = 1'b0;
                        branch_type = 2'b10;
                    end
                    3'b111: begin // bgeu
                        compare_signed = 1'b0;
                        branch_type = 2'b11;
                    end
                    default: begin
                        compare_signed = 1'b1;
                        branch_type = 2'bxx;
                    end
                endcase
            end
            7'b0000011: begin // Load-type
                alu_op = 5'b0x000;
                select_data_wb = 2'b01;
                slt_instr = 1'b0;
                reg_write = 1'b1;
                is_branch = 1'b0;
                jum = 1'b0;
                mem_write = 1'b0;
                select_alu_a = 1'b0;
                select_alu_b = 1'b1;
                select_data_compare = 1'bx;
                
                case(funct3)
                     3'b000: begin // lb
                        ls_b         = 1'b1;
                        ls_h         = 1'b0;
                        load_signext = 1'b1;
                     end
                     3'b001: // lh
                    begin
                        ls_b         = 1'b0;
                        ls_h         = 1'b1;
                        load_signext = 1'b1;
                    end
                    3'b010: // lw
                    begin
                        ls_b         = 1'b0;
                        ls_h         = 1'b0;
                        load_signext = 1'b0;
                    end
                    3'b100: // lbu
                    begin
                        ls_b         = 1'b1;
                        ls_h         = 1'b0;
                        load_signext = 1'b0;
                    end
                    3'b101: // lhu
                    begin
                        ls_b         = 1'b0;
                        ls_h         = 1'b1;
                        load_signext = 1'b0;
                    end
                endcase
            end
            7'b0100011: begin //Store-Type
                alu_op = 5'b0x000;
                select_data_wb = 2'bxx;
                slt_instr = 1'b0;
                reg_write = 1'b0;
                branch_type = 2'bxx;
                is_branch = 1'b0;
                jum = 1'b0;
                mem_write = 1'b1;
                compare_signed = 1'bx;
                select_alu_a = 1'b0;
                select_alu_b = 1'b1;
                select_data_compare = 1'bx;
                load_signext = 1'bx;
                
                case(funct3)
                    3'b000: // sb
                    begin
                        ls_b = 1'b1;
                        ls_h = 1'b0;
                    end
                    3'b001: // sh
                    begin
                        ls_b = 1'b0;
                        ls_h = 1'b1;
                    end
                    default: // sw
                    begin
                        ls_b = 0;
                        ls_h = 0;
                    end
                endcase
            end
            7'b0110111: begin // lui
                alu_op = 5'bxx010;
                select_data_wb = 2'b00;
                slt_instr = 1'b0;
                reg_write = 1'b1;
                branch_type = 2'bxx;
                is_branch = 1'b0;
                jum = 1'b0;
                mem_write = 1'b0;
                compare_signed = 1'bx;
                select_alu_a = 1'b0;
                select_alu_b = 1'b1;
                select_data_compare = 1'bx;
                load_signext = 1'bx;
            end
            7'b0010111: begin // auipc
                alu_op = 5'b0x000;
                select_data_wb = 2'b00;
                slt_instr = 1'b0;
                reg_write = 1'b1;
                branch_type = 2'bxx;
                is_branch = 1'b0;
                jum = 1'b0;
                mem_write = 1'b0;
                compare_signed = 1'bx;
                select_alu_a = 1'b1;
                select_alu_b = 1'b1;
                select_data_compare = 1'bx;
                load_signext = 1'bx;
            end
            7'b1101111: begin // jal
                alu_op = 5'b0x000;
                select_data_wb = 2'b10;
                slt_instr = 1'b0;
                reg_write = 1'b1;
                branch_type = 2'bxx;
                is_branch = 1'b0;
                jum = 1'b1;
                mem_write = 1'b0;
                compare_signed = 1'bx;
                select_alu_a = 1'b1;
                select_alu_b = 1'b1;
                select_data_compare = 1'bx;
                load_signext = 1'bx;
            end
            7'b1100111: begin // jalr
                alu_op = 5'b0x000;
                select_data_wb = 2'b10;
                slt_instr = 1'b0;
                reg_write = 1'b1;
                branch_type = 2'bxx;
                is_branch = 1'b0;
                jum = 1'b1;
                mem_write = 1'b0;
                compare_signed = 1'bx;
                select_alu_a = 1'b0;
                select_alu_b = 1'b1;
                select_data_compare = 1'bx;
                load_signext = 1'bx;
            end
            default: begin
                alu_op = 5'bxxxxx;
                select_data_wb = 2'bxx;
                slt_instr = 1'bx;
                reg_write = 1'bx;
                branch_type = 2'bxx;
                is_branch = 1'b0;
                jum = 1'b0;
                mem_write = 1'bx;
                compare_signed = 1'bx;
                select_alu_a = 1'bx;
                select_alu_b = 1'bx;
                select_data_compare = 1'bx;
                load_signext = 1'bx;
            end
        endcase
    end
    
endmodule
