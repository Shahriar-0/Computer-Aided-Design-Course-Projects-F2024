`include "colparity_controller.v"
`include "colparity_datapath.v"

module ColParity (clk, rst, start, in,
                  ready, putInput, outReady, out);
    parameter Count = 64;

    input clk, rst, start;
    input [25-1:0] in;
    output ready, putInput, outReady;
    output [25-1:0] out;

    wire adrSrc, regSrc;
    wire sliceCntEn, sliceCntClr, memRead, memWrite;
    wire regLd, regClr, regShfR;
    wire xorSrc, matCntEn, matCntClr;
    wire colCntEn, colCntClr, colRegShR, colRegClr;
    wire PDParLd, PDParClr;
    wire matCntCo, colCntCo, sliceCntCo;

    ColParityController ctrl(clk, rst, start, adrSrc, regSrc,
                             sliceCntEn, sliceCntClr, memRead, memWrite,
                             regLd, regClr, regShfR,
                             xorSrc, matCntEn, matCntClr,
                             colCntEn, colCntClr, colRegShR, colRegClr,
                             PDParLd, PDParClr,
                             matCntCo, colCntCo, sliceCntCo,
                             ready, putInput, outReady);

    ColParityDatapath dp(clk, rst, adrSrc, regSrc, in,
                         sliceCntEn, sliceCntClr, memRead, memWrite,
                         regLd, regClr, regShfR,
                         xorSrc, matCntEn, matCntClr,
                         colCntEn, colCntClr, colRegShR, colRegClr,
                         PDParLd, PDParClr,
                         matCntCo, colCntCo, sliceCntCo, out);
endmodule
