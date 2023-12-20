module MUX4 #(parameter XLEN = 1) (
    input [XLEN - 1 : 0] A, B, C, D,
    input [1:0] select,

    output [XLEN - 1 : 0] out
);
    
    __ACT_C2 #(XLEN) mux4(A, B, C, D, select[1], 0, select[0], 1, out);

endmodule