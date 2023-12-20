module MUX2REGSingle #(parameter XLEN = 2) (
    input clock, reset, enable,
    input A, B,
    input select,

    output reg out
);

    __ACT_S2 #(XLEN) mux2reg(clock, reset, A, B, out, out, enable, 0, select, 1, out);


endmodule