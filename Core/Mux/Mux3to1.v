`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2023 10:08:16 AM
// Design Name: 
// Module Name: Mux3to1
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


module Mux3to1(
    input wire [31:0] a, b, c,
    input wire [1:0] select,
    output reg [31:0] out
    );
    
    always @(*) begin
        casex(select)
            2'b00: out = a;
            2'b01: out = b;
            2'b10: out = c;
            default: out = 32'd0;
        endcase
    end
    
endmodule
