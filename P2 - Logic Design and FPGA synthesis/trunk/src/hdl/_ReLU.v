module ReLU #(parameter XLEN = 32)
            (input wire [XLEN - 1:0] in,
             output wire [XLEN - 1:0] out);
    
    wire [XLEN - 1:0] zero = 32'd0;
    wire sign = in[XLEN - 1];

    __ACT_C1 relu (
        .A0(in), .A1(zero), .SA(sign),
        .B0(in), .B1(zero), .SB(sign),
        .S0(0), .S1(1),
        .out(out)
    );
    
endmodule