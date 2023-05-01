`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2023 10:42:20 AM
// Design Name: 
// Module Name: cpu_tb
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


module cpu_tb();
    logic clk, resetn;
    logic [31:0] instr, pc;
    
    CPU cpu_dut (
        .clk(clk), .resetn(resetn),
        .instr(instr),
        .pc(pc)   
    );
     initial begin
           resetn = 0;
           clk  = 1;
           #20 resetn = 1;
           #20000 $finish; 
    end
    always #10 clk = !clk;
endmodule
