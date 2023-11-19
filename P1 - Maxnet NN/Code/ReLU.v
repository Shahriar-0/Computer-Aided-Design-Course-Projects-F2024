module relu (input wire [31:0] in,
             output wire [31:0] out);
assign out = in[31]? 0 : in;
endmodule

