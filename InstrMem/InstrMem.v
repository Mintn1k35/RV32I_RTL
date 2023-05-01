`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 09:09:32 PM
// Design Name: 
// Module Name: InstrMem
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


module InstrMem(
    input wire [31:0] addr,
    output wire [31:0] instr
    );
    reg [31:0] rom [0:100];

    initial
    begin
        $readmemh("test_program.mem", rom);
    end

    assign instr = rom[addr[31:2]];
endmodule
