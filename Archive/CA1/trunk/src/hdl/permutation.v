`include "permutation_controller.v"
`include "permutation_datapath.v"

module Permutation (clk, rst, start, matrixIn,
                    ready, putInput, outReady, matrixOut);
    parameter N = 5;
    parameter Count = 64;

    input clk, rst, start;
    input [(N*N)-1:0] matrixIn;
    output ready, putInput, outReady;
    output [(N*N)-1:0] matrixOut;

    wire ldReg, selRes;
    wire cntEn, cntCo, cntClr;

    PermutationController cu(
        .clk(clk),
        .rst(rst),
        .start(start),
        .ldReg(ldReg),
        .selRes(selRes),
        .cntEn(cntEn),
        .cntCo(cntCo),
        .cntClr(cntClr),
        .ready(ready),
        .putInput(putInput),
        .outReady(outReady)
    );

    PermutationDatapath #(N, Count) dp(
        .clk(clk),
        .rst(rst),
        .ldReg(ldReg),
        .cntEn(cntEn),
        .cntClr(cntClr),
        .selRes(selRes),
        .matrixIn(matrixIn),
        .cntCo(cntCo),
        .matrixOut(matrixOut)
    );
endmodule
