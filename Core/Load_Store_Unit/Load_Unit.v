module Load_Unit(
    input wire [31:0] data_in,
    input wire lb,
    input wire lh,
    input wire load_signext,
   output reg [31:0] data_out
    );
     
    always @(*) begin
        casez({lb, lh, load_signext})
            3'b00?: data_out = data_in;                             // lw
            3'b100: data_out =  {24'd0, data_in[7:0]};              // lbu
            3'b101: data_out = {{24{data_in[7]}}, data_in[7:0]};    // lb
            3'b010: data_out = {16'd0, data_in[15:0]};              // lhu
            3'b011: data_out = {{16{data_in[15]}}, data_in[15:0]};  // lh
            default: data_out = data_in;
        endcase
    end
    
endmodule