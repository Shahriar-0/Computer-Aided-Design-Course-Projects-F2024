module ReLU(input wire [31:0] in,
            output wire [31:0] out);
assign out = in[31]? 32'd0 : in;
endmodule

