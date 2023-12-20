module ReLU #(parameter XLEN = 5) (
    input wire [XLEN - 1:0] in,

    output wire [XLEN - 1:0] out
);
    
    // assign out = in[XLEN - 1]? 32'd0 : in;
    
    MUX2 #(XLEN) mux(in, 0, in[XLEN - 1], out);

endmodule
    
