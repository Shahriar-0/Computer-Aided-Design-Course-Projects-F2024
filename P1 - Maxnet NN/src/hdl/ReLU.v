module ReLU #(parameter XLEN = 32)
            (input wire [XLEN - 1:0] in,
             output wire [XLEN - 1:0] out);
    
    assign out = in[XLEN - 1]? 32'd0 : in;
    
endmodule
    
