module AND4NOT4 (
    input A, B, C, D, // ~A & ~B & ~C & ~D

    output out
);

    wire notA;
    NOT not(A, notA);
    __ACT_C2 and4not4(1, 1, 1, notA, 0, B, C, D, out);

endmodule