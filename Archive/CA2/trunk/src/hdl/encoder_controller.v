module EncoderController (clk, rst, start, sliceCntCo, cycleCntCo, colReady, colPutInput, colOutReady,
                          rotReady, rotPutInput, rotOutReady, perReady, perPutInput, revReady,
                          revPutInput, revOutReady, addReady, addPutInput,
                          ready, putInput, outReady, sliceCntClr, cycleCntClr, sliceCntEn, cycleCntEn,
                          memRead, memWrite, memSrc, colStart, rotStart, perStart, revStart, addStart);
    localparam Idle       = 6'd00, Init      = 6'd01, Load       = 6'd02, ColReady   = 6'd03, StartCol   = 6'd04,
               WaitInCol  = 6'd05, InputCol  = 6'd06, WaitOutCol = 6'd07, ResCol     = 6'd08, RotReady   = 6'd09,
               StartRot   = 6'd10, WaitInRot = 6'd11, InputRot   = 6'd12, WaitOutRot = 6'd13, ResRot     = 6'd14,
               PerReady   = 6'd15, StartPer  = 6'd16, WaitInPer  = 6'd17, InputPer   = 6'd18, WaitOutPer = 6'd19,
               ResPer     = 6'd20, RevReady  = 6'd21, StartRev   = 6'd22, WaitInRev  = 6'd23, InputRev   = 6'd24,
               WaitOutRev = 6'd25, ResRev    = 6'd26, AddReady   = 6'd27, StartAdd   = 6'd28, WaitInAdd  = 6'd29,
               InputAdd   = 6'd30, ResAdd    = 6'd31, CycleCnt   = 6'd32, Inform     = 6'd33, Result     = 6'd34;

    input clk, rst, start, sliceCntCo, cycleCntCo, colReady, colPutInput, colOutReady, rotReady,
          rotPutInput, rotOutReady, perReady, perPutInput, revReady, revPutInput, revOutReady,
          addReady, addPutInput;
    output reg ready, putInput, outReady, sliceCntClr, cycleCntClr, sliceCntEn, cycleCntEn, memRead,
               memWrite, colStart, rotStart, perStart, revStart, addStart;
    output reg [2:0] memSrc;

    reg [5:0] pstate, nstate;

    always @(pstate or start or sliceCntCo or cycleCntCo or colReady or colPutInput or
             colOutReady or rotReady or rotPutInput or rotOutReady or perReady or perPutInput or
             revReady or revPutInput or revOutReady or addReady or addPutInput) begin
        nstate = Idle;
        case (pstate)
            Idle       : nstate = start ? Init : Idle;
            Init       : nstate = Load;
            Load       : nstate = sliceCntCo ? ColReady : Load;
            ColReady   : nstate = colReady ? StartCol : ColReady;
            StartCol   : nstate = colReady ? StartCol : WaitInCol;
            WaitInCol  : nstate = colPutInput ? InputCol : WaitInCol;
            InputCol   : nstate = sliceCntCo ? WaitOutCol : WaitInCol;
            WaitOutCol : nstate = colOutReady ? ResCol : WaitOutCol;
            ResCol     : nstate = sliceCntCo ? RotReady : ResCol;
            RotReady   : nstate = rotReady ? StartRot : RotReady;
            StartRot   : nstate = WaitInRot;
            WaitInRot  : nstate = rotPutInput ? InputRot : WaitInRot;
            InputRot   : nstate = sliceCntCo ? WaitOutRot : InputRot;
            WaitOutRot : nstate = rotOutReady ? ResRot : WaitOutRot;
            ResRot     : nstate = sliceCntCo ? PerReady : ResRot;
            PerReady   : nstate = perReady ? StartPer : PerReady;
            StartPer   : nstate = WaitInPer;
            WaitInPer  : nstate = perPutInput ? InputPer : WaitInPer;
            InputPer   : nstate = WaitOutPer;
            WaitOutPer : nstate = ResPer;
            ResPer     : nstate = sliceCntCo ? RevReady : InputPer;
            RevReady   : nstate = revReady ? StartRev : RevReady;
            StartRev   : nstate = WaitInRev;
            WaitInRev  : nstate = revPutInput ? InputRev : WaitInRev;
            InputRev   : nstate = WaitOutRev;
            WaitOutRev : nstate = revOutReady ? ResRev : WaitOutRev;
            ResRev     : nstate = sliceCntCo ? AddReady : StartRev;
            AddReady   : nstate = addReady ? StartAdd : AddReady;
            StartAdd   : nstate = WaitInAdd;
            WaitInAdd  : nstate = addPutInput ? InputAdd : WaitInAdd;
            InputAdd   : nstate = ResAdd;
            ResAdd     : nstate = sliceCntCo ? CycleCnt : InputAdd;
            CycleCnt   : nstate = cycleCntCo ? Inform : ColReady;
            Inform     : nstate = Result;
            Result     : nstate = sliceCntCo ? Idle : Result;
            default:;
        endcase
    end

    always @(pstate) begin
        {ready, putInput, outReady, sliceCntClr, cycleCntClr, sliceCntEn, cycleCntEn} = 7'd0;
        {memRead, memWrite, colStart, rotStart, perStart, revStart, addStart} = 7'd0;
        memSrc = 3'd0;
        case (pstate)
            Idle       : ready = 1'b1;
            Init       : {sliceCntClr, cycleCntClr, putInput} = 3'b111;
            Load       : begin {memWrite, sliceCntEn} = 2'b11; memSrc = 3'd0; end
            ColReady   : sliceCntClr = 1'b1;
            StartCol   : colStart = 1'b1;
            WaitInCol  : ;
            InputCol   : {memRead, sliceCntEn} = 2'b11;
            WaitOutCol : sliceCntClr = 1'b1;
            ResCol     : begin {sliceCntEn, memWrite} = 2'b11; memSrc = 3'd1; end
            RotReady   : ;
            StartRot   : {rotStart, sliceCntClr} = 2'b11;
            WaitInRot  : ;
            InputRot   : {memRead, sliceCntEn} = 2'b11;
            WaitOutRot : sliceCntClr = 1'b1;
            ResRot     : begin {sliceCntEn, memWrite} = 2'b11; memSrc = 3'd2; end
            PerReady   : ;
            StartPer   : {perStart, sliceCntClr} = 2'b11;
            WaitInPer  : ;
            InputPer   : memRead = 1'b1;
            WaitOutPer : ;
            ResPer     : begin {memWrite, sliceCntEn} = 2'b11; memSrc = 3'd3; end
            RevReady   : sliceCntClr = 1'b1;
            StartRev   : revStart = 1'b1;
            WaitInRev  : ;
            InputRev   : memRead = 1'b1;
            WaitOutRev : ;
            ResRev     : begin {memWrite, sliceCntEn} = 2'b11; memSrc = 3'd4; end
            AddReady   : ;
            StartAdd   : {addStart, sliceCntClr} = 2'b11;
            WaitInAdd  : ;
            InputAdd   : memRead = 1'b1;
            ResAdd     : begin {memWrite, sliceCntEn} = 2'b11; memSrc = 3'd5; end
            CycleCnt   : cycleCntEn = 1'b1;
            Inform     : {sliceCntClr, outReady} = 2'b11;
            Result     : {memRead, sliceCntEn} = 2'b11;
            default:;
        endcase
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            pstate <= Idle;
        else
            pstate <= nstate;
    end
endmodule
