`include "rotate_datapath.v"
`include "rotate_controller.v"

module Rotate (clk, rst, start, in, out, ready, outReady, putInput);
    input clk, rst, start;
    input [24:0] in;
    output [24:0] out;
    output ready, outReady, putInput;

    wire cntMatrixCo, cntInpCo, cntShfCo, cntTCo,
         rotMemRead, rotMemWrite, rotMemSel,
         cntMatrixClr, cntMatrixEn, cntMatrixLd,
         cntShfClr, cntShfEn, cntShfLd,
         cntInpClr, cntInpEn,
         cntTClr, cntTEn,
         ldRegUp, ldRegDn, clrRegDn, selRegUp1,
         ldRegMatrix, ldRegShfSize, selCircleInp, shfR, bitChangeLd, bitChangeEn;

    RotateDatapath dp(
        .clk(clk), .rst(rst), .start(start), .inp(in),
        .rotMemRead(rotMemRead), .rotMemWrite(rotMemWrite), .rotMemSel(rotMemSel),
        .cntMatrixClr(cntMatrixClr), .cntMatrixEn(cntMatrixEn), .cntMatrixLd(cntMatrixLd),
        .cntShfClr(cntShfClr), .cntShfEn(cntShfEn), .cntShfLd(cntShfLd),
        .cntInpClr(cntInpClr), .cntInpEn(cntInpEn),
        .cntTClr(cntTClr), .cntTEn(cntTEn),
        .ldRegUp(ldRegUp), .ldRegDn(ldRegDn), .clrRegDn(clrRegDn), .selRegUp1(selRegUp1),
        .ldRegMatrix(ldRegMatrix), .ldRegShfSize(ldRegShfSize), .selCircleInp(selCircleInp), .shfR(shfR), .bitChangeLd(bitChangeLd), .bitChangeEn(bitChangeEn),
        .cntMatrixCo(cntMatrixCo), .cntInpCo(cntInpCo), .cntShfCo(cntShfCo), .cntTCo(cntTCo), .out(out)
    );
    RotateController ctrl(
        .clk(clk), .rst(rst), .start(start),
        .cntMatrixCo(cntMatrixCo), .cntInpCo(cntInpCo), .cntShfCo(cntShfCo), .cntTCo(cntTCo),
        .rotMemRead(rotMemRead), .rotMemWrite(rotMemWrite), .rotMemSel(rotMemSel),
        .ready(ready), .putInput(putInput), .outReady(outReady),
        .cntMatrixClr(cntMatrixClr), .cntMatrixEn(cntMatrixEn), .cntMatrixLd(cntMatrixLd),
        .cntShfClr(cntShfClr), .cntShfEn(cntShfEn), .cntShfLd(cntShfLd),
        .cntInpClr(cntInpClr), .cntInpEn(cntInpEn),
        .cntTClr(cntTClr), .cntTEn(cntTEn),
        .ldRegUp(ldRegUp), .ldRegDn(ldRegDn), .clrRegDn(clrRegDn), .selRegUp1(selRegUp1),
        .ldRegMatrix(ldRegMatrix), .ldRegShfSize(ldRegShfSize), .selCircleInp(selCircleInp), .shfR(shfR), .bitChangeLd(bitChangeLd), .bitChangeEn(bitChangeEn)
    );
endmodule
