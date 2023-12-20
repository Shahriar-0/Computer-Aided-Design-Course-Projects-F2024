module BUF (
    input A,

    output out
);

    __ACT_C1 and3(0, 0, 0, 0, 1, 1, A, 0, out);

endmodule