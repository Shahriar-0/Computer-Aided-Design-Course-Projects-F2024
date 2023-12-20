module Comparator (
    input [2:0] A,
    input [2:0] B,
    
    output out
);

    wire X0, X1, X2;
    wire B0not, B1not, B2not;

    NOT notB_1(B[0], B0not);
    NOT notB_2(B[1], B1not);
    NOT notB_3(B[2], B2not);

    XOR2 XOR_1(A[0], B0not, X0);
    XOR2 XOR_2(A[1], B1not, X1);
    XOR2 XOR_3(A[2], B2not, X2);

    AND3 and3_1(X0, X1, X2, out);

endmodule
