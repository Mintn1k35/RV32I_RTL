`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 09:35:58 PM
// Design Name: 
// Module Name: Compare_Unit
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


module Compare_Unit(
    input wire [31:0] a, b, 
    input wire compare_signed, // if(unsigned operation) => 1 ; else => 0
    output a_lt_b, a_eq_b // output a less-than b | a equal-to b
    );
    
    assign a_eq_b = (a == b) ? 1'b1 : 1'b0;
    wire temp1, temp2;
    assign temp1 = ( a < b ) ? 1'b1 : 1'b0;
    assign temp2 = ( $signed(a) < $signed(b) ) ? 1'b1 : 1'b0;
    assign a_lt_b = (compare_signed) ? temp2 : temp1;
endmodule
