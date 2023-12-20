module AND4NOT3 (
    input A0, A1, B0, B1, // A0 & ~A1 & ~B0, ~B1

    output out
);

    __ACT_C2 and4not3(A0, 0, 0, 0, A1, B0, 1, B1, out); 

endmodule