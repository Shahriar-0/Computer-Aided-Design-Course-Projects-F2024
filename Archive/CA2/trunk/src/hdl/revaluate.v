`include "revaluate_datapath.v"
`include "revaluate_controller.v"

module Revaluate (clk, rst, in, start, out, outReady, ready, putInput);
    input clk, rst, start;
    input [24:0] in;
    output [24:0] out;
    output outReady, ready, putInput;

    wire rowCntClr, rowCntEn, rowCntCo, colCntClr, colCntEn, colCntCo, ldReg, clrReg, shL, clrOut;

    RevaluateDatapath dp(.clk(clk), .rst(rst), .in(in), .rowCntClr(rowCntClr), .rowCntEn(rowCntEn), .rowCntCo(rowCntCo),
                         .colCntClr(colCntClr), .colCntEn(colCntEn), .colCntCo(colCntCo), .ldReg(ldReg), .clrReg(clrReg),
                         .shL(shL), .clrOut(clrOut), .out(out));
    RevaluateController ctrl(.clk(clk), .rst(rst), .start(start), .rowCntCo(rowCntCo), .colCntCo(colCntCo), .ldReg(ldReg),
                             .clrReg(clrReg), .rowCntClr(rowCntClr), .rowCntEn(rowCntEn), .colCntClr(colCntClr),
                             .colCntEn(colCntEn), .shL(shL), .clrOut(clrOut), .outReady(outReady), .ready(ready),
                             .putInput(putInput));
endmodule
