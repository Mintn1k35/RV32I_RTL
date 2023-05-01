`timescale 1ns/1ps

module Store_Unit(
    input wire [31:0] data_in,
    input wire sb,
    input wire sh,
   output reg [31:0] data_out
);
    
    always @(*) begin
        casez({sb, sh}) 
            2'b00: data_out = data_in;                 // sw
            2'b01: data_out = {16'd0, data_in[15:0]};   // sh
            2'b10: data_out = {24'd0, data_in[7:0]};    // sb
            default: data_out = data_in;
        endcase
    end

endmodule