module PU1 #(parameter XLEN = 5) (
    input clk, rst,
    input [XLEN - 1:0] num1, num2, num3, num4,

    output [XLEN - 1:0] result
);

    wire [XLEN - 1:0] mult1, mult2, mult3, mult4, 
                      R1Out, R2Out, R3Out, R4Out, 
                      add1, add2, add3;

    assign mult1 = num1;
    assign mult2 = {3'b100, num2[XLEN - 2: XLEN - 3]};
    assign mult3 = {3'b100, num3[XLEN - 2: XLEN - 3]};
    assign mult4 = {3'b100, num4[XLEN - 2: XLEN - 3]};

    REG r1(.clk(clk), .rst(rst), .in(mult1), .out(R1Out), .ld(1'b1));
    REG r2(.clk(clk), .rst(rst), .in(mult2), .out(R2Out), .ld(1'b1));
    REG r3(.clk(clk), .rst(rst), .in(mult3), .out(R3Out), .ld(1'b1));
    REG r4(.clk(clk), .rst(rst), .in(mult4), .out(R4Out), .ld(1'b1));

    AdderCascade add1(.a(R1Out), .b(R2Out), .result(add1));
    AdderCascade add2(.a(R3Out), .b(R4Out), .result(add2));
    AdderCascade add3(.a(add1),  .b(add2),  .result(add3));

    REG r5(.clk(clk), .rst(rst), .in(add3), .out(result), .ld(1'b1));

endmodule