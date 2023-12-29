module OR2 (
    input A, B,

    output out
);

    OR3 or3 (A, B, 0, out);

endmodule