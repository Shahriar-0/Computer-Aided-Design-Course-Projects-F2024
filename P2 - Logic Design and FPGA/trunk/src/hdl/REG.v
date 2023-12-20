module REG #(parameter XLEN = 5) (
    input clk, rst, ld,
    input [XLEN - 1 : 0] in,

    output [XLEN - 1 : 0] out
);

    __ACT_S2 #(XLEN) reg_0 (
      .clk(clk), .rst(rst), 
      .D00(out), .D01(in), .D10('bz), .D11('bz), 
      .A1(0), .B1(0), .A0(ld), .B0(1), .out(out)
    );

endmodule
