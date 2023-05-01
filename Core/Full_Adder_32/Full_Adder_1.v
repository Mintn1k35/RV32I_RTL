`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 08:51:55 PM
// Design Name: 
// Module Name: Full_Adder_1
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


module Full_Adder_1(
    input wire a,
    input wire b,
    input wire c_in,
    output wire c_out,
    output wire sum
);
    assign sum = a ^ b ^ c_in;
    assign c_out = ((a ^ b) & c_in) | (a & b);
endmodule
