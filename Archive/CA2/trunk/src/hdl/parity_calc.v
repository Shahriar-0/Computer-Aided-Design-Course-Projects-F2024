`include "colparity_calc.v"
`include "mux.v"
`include "register.v"
`include "counter_modn.v"

module ParityCalc(clk, rst, xorSrc, regInp,
                  matCntEn, matCntClr,
                  colCntEn, colCntClr, colRegShR, colRegClr,
                  PDParLd, PDParClr,
                  matCntCo, colCntCo, out);
    input clk, rst, xorSrc;
    input [24:0] regInp;
    input matCntEn, matCntClr;
    input colCntEn, colCntClr, colRegShR, colRegClr;
    input PDParLd, PDParClr;
    output matCntCo, colCntCo, out;

    wire [4:0] colPar, PDParOut;
    wire [4:0] matCntOut;
    wire [2:0] colNum;
    wire currColPar, currColParQ, prevColPar;

    CounterModN #(25) matCntr(
        .clk(clk),
        .rst(rst),
        .clr(matCntClr),
        .en(matCntEn),
        .q(matCntOut),
        .co(matCntCo)
    );

    function [4:0] getColIdx;
        input [4:0] linearIdx;
        getColIdx = linearIdx % 5;
    endfunction

    assign colNum = getColIdx(matCntOut);

    ColParityCalc colparCalc(
        .clk(clk),
        .rst(rst),
        .cntEn(colCntEn),
        .cntClr(colCntClr),
        .shfEn(colRegShR),
        .shfClr(colRegClr),
        .inputReg(regInp),
        .cntCo(colCntCo),
        .out(colPar)
    );

    Register #(5) PDParity(
        .clk(clk),
        .rst(rst),
        .clr(PDParClr),
        .ld(PDParLd),
        .din(colPar),
        .dout(PDParOut)
    );

    Mux8to1 #(1) muxPrev(
        .sel((colNum + 4) % 5),
        .a0(PDParOut[0]),
        .a1(PDParOut[1]),
        .a2(PDParOut[2]),
        .a3(PDParOut[3]),
        .a4(PDParOut[4]),
        .out(prevColPar)
    );

    Mux8to1 #(1) muxCurr(
        .sel((colNum + 1) % 5),
        .a0(colPar[0]),
        .a1(colPar[1]),
        .a2(colPar[2]),
        .a3(colPar[3]),
        .a4(colPar[4]),
        .out(currColPar)
    );

    Mux2to1 #(1) muxCurrQ(
        .sel(xorSrc),
        .a0(currColPar),
        .a1(1'b0),
        .out(currColParQ)
    );

    xor outputx(out, regInp[0], prevColPar, currColParQ);
endmodule
