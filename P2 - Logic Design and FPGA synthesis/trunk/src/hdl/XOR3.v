module XOR3 (
    input A, B, C,
    output out
);
    wire out1;
    
    XOR2 xor2_1(A, B, out1);
    XOR2 xor2_2(out1, C, out);

endmodule