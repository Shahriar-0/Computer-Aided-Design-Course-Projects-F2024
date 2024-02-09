module PermutationController (clk, rst, start, cntCo,
                              ready, ldReg, cntEn, cntClr, putInput, selRes);
    localparam Idle  = 3'b000,
               Init  = 3'b001,
               Load  = 3'b010,
               Res   = 3'b011,
               Count = 3'b100;

    input clk, rst, start, cntCo;
    output ready, ldReg, cntEn, cntClr, putInput, selRes;

    reg ready, ldReg, cntEn, cntClr, putInput, selRes;
    reg [2:0] pstate, nstate;

    always @(pstate or start or cntCo) begin
        nstate = Idle;
        case (pstate)
            Idle:  nstate = start ? Init : Idle;
            Init:  nstate = Load;
            Load:  nstate = Res;
            Res:   nstate = Count;
            Count: nstate = cntCo ? Idle : Load;
            default:;
        endcase
    end

    always @(pstate) begin
        {ready, ldReg, cntEn, cntClr, putInput, selRes} = 6'd0;
        case (pstate)
            Idle:  ready = 1'b1;
            Init:  {cntClr, putInput} = 2'b11;
            Load:  {ldReg, selRes} = 2'b10;
            Res:   {ldReg, selRes} = 2'b11;
            Count: cntEn = 1'b1;
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
