module PU3 #(parameter XLEN = 5) (
    input clk, rst,
    input [XLEN - 1:0] num1, num2, num3, num4,

    output [XLEN - 1:0] result
);

    wire [XLEN - 1:0] mult1, mult2, mult3, mult4, 
                      R1Out, R2Out, R3Out, R4Out, 
                      add1, add2, add3;

    assign mult1 = {3'b100, num1[XLEN - 2: XLEN - 3]};
    assign mult2 = {3'b100, num2[XLEN - 2: XLEN - 3]};
    assign mult3 = num3;
    assign mult4 = {3'b100, num4[XLEN - 2: XLEN - 3]};
    
endmodule