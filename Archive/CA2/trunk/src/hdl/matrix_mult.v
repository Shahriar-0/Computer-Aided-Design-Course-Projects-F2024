`include "register.v"
`include "multiplier.v"
`include "counter_modn.v"
`include "mux.v"

module MatrixMult(clk, rst, tLoopNum, ldRegUp, ldRegDn, selRegUp1, clrRegDn,
                  cntMatrixClr, cntMatrixEn, cntMatrixLd, out, cntMatrixCo);
    input clk, rst;
    input [4:0] tLoopNum;
    input ldRegUp, ldRegDn, selRegUp1, clrRegDn;
    input cntMatrixClr, cntMatrixEn, cntMatrixLd;
    output [4:0] out;
    output cntMatrixCo;

    wire [2:0] regUpOut, regDnOut;
    wire [2:0] muxOut, mod5;
    wire [4:0] addOut;
    wire [8:0] mult2Out, mult3Out;

    function [4:0] index2DTo1D;
        input [4:0] i;
        input [4:0] j;

        begin: index2DTo1DBlock
            reg [4:0] row, col;
            row = (j + 2) % 5;
            col = (i + 2) % 5;
            index2DTo1D = 5'd24 - (row * 5 + col);
        end
    endfunction

    assign out = index2DTo1D(regUpOut, regDnOut);

    Register #(3) regUp(
        .clk(clk),
        .rst(rst),
        .clr(1'b0),
        .ld(ldRegUp),
        .din(muxOut),
        .dout(regUpOut)
    );

    Register #(3) regDn(
        .clk(clk),
        .rst(rst),
        .clr(clrRegDn),
        .ld(ldRegDn),
        .din(mod5),
        .dout(regDnOut)
    );

    Mux2to1 #(3) mux(
        .sel(selRegUp1),
        .a0(regDnOut),
        .a1(3'd1),
        .out(muxOut)
    );

    CounterModNLoad #(5) tLoopCounter(
        .clk(clk),
        .rst(rst),
        .clr(cntMatrixClr),
        .en(cntMatrixEn),
        .ld(cntMatrixLd),
        .pload(tLoopNum),
        .q(),
        .co(cntMatrixCo)
    );

    Multiplier #(3) mult2(
        .a(regUpOut),
        .b(3'd2),
        .out(mult2Out)
    );

    Multiplier #(3) mult3(
        .a(regDnOut),
        .b(3'd3),
        .out(mult3Out)
    );

    Adder #(5) adder(
        .a(mult2Out[4:0]),
        .b(mult3Out[4:0]),
        .out(addOut)
    );

    assign mod5 = addOut % 5;
endmodule
