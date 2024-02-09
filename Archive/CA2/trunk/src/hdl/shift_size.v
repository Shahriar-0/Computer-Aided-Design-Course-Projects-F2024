`include "adder.v"
`include "multiplier.v"

module ShiftSize(tLoopNum, out);
    input [4:0] tLoopNum;
    output [5:0] out;

    wire [4:0] plus1, plus2;
    wire [24:0] multOut, shiftOut;

    Adder #(5) add1(tLoopNum, 5'd1, plus1);
    Adder #(5) add2(tLoopNum, 5'd2, plus2);

    Multiplier #(5) mult(plus1, plus2, multOut);
    assign shiftOut = multOut >> 1;

    assign out = shiftOut[5:0];
endmodule
