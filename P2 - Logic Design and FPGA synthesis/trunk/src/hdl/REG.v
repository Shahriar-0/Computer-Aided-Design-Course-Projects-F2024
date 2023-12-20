module REG #(parameter XLEN = 1) (
    input clock, reset, enable,
    input [XLEN - 1 : 0] in,

    output reg [XLEN - 1 : 0] out
);
    
    __ACT_S2 #(XLEN) regact(clock, reset, out, in, 0, 0, 0, 0, enable, 1, out);

endmodule