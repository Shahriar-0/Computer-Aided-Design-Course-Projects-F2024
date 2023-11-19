
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
                        rst,
                        output [XLEN-1:0] result);
    
    wire [XLEN-1:0] mult1, mult2, mult3, mult4, R1Out, R2Out, R3Out, R4Out, add1, add2, add3;
    
    FloatingMultiplication #(XLEN) multInst1(.a(num1), .b(weight1), .result(mult1));
    FloatingMultiplication #(XLEN) multInst2(.a(num2), .b(weight2), .result(mult2));
    FloatingMultiplication #(XLEN) multInst3(.a(num3), .b(weight3), .result(mult3));
    FloatingMultiplication #(XLEN) multInst4(.a(num4), .b(weight4), .result(mult4));
    
    Register R1(.clk(clk), .rst(rst), .in(mult1), .out(R1Out), .ld(1'b1));
    Register R2(.clk(clk), .rst(rst), .in(mult2), .out(R2Out), .ld(1'b1));
    Register R3(.clk(clk), .rst(rst), .in(mult3), .out(R3Out), .ld(1'b1));
    Register R4(.clk(clk), .rst(rst), .in(mult4), .out(R4Out), .ld(1'b1));
    
    FloatingAddition #(XLEN) addInst1(.a(R1Out), .b(R2Out), .result(add1));
    FloatingAddition #(XLEN) addInst2(.a(R3Out), .b(R3Out), .result(add2));
    FloatingAddition #(XLEN) addInst3(.a(add1), .b(add2),   .result(add3));
    
    Register R5(.clk(clk), .rst(rst), .in(add3), .out(result), .ld(1'b1));

endmodule
