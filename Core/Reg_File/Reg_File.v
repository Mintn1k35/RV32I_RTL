`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 09:15:13 PM
// Design Name: 
// Module Name: Reg_File
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


module Reg_File(
    input wire clk, resetn,
    input wire [4:0] rs1, rs2, rd, // register source 1, 2; register destination
    input wire reg_write,
    input wire [31:0] write_data,
    output wire [31:0] rd1, rd2
    );
    integer i;
    reg [31:0] reg_file [0:31]; 

    // write data
    always @(posedge clk or negedge resetn)
    begin
        if(!resetn)
            for (i= 0; i<32; i = i+1)
                reg_file[i] <= 0;
        else if(reg_write & (rd != 0))
            reg_file[rd] <= write_data; 
    end 

    // read data
    assign rd1 = (rs1 == 0) ? 0 : reg_file[rs1]; // reg_file[0] hardwired to 0
    assign rd2 = (rs2 == 0) ? 0 : reg_file[rs2];
endmodule
