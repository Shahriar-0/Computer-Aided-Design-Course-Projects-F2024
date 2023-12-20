module MUX4 #(parameter XLEN) (
    input [XLEN - 1 : 0] A, B, C, D,
    input [1:0] slc,

    output [XLEN - 1 : 0] out
);
    // S1S0
    //  00 -> A
    //  01 -> B
    //  10 -> C
    //  11 -> D
    
    __ACT_C2 #(XLEN) mux4(A, B, C, D, slc[1], 0, slc[0], 1, out);

endmodule