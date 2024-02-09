`include "permutation_controller.v"
`include "permutation_datapath.v"

module Permutation (clk, rst, start, in,
                    ready, putInput, out);
    parameter N = 5;
    parameter Count = 64;

    input clk, rst, start;
    input [(N*N)-1:0] in;
    output ready, putInput;
    output [(N*N)-1:0] out;

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
        .putInput(putInput)
    );

    PermutationDatapath #(N, Count) dp(
        .clk(clk),
        .rst(rst),
        .ldReg(ldReg),
        .cntEn(cntEn),
        .cntClr(cntClr),
        .selRes(selRes),
        .matrixIn(in),
        .cntCo(cntCo),
        .matrixOut(out)
    );
endmodule
