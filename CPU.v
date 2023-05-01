`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2023 10:30:03 AM
// Design Name: 
// Module Name: CPU
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


module CPU(
    input wire clk, resetn,
    output wire [31:0] pc, instr
    );
    
    // Instruction memory
    InstrMem instrmem(.addr(pc), .instr(instr));
    
    // Core
    wire [31:0] mem_data, addr_mem, data_mem;
    wire mem_write;
    Core core(.clk(clk), .resetn(resetn), .mem_data(mem_data), .instr(instr),.addr_mem(addr_mem), .data_mem(data_mem), .o_pc(pc), .o_mem_write(mem_write));
    
    // Data Memory
    DataMem datamem(.clk(clk), .we(mem_write), .i_data(data_mem), .addr(addr_mem), .o_data(mem_data));
endmodule
