module MUX2 #(parameter XLEN = 5) (
    input [XLEN - 1 : 0] A, B,
    input slc,

    output [XLEN - 1 : 0] out
);

    __ACT_C2 #(XLEN) mux2(A, B, 'bz, 'bz, 0, 0, slc, 1, out);

endmodule