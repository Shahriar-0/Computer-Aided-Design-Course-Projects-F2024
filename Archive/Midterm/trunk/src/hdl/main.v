`include "main_controller.v"
`include "main_datapath.v"

module Main (clk, rst, start, matrixIn,
             ready, putInput, outReady, matrixOut);
    parameter Count = 64;

    input clk, rst, start;
    input [25-1:0] matrixIn;
    output ready, putInput, outReady;
    output [25-1:0] matrixOut;

    wire adrSrc, regSrc;
    wire pageCntEn, pageCntClr, memRead, memWrite;
    wire regLd, regClr, regShfR;
    wire xorSrc, matCntEn, matCntClr;
    wire colCntEn, colCntClr, colRegShR, colRegClr;
    wire PDParLd, PDParClr;
    wire matCntCo, colCntCo, pageCntCo;

    MainController controller(clk, rst, start, adrSrc, regSrc,
                              pageCntEn, pageCntClr, memRead, memWrite,
                              regLd, regClr, regShfR,
                              xorSrc, matCntEn, matCntClr,
                              colCntEn, colCntClr, colRegShR, colRegClr,
                              PDParLd, PDParClr,
                              matCntCo, colCntCo, pageCntCo,
                              ready, putInput, outReady);

    MainDatapath datapath(clk, rst, adrSrc, regSrc, matrixIn,
                          pageCntEn, pageCntClr, memRead, memWrite,
                          regLd, regClr, regShfR,
                          xorSrc, matCntEn, matCntClr,
                          colCntEn, colCntClr, colRegShR, colRegClr,
                          PDParLd, PDParClr,
                          matCntCo, colCntCo, pageCntCo, matrixOut);
endmodule
