module ColParityController (clk, rst, start, adrSrc, regSrc,
                            sliceCntEn, sliceCntClr, memRead, memWrite,
                            regLd, regClr, regShfR,
                            xorSrc, matCntEn, matCntClr,
                            colCntEn, colCntClr, colRegShR, colRegClr,
                            PDParLd, PDParClr,
                            matCntCo, colCntCo, sliceCntCo,
                            ready, putInput, outReady);
    localparam Idle         = 4'b0000,
               Init         = 4'b0001,
               Request      = 4'b0010,
               Load         = 4'b0011,
               ParityCalc   = 4'b0100,
               Xor          = 4'b0101,
               Write        = 4'b0111,
               LdFirstSlice = 4'b1000,
               ParityCalc1  = 4'b1001,
               Xor1         = 4'b1010,
               Write1       = 4'b1011,
               Inform       = 4'b1100,
               Output       = 4'b1101;

    input clk, rst, start;
    output reg adrSrc, regSrc;
    output reg sliceCntEn, sliceCntClr, memRead, memWrite;
    output reg regLd, regClr, regShfR;
    output reg xorSrc, matCntEn, matCntClr;
    output reg colCntEn, colCntClr, colRegShR, colRegClr;
    output reg PDParLd, PDParClr;
    input matCntCo, colCntCo, sliceCntCo;
    output reg ready, putInput, outReady;

    reg [3:0] pstate, nstate;

    always @(pstate or start or colCntCo or matCntCo or sliceCntCo) begin
        nstate = Idle;
        case (pstate)
            Idle:         nstate = start ? Init : Idle;
            Init:         nstate = Request;
            Request:      nstate = Load;
            Load:         nstate = ParityCalc;
            ParityCalc:   nstate = colCntCo == 0 ? ParityCalc : Xor;
            Xor:          nstate = matCntCo == 0 ? Xor : Write;
            Write:        nstate = sliceCntCo == 0 ? Request : LdFirstSlice;
            LdFirstSlice: nstate = ParityCalc1;
            ParityCalc1:  nstate = colCntCo == 0 ? ParityCalc1 : Xor1;
            Xor1:         nstate = matCntCo == 0 ? Xor1 : Write1;
            Write1:       nstate = Inform;
            Inform:       nstate = Output;
            Output:       nstate = sliceCntCo == 0 ? Output : Idle;
            default:;
        endcase
    end

    always @(pstate) begin
        {ready, putInput, outReady} = 3'd0;
        {sliceCntClr, regClr, colRegClr, colCntClr, PDParClr, matCntClr} = 6'd0;
        {regLd, adrSrc, regSrc, memRead} = 4'd0;
        {colCntEn, colRegShR, xorSrc} = 3'd0;
        {matCntEn, regShfR} = 2'd0;
        {memWrite, sliceCntEn, PDParLd} = 3'd0;
        case (pstate)
            Idle:         ready = 1'b1;
            Init:         {sliceCntClr, PDParClr} = 2'b11;
            Request:      {putInput, regClr, colRegClr, colCntClr, matCntClr} = 5'b1_1111;
            Load:         regLd = 1'b1;
            ParityCalc:   {colCntEn, colRegShR} = 2'b11;
            Xor:          {matCntEn, regShfR} = 2'b11;
            Write:        {memWrite, sliceCntEn, PDParLd} = 3'b111;
            LdFirstSlice: {adrSrc, regSrc, memRead, matCntClr, colCntClr, colRegClr, regLd} = 7'b111_1111;
            ParityCalc1:  {colCntEn, colRegShR} = 2'b11;
            Xor1:         {matCntEn, regShfR, xorSrc} = 3'b111;
            Write1:       {memWrite, adrSrc} = 2'b11;
            Inform:       {outReady, sliceCntClr} = 2'b11;
            Output:       {sliceCntEn, memRead} = 2'b11;
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
