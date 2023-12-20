module MUX4REGSingle #(parameter XLEN = 1) (
    input clock, reset,
    input [XLEN - 1 : 0] A, B, C, D,
    input [1:0] select,

    output reg [XLEN - 1 : 0] out
);
    
    __ACT_S2 #(XLEN) mux4reg(clock, reset, A, B, C, D, select[1], 0, select[0], 1, out);

endmodule