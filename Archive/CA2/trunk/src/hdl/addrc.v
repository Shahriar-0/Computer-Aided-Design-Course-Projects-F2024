`include "addrc_datapath.v"
`include "addrc_controller.v"

module AddRc (clk, rst, in, cycleNum, start, out, ready, putInput);
    input clk, rst, start;
    input [24:0] in;
    input [4:0] cycleNum;
    output [24:0] out;
    output ready, putInput;

    wire sliceCntCo, sliceCntEn, sliceCntClr, ldReg, clrReg;

    AddRcDatapath dp(.clk(clk), .rst(rst), .in(in), .cycleNum(cycleNum), .sliceCntEn(sliceCntEn),
                     .sliceCntClr(sliceCntClr), .ldReg(ldReg), .clrReg(clrReg), .sliceCntCo(sliceCntCo),
                     .out(out));
    AddRcController ctrl(.clk(clk), .rst(rst), .start(start), .sliceCntCo(sliceCntCo), .sliceCntEn(sliceCntEn),
                         .sliceCntClr(sliceCntClr), .ldReg(ldReg), .clrReg(clrReg), .ready(ready),
                         .putInput(putInput));
endmodule
