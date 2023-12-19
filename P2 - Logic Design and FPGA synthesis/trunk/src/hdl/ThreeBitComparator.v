module ThreeBitComparator(
    input [2:0] A,
    input [2:0] B,
    output Equal 
);
wire d1,d2,d3;
wire equals;
wire not_d1, not_d2, not_d3; 

XOR2 x0(.A(A[0]),.B(B[0]),.out(d1));
XOR2 x1(.A(A[1]),.B(B[1]),.out(d2));
XOR2 x2(.A(A[2]),.B(B[2]),.out(d3));



not i0(not_d0, d0);
not i1(not_d1, d1);
not i2(not_d2, d2);


AND3 A1 (not_d1,not_d2,not_d3,equals);

assign Equal=equals;
 
endmodule