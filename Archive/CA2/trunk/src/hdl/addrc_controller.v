module AddRcController (clk, rst, start, sliceCntCo, sliceCntEn, sliceCntClr, ldReg, clrReg, ready, putInput);
    localparam Idle  = 3'b000,
               Init  = 3'b001,
               Start = 3'b010,
               Calc  = 3'b011,
               Res   = 3'b100;

    input clk, rst, start, sliceCntCo;
    output reg sliceCntEn, sliceCntClr, ldReg, clrReg, ready, putInput;

    reg [2:0] pstate, nstate;

    always @(pstate or start or sliceCntCo) begin
        nstate = Idle;
        case (pstate)
            Idle:  nstate = start ? Init : Idle;
            Init:  nstate = Start;
            Start: nstate = Calc;
            Calc:  nstate = Res;
            Res:   nstate = sliceCntCo ? Idle : Calc;
            default:;
        endcase
    end

    always @(pstate) begin
        {sliceCntEn, sliceCntClr, ldReg, clrReg, ready, putInput} = 6'd0;
        case (pstate)
            Idle:  ready = 1'b1;
            Init:  {sliceCntClr, clrReg} = 2'b11;
            Start: putInput = 1'b1;
            Calc:  ldReg = 1'b1;
            Res:   sliceCntEn = 1'b1;
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