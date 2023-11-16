`timescale 1ns / 1ps

module ProcessingUnit #(parameter XLEN = 32)
                       (input [XLEN-1:0] num1,
                        num2,
                        num3,
                        num4,
                        input [XLEN-1:0] weight1,
                        weight2,
                        weight3,
                        weight4,
                        input clk,
                        output overflow,
                        output underflow,
                        output exception,
                        output reg [XLEN-1:0] result);
    
    reg [XLEN-1:0] mult1, mult2, mult3, mult4;
    
    reg [XLEN-1:0] add1, add2;
    
    FloatingMultiplication #(XLEN) mult_inst1 (.A(num1), .B(weight1), .clk(clk), .result(mult1));
    FloatingMultiplication #(XLEN) mult_inst2 (.A(num2), .B(weight2), .clk(clk), .result(mult2));
    FloatingMultiplication #(XLEN) mult_inst3 (.A(num3), .B(weight3), .clk(clk), .result(mult3));
    FloatingMultiplication #(XLEN) mult_inst4 (.A(num4), .B(weight4), .clk(clk), .result(mult4));
    
    FloatingAddition #(XLEN) add_inst1 (.A(mult1), .B(mult2), .clk(clk), .result(add1));
    FloatingAddition #(XLEN) add_inst2 (.A(mult3), .B(mult4), .clk(clk), .result(add2));
    FloatingAddition #(XLEN) add_inst3 (.A(add1), .B(add2), .clk(clk), .result(result));
    
endmodule
