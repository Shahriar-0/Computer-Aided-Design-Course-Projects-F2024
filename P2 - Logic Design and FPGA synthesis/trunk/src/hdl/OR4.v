module OR4 (
    input A, B, C, D

    output out
);

    __ACT_C1 or3(A, 1, B, 1, 1, 1, C, D, out);

endmodule