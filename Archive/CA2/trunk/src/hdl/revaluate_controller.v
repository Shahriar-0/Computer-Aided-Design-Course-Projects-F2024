module RevaluateController (clk, rst, start, rowCntCo, colCntCo, ldReg, clrReg, rowCntClr,
                            rowCntEn, colCntClr, colCntEn, shL, clrOut, outReady, ready, putInput);
    localparam Idle     = 3'b000,
               Init     = 3'b001,
               Load     = 3'b010,
               StartRow = 3'b011,
               Calc     = 3'b100,
               EndRow   = 3'b101,
               Res      = 3'b110;

    input clk, rst, start, rowCntCo, colCntCo;
    output reg ldReg, clrReg, rowCntClr, rowCntEn, colCntClr, colCntEn, shL, clrOut, outReady, ready, putInput;

    reg [2:0] pstate, nstate;

    always @(pstate or start or putInput or rowCntCo or colCntCo) begin
        nstate = Idle;
        case (pstate)
            Idle:     nstate = start ? Init : Idle;
            Init:     nstate = Load;
            Load:     nstate = StartRow;
            StartRow: nstate = Calc;
            Calc:     nstate = colCntCo ? EndRow : Calc;
            EndRow:   nstate = rowCntCo ? Res : StartRow;
            Res:      nstate = Idle;
            default:;
        endcase
    end

    always @(pstate) begin
        {ldReg, clrReg, rowCntClr, rowCntEn, colCntClr, colCntEn, shL, clrOut, outReady, ready} = 10'd0;
        case (pstate)
            Idle:     ready = 1'b1;
            Init:     {clrReg, rowCntClr, clrOut, putInput} = 4'b1111;
            Load:     ldReg = 1'b1;
            StartRow: colCntClr = 1'b1;
            Calc:     {shL, colCntEn} = 2'b11;
            EndRow:   rowCntEn = 1'b1;
            Res:      outReady = 1'b1;
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