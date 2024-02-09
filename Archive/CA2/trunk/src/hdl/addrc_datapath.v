`include "register.v"
`include "counter_modn.v"

module AddRcDatapath (clk, rst, in, cycleNum, sliceCntEn, sliceCntClr, ldReg, clrReg, sliceCntCo, out);
    input clk, rst, sliceCntEn, sliceCntClr, ldReg, clrReg;
    input [24:0] in;
    input [4:0] cycleNum;
    output sliceCntCo;
    output [24:0] out;

    wire [5:0] sliceCnt;
    wire [24:0] regIn, regOut;
    wire [0:63] currRcValue;
    reg [63:0] rcValues [0:23];

    initial $readmemh("file/rc.hex", rcValues);

    Register #(.N(25)) outReg(.clk(clk), .rst(rst), .clr(clrReg), .ld(ldReg), .din(regIn), .dout(regOut));
    CounterModN #(.N(64)) sliceNum(.clk(clk), .rst(rst), .clr(sliceCntClr), .en(sliceCntEn), .q(sliceCnt), .co(sliceCntCo));

    assign currRcValue = rcValues[cycleNum];
    assign out = regOut;
    assign regIn = {in[24:13], in[12] ^ currRcValue[sliceCnt], in[11:0]};
endmodule
