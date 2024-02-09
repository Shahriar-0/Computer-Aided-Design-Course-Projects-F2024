`include "mux.v"
`include "shift_register.v"
`include "register.v"
`include "counter_modn.v"

module RevaluateDatapath (clk, rst, in, ldReg, clrReg, rowCntEn, rowCntClr, colCntEn, colCntClr, shL, clrOut, rowCntCo, colCntCo, out);
    input clk, rst, ldReg, clrReg, rowCntEn, rowCntClr, colCntEn, colCntClr, shL, clrOut;
    input [24:0] in;
    output rowCntCo, colCntCo;
    output [24:0] out;

    wire [2:0] rowCnt, colCnt;
    wire [24:0] rows;
    wire [4:0] row;
    wire mux0Out, mux1Out, mux2Out, serIn;

    CounterModN #(.N(5)) rowCounter(.clk(clk), .rst(rst), .clr(rowCntClr), .en(rowCntEn), .q(rowCnt), .co(rowCntCo));
    CounterModN #(.N(5)) colCounter(.clk(clk), .rst(rst), .clr(colCntClr), .en(colCntEn), .q(colCnt), .co(colCntCo));

    Register #(.N(25)) inputReg(.clk(clk), .rst(rst), .clr(clrReg), .ld(ldReg), .din(in), .dout(rows));
    ShiftRegister #(.N(25)) outReg(.clk(clk), .rst(rst), .clr(clrOut), .ld(1'b0), .shR(1'b0), .shL(shL), .serIn(serIn), .din(25'b0), .dout(out));

    Mux8to1 #(.N(5)) rowSelector(.sel(rowCnt), .a0(rows[24:20]), .a1(rows[19:15]), .a2(rows[14:10]), .a3(rows[9:5]), .a4(rows[4:0]), .out(row));
    Mux8to1 #(.N(1)) mux0(.sel(colCnt), .a0(row[4]), .a1(row[3]), .a2(row[2]), .a3(row[1]), .a4(row[0]), .out(mux0Out));
    Mux8to1 #(.N(1)) mux1(.sel(colCnt), .a0(row[3]), .a1(row[2]), .a2(row[1]), .a3(row[0]), .a4(row[4]), .out(mux1Out));
    Mux8to1 #(.N(1)) mux2(.sel(colCnt), .a0(row[2]), .a1(row[1]), .a2(row[0]), .a3(row[4]), .a4(row[3]), .out(mux2Out));

    assign serIn = (~mux1Out & mux2Out) ^ mux0Out;
endmodule
