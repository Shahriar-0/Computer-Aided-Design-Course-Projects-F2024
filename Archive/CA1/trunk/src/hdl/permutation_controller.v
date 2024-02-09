module PermutationController (clk, rst, start, cntCo,
                              ready, ldReg, cntEn, cntClr, putInput, outReady, selRes);
    localparam Idle = 3'b000, Init = 3'b001, Request = 3'b010,
               Load = 3'b011, Write = 3'b100, Inform = 3'b101;

    input clk, rst, start, cntCo;
    output ready, ldReg, cntEn, cntClr, putInput, outReady, selRes;

    reg ready, ldReg, cntEn, cntClr, putInput, outReady, selRes;
    reg [2:0] pstate, nstate;

    always @(pstate or start or cntCo) begin
        nstate = Idle;
        case (pstate)
            Idle:    nstate = start ? Init : Idle;
            Init:    nstate = Request;
            Request: nstate = Load;
            Load:    nstate = Write;
            Write:   nstate = Inform;
            Inform:  nstate = cntCo ? Idle : Request;
            default:;
        endcase
    end

    always @(pstate) begin
        {ready, ldReg, cntEn, cntClr, putInput, outReady, selRes} = 7'd0;
        case (pstate)
            Idle:    ready = 1'b1;
            Init:    cntClr = 1'b1;
            Request: putInput = 1'b1;
            Load:    {ldReg, selRes} = 2'b10;
            Write:   {ldReg, selRes} = 2'b11;
            Inform:  {outReady, cntEn} = 2'b11;
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
