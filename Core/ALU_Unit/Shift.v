`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 09:37:48 PM
// Design Name: 
// Module Name: Shift
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


module Shift(
    input wire [31:0] a,
    input wire [4:0] amount,
    input wire right,
    input wire arth,
    output reg [31:0] result
    );
    
    always @(*) begin
        if(~right) result = a << amount;
        else if (~arth) result = a >> amount;
        else result = $signed(a) >>> amount;
    end
endmodule
