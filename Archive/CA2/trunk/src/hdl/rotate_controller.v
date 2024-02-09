module RotateController (clk, rst, start, cntMatrixCo, cntInpCo, cntShfCo, cntTCo,
                         ready, putInput, outReady,
                         rotMemRead, rotMemWrite, rotMemSel,
                         cntMatrixClr, cntMatrixEn, cntMatrixLd,
                         cntShfClr, cntShfEn, cntShfLd,
                         cntInpClr, cntInpEn,
                         cntTClr, cntTEn,
                         ldRegUp, ldRegDn, clrRegDn, selRegUp1,
                         ldRegMatrix, ldRegShfSize, selCircleInp, shfR, bitChangeLd, bitChangeEn);
    localparam Idle        = 5'd0,  Init        = 5'd1,  LoadMem     = 5'd2,
               Start       = 5'd3,  MatrixCnt   = 5'd4,  MatrixCalc  = 5'd5,
               LoadRegs    = 5'd6,  ShifterFill = 5'd7,  ShifterNext = 5'd8,
               ShiftCnt    = 5'd9,  Shift       = 5'd10, RstCntInp   = 5'd11,
               ChangeBitLd = 5'd12, ChangeBit   = 5'd13, WriteBack   = 5'd14,
               InputNext   = 5'd15, NextT       = 5'd16, OutReady    = 5'd17,
               Output      = 5'd18;

    input clk, rst;
    input start, cntMatrixCo, cntInpCo, cntShfCo, cntTCo;
    output reg ready, putInput, outReady;
    output reg rotMemRead, rotMemWrite, rotMemSel;
    output reg cntMatrixClr, cntMatrixEn, cntMatrixLd;
    output reg cntShfClr, cntShfEn, cntShfLd;
    output reg cntInpClr, cntInpEn;
    output reg cntTClr, cntTEn;
    output reg ldRegUp, ldRegDn, clrRegDn, selRegUp1;
    output reg ldRegMatrix, ldRegShfSize, selCircleInp, shfR, bitChangeLd, bitChangeEn;

    reg [4:0] pstate, nstate;

    always @(pstate or start or cntMatrixCo or cntShfCo or cntInpCo or cntTCo) begin
        nstate = Idle;
        case (pstate)
            Idle:        nstate = start ? Init : Idle;
            Init:        nstate = LoadMem;
            LoadMem:     nstate = cntInpCo ? Start : LoadMem;
            Start:       nstate = MatrixCnt;
            MatrixCnt:   nstate = cntMatrixCo ? LoadRegs : MatrixCalc;
            MatrixCalc:  nstate = MatrixCnt;
            LoadRegs:    nstate = ShifterFill;
            ShifterFill: nstate = ShifterNext;
            ShifterNext: nstate = cntInpCo ? ShiftCnt : ShifterFill;
            ShiftCnt:    nstate = cntShfCo ? RstCntInp : Shift;
            Shift:       nstate = ShiftCnt;
            RstCntInp:   nstate = ChangeBitLd;
            ChangeBitLd: nstate = ChangeBit;
            ChangeBit:   nstate = WriteBack;
            WriteBack:   nstate = InputNext;
            InputNext:   nstate = cntInpCo ? NextT : ChangeBitLd;
            NextT:       nstate = cntTCo ? OutReady : Start;
            OutReady:    nstate = Output;
            Output:      nstate = cntInpCo ? Idle : Output;
            default:;
        endcase
    end

    always @(pstate) begin
        {ready, putInput, outReady} = 4'd0;
        {rotMemRead, rotMemWrite, rotMemSel} = 3'd0;
        {cntMatrixClr, cntMatrixEn, cntMatrixLd} = 3'd0;
        {cntShfClr, cntShfEn, cntShfLd} = 3'd0;
        {cntInpClr, cntInpEn} = 2'd0;
        {cntTClr, cntTEn} = 2'd0;
        {ldRegUp, ldRegDn, clrRegDn, selRegUp1} = 4'd0;
        {ldRegMatrix, ldRegShfSize, selCircleInp, shfR, bitChangeLd, bitChangeEn} = 6'd0;

        case (pstate)
            Idle: ready = 1'b1;
            Init: begin
                {cntMatrixClr, cntShfClr, cntInpClr, cntTClr} = 4'b1111;
                {clrRegDn, ldRegUp, selRegUp1, putInput} = 4'b1111;
            end
            LoadMem: {rotMemWrite, rotMemSel, cntInpEn} = 3'b101;
            Start: begin
                {cntMatrixLd, ldRegShfSize, cntInpClr} = 3'b111;
                {clrRegDn, ldRegUp, selRegUp1} = 3'b111;
            end
            MatrixCnt: cntMatrixEn = 1'b1;
            MatrixCalc: {ldRegUp, ldRegDn, selRegUp1} = 3'b110;
            LoadRegs: {ldRegMatrix, cntShfLd, rotMemRead} = 3'b111;
            ShifterFill: {shfR, selCircleInp} = 2'b11;
            ShifterNext: {cntInpEn, rotMemRead} = 2'b11;
            ShiftCnt: cntShfEn = 1'b1;
            Shift: {shfR, selCircleInp} = 2'b10;
            RstCntInp: cntInpClr = 1'b1;
            ChangeBitLd: {bitChangeLd, rotMemRead} = 2'b11;
            ChangeBit: bitChangeEn = 1'b1;
            WriteBack: {rotMemWrite, rotMemSel} = 2'b11;
            InputNext: {cntInpEn, shfR} = 2'b11;
            NextT: cntTEn = 1'b1;
            OutReady: {outReady, cntInpClr, rotMemRead} = 3'b111;
            Output: {cntInpEn, rotMemRead} = 2'b11;
            default:;
        endcase
    end

    always @(posedge clk or negedge rst) begin
        if (rst)
            pstate <= Idle;
        else
            pstate <= nstate;
    end
endmodule
