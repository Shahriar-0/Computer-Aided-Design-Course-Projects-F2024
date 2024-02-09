`include "encoder_datapath.v"
`include "encoder_controller.v"

module Encoder (clk, rst, in, start, ready, putInput, outReady, out);
    input clk, rst, start;
    input [24:0] in;
    output ready, putInput, outReady;
    output [24:0] out;

    wire memWrite, memRead, sliceCntEn, sliceCntClr, cycleCntEn,cycleCntClr, colStart,
         rotStart, perStart, revStart, addStart, colPutInput, colOutReady, colReady,
         rotPutInput, rotOutReady, rotReady, perPutInput, perReady, revPutInput,
         revOutReady, revReady, addPutInput, addReady, sliceCntCo, cycleCntCo;
    wire [2:0] memSrc;

    EncoderDatapath dp(.clk(clk), .rst(rst), .in(in), .start(start), .memSrc(memSrc), .memWrite(memWrite),
                       .memRead(memRead), .sliceCntEn(sliceCntEn), .sliceCntClr(sliceCntClr),
                       .cycleCntEn(cycleCntEn), .cycleCntClr(cycleCntClr), .colStart(colStart),
                       .rotStart(rotStart), .perStart(perStart), .revStart(revStart), .addStart(addStart),
                       .colPutInput(colPutInput), .colOutReady(colOutReady), .colReady(colReady),
                       .rotPutInput(rotPutInput), .rotOutReady(rotOutReady), .rotReady(rotReady),
                       .perPutInput(perPutInput), .perReady(perReady), .revPutInput(revPutInput),
                       .revOutReady(revOutReady), .revReady(revReady), .addPutInput(addPutInput),
                       .addReady(addReady), .sliceCntCo(sliceCntCo), .cycleCntCo(cycleCntCo), .out(out));

    EncoderController ctrl(.clk(clk), .rst(rst), .start(start), .ready(ready), .putInput(putInput),
                           .outReady(outReady), .memWrite(memWrite), .memRead(memRead),
                           .sliceCntEn(sliceCntEn), .sliceCntClr(sliceCntClr), .cycleCntEn(cycleCntEn),
                           .cycleCntClr(cycleCntClr), .colStart(colStart), .rotStart(rotStart),
                           .perStart(perStart), .revStart(revStart), .addStart(addStart),
                           .colPutInput(colPutInput), .colOutReady(colOutReady), .colReady(colReady),
                           .rotPutInput(rotPutInput), .rotOutReady(rotOutReady), .rotReady(rotReady),
                           .perPutInput(perPutInput), .perReady(perReady), .revPutInput(revPutInput),
                           .revOutReady(revOutReady), .revReady(revReady), .addPutInput(addPutInput),
                           .addReady(addReady), .sliceCntCo(sliceCntCo), .cycleCntCo(cycleCntCo),
                           .memSrc(memSrc));
endmodule
