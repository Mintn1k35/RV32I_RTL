`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 09:41:05 PM
// Design Name: 
// Module Name: DataMem
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


module DataMem(
    input wire clk, we,
    input wire [31:0] i_data,
    input wire [31:0] addr,
    output wire [31:0] o_data
    );
    
    reg [31:0] ram [0:31];

    always @(posedge clk)
    begin
        if(we)
            ram[addr[4:0]] = i_data;
    end
    
    integer i;
    initial
    begin
        for(i=0;i<32;i=i+1)
            ram[i] = 0;
    end
    
    assign o_data = ram[addr[4:0]];
endmodule
