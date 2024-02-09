`include "matrix_mult.v"
`include "shift_size.v"
`include "register.v"
`include "shift_register.v"
`include "mux.v"
`include "counter_modn.v"
`include "memory.v"
`include "bit_changer.v"

module RotateDatapath (clk, rst, start, inp,
                       rotMemRead, rotMemWrite, rotMemSel,
                       cntMatrixClr, cntMatrixEn, cntMatrixLd,
                       cntShfClr, cntShfEn, cntShfLd,
                       cntInpClr, cntInpEn,
                       cntTClr, cntTEn,
                       ldRegUp, ldRegDn, clrRegDn, selRegUp1,
                       ldRegMatrix, ldRegShfSize, selCircleInp, shfR, bitChangeLd, bitChangeEn,
                       cntMatrixCo, cntInpCo, cntShfCo, cntTCo, out);

    input clk, rst, start;
    input [24:0] inp;
    input rotMemRead, rotMemWrite, rotMemSel;
    input cntMatrixClr, cntMatrixEn, cntMatrixLd;
    input cntShfClr, cntShfEn, cntShfLd;
    input cntInpClr, cntInpEn;
    input cntTClr, cntTEn;
    input ldRegUp, ldRegDn, clrRegDn, selRegUp1;
    input ldRegMatrix, ldRegShfSize, selCircleInp, shfR, bitChangeLd, bitChangeEn;
    output cntMatrixCo, cntInpCo, cntShfCo, cntTCo;
    output [24:0] out;

    wire [4:0] cntTOut, matrixMultOut, matrixMult;
    wire [5:0] cntInpOut, shiftSizeOut, shiftSize;
    wire [24:0] memOut, muxMemInp, bitChangerOut;
    wire [63:0] serOutAll;
    wire serOut, muxShfOut, bitSelectorOut;

    CounterModN #(24) cntT(
        .clk(clk),
        .rst(rst),
        .clr(cntTClr),
        .en(cntTEn),
        .q(cntTOut),
        .co(cntTCo)
    );

    MatrixMult matrixMultiplier(
        .clk(clk),
        .rst(rst),
        .tLoopNum(cntTOut),
        .ldRegUp(ldRegUp),
        .ldRegDn(ldRegDn),
        .selRegUp1(selRegUp1),
        .clrRegDn(clrRegDn),
        .cntMatrixClr(cntMatrixClr),
        .cntMatrixEn(cntMatrixEn),
        .cntMatrixLd(cntMatrixLd),
        .cntMatrixCo(cntMatrixCo),
        .out(matrixMultOut)
    );

    ShiftSize shfSize(
        .tLoopNum(cntTOut),
        .out(shiftSizeOut)
    );

    Register #(5) regMatrix(
        .clk(clk),
        .rst(rst),
        .clr(1'b0),
        .ld(ldRegMatrix),
        .din(matrixMultOut),
        .dout(matrixMult)
    );

    Register #(6) regShfSize(
        .clk(clk),
        .rst(rst),
        .clr(1'b0),
        .ld(ldRegShfSize),
        .din(shiftSizeOut),
        .dout(shiftSize)
    );

    CounterModN #(64) cntInp(
        .clk(clk),
        .rst(rst),
        .clr(cntInpClr),
        .en(cntInpEn),
        .q(cntInpOut),
        .co(cntInpCo)
    );

    Memory #(.N(25), .Size(64)) mem(
        .clk(clk),
        .rst(rst),
        .clr(1'b0),
        .read(rotMemRead),
        .write(rotMemWrite),
        .adr(cntInpOut),
        .din(muxMemInp),
        .dout(memOut)
    );

    Mux2to1 #(25) muxMem(
        .sel(rotMemSel),
        .a0(inp),
        .a1(bitChangerOut),
        .out(muxMemInp)
    );

    assign bitSelectorOut = memOut[matrixMult];

    BitChanger #(25) bitChanger(
        .clk(clk),
        .rst(rst),
        .clr(1'b0),
        .ld(bitChangeLd),
        .en(bitChangeEn),
        .bitChange(serOut),
        .bitSelect(matrixMult),
        .din(memOut),
        .dout(bitChangerOut)
    );

    CounterModNLoad #(6) cntShf(
        .clk(clk),
        .rst(rst),
        .clr(cntShfClr),
        .en(cntShfEn),
        .ld(cntShfLd),
        .pload(64 - shiftSize),
        .q(),
        .co(cntShfCo)
    );

    Mux2to1 #(1) muxShf(
        .sel(selCircleInp),
        .a0(serOut),
        .a1(bitSelectorOut),
        .out(muxShfOut)
    );

    ShiftRegister #(64) shfInp(
        .clk(clk),
        .rst(rst),
        .clr(1'b0),
        .ld(1'b0),
        .shR(shfR),
        .shL(1'b0),
        .serIn(muxShfOut),
        .din(),
        .dout(serOutAll)
    );

    assign serOut = serOutAll[0];
    assign out = memOut;
endmodule
