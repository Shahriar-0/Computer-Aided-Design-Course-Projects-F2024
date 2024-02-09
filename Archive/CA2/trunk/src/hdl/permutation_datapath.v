`include "mux.v"
`include "register.v"
`include "mapper.v"
`include "counter_modn.v"

module PermutationDatapath (clk, rst, ldReg, cntEn, cntClr, selRes, matrixIn,
                            cntCo, matrixOut);
    parameter N = 5;
    parameter Count = 64;
    localparam CntBits = $clog2(Count);

    input clk, rst, ldReg, cntEn, cntClr, selRes;
    input [(N*N)-1:0] matrixIn;
    output cntCo;
    output [(N*N)-1:0] matrixOut;

    wire [(N*N)-1:0] mapOut, muxOut;
    wire [CntBits-1:0] cntOut;

    Mux2to1 #(N*N) matrixInpMux(
        .sel(selRes),
        .a0(matrixIn),
        .a1(mapOut),
        .out(muxOut)
    );

    Register #(N*N) matrixReg(
        .clk(clk),
        .rst(rst),
        .clr(1'b0),
        .ld(ldReg),
        .din(muxOut),
        .dout(matrixOut)
    );

    Mapper #(N) mapper(.in(matrixOut), .out(mapOut));

    CounterModN #(Count) cnt(
        .clk(clk),
        .rst(rst),
        .clr(cntClr),
        .en(cntEn),
        .q(cntOut),
        .co(cntCo)
    );
endmodule
