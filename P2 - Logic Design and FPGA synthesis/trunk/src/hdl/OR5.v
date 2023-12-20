module OR5 (
    input A, B, C, D, E, 

    output out
);

    wire w;
    OR3 or3(A, B, C, w);
    OR3 or4(w, D, E, out);

endmodule