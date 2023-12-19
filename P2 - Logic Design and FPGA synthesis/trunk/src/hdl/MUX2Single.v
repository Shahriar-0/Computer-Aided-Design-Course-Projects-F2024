module MUX2Single #(parameter bits = 1) (
    input [bits - 1 : 0] A, B,
    input select,

    output [bits - 1 : 0] out
);

    __ACT_C2 #(bits) mux2(A, B, 0, 0, 0, 0, select, 1, out);

endmodule