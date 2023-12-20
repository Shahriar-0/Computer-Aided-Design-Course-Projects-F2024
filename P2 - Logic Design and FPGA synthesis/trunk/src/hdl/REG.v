module REG #(parameter XLEN = 1) (
    input clock, reset, ld,
    input [XLEN - 1 : 0] in,

    output reg [XLEN - 1 : 0] out
);
    
    __ACT_S2 #(XLEN) regact(clock, reset, out, in, 0, 0, 0, 0, ld, 1, out);

endmodule