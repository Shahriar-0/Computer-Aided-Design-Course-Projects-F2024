module MUX2 #(parameter XLEN = 2) (
    input [XLEN - 1 : 0] A, B,
    input select,

    output [XLEN - 1 : 0] out
);

    genvar i;
    generate
        for(i = 0; i < XLEN; i = i + 1) begin: mux_loop
            __ACT_C2 #(XLEN) my_mux2(A[i], B[i], 0, 0, 0, 0, select, 1, out[i]);
        end
    endgenerate

endmodule