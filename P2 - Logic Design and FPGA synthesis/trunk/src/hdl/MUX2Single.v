module MUX2Single #(parameter XLEN = 1) (
    input [XLEN - 1 : 0] A, B,
    input select,

    output [XLEN - 1 : 0] out
);

    __ACT_C2 #(XLEN) mux2(A, B, 0, 0, 0, 0, select, 1, out);

endmodule