module NOT #(parameter XLEN = 1) ( 
    input [XLEN - 1 : 0] A,
    
    output [XLEN - 1 : 0] out
);

    genvar i;
    generate
        for (i = 0; i < XLEN; i = i + 1)
            __ACT_C1 _NOT(1, 1, 1, 0, 0, 0, A[i], 0, out[i]);
    endgenerate

endmodule
