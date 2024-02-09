`include "shift_register.v"
`include "five_bit_selector.v"
`include "counter_modn.v"
`include "adder.v"

module ColParityCalc (clk, rst, cntEn, cntClr, shfEn, shfClr, inputReg, cntCo, out);
    input clk, rst, cntEn, cntClr, shfEn, shfClr;
    input [24:0] inputReg;
    output cntCo;
    output [4:0] out;

    wire [2:0] cntOut;
    wire [4:0] regOut;
    wire [4:0] colIdx [0:4];
    wire [4:0] colPar;
    wire xorOut;

    ShiftRegister #(5) shreg(
        .clk(clk),
        .rst(rst),
        .clr(shfClr),
        .ld(1'b0),
        .shf(shfEn),
        .serIn(xorOut),
        .din(5'd0),
        .dout(regOut)
    );

    assign out = regOut;

    FiveBitSelector sel(
        .sel0(colIdx[0]),
        .sel1(colIdx[1]),
        .sel2(colIdx[2]),
        .sel3(colIdx[3]),
        .sel4(colIdx[4]),
        .din(inputReg),
        .dout(colPar)
    );

    CounterModN #(5) cntr(
        .clk(clk),
        .rst(rst),
        .clr(cntClr),
        .en(cntEn),
        .q(cntOut),
        .co(cntCo)
    );

    assign colIdx[0] = cntOut;
    Adder #(5) adder1(.a({2'b0,cntOut}), .b(5'd5), .out(colIdx[1]));
    Adder #(5) adder2(.a({2'b0,cntOut}), .b(5'd10), .out(colIdx[2]));
    Adder #(5) adder3(.a({2'b0,cntOut}), .b(5'd15), .out(colIdx[3]));
    Adder #(5) adder4(.a({2'b0,cntOut}), .b(5'd20), .out(colIdx[4]));

    assign xorOut = ^colPar;
endmodule
