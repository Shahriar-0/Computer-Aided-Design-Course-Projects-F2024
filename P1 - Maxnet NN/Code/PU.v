
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
                        input l1,l2,l3,
                        output [XLEN-1:0] result);
    
    wire [XLEN-1:0] mult1, mult2, mult3, mult4,R1Out,R2Out,R3Out,R4Out,R5Out,R6Out,R7Out;
    
    wire [XLEN-1:0] add1, add2;
    
    FloatingMultiplication #(XLEN) mult_inst1 (.A(num1), .B(weight1), .clk(clk), .result(mult1));
    FloatingMultiplication #(XLEN) mult_inst2 (.A(num2), .B(weight2), .clk(clk), .result(mult2));
    FloatingMultiplication #(XLEN) mult_inst3 (.A(num3), .B(weight3), .clk(clk), .result(mult3));
    FloatingMultiplication #(XLEN) mult_inst4 (.A(num4), .B(weight4), .clk(clk), .result(mult4));
    
    Register R11(.clk(clk),.rst(rst),.data_in(mult1),.data_out(R1Out),.load_enable(l1));
    Register R21(.clk(clk),.rst(rst),.data_in(mult2),.data_out(R2Out),.load_enable(l1));
    Register R31(.clk(clk),.rst(rst),.data_in(mult3),.data_out(R3Out),.load_enable(l1));
    Register R41(.clk(clk),.rst(rst),.data_in(mult4),.data_out(R4Out),.load_enable(l1));
    
    
    
    FloatingAddition #(XLEN) add_inst1 (.A(R1Out), .B(R2Out), .clk(clk), .result(add1));
    FloatingAddition #(XLEN) add_inst2 (.A(R3Out), .B(R3Out), .clk(clk), .result(add2));

    Register RS1(.clk(clk),.rst(rst),.data_in(add1),.data_out(R5Out),.load_enable(l2));
    Register RS2(.clk(clk),.rst(rst),.data_in(add2),.data_out(R6Out),.load_enable(l2));
 
    
    FloatingAddition #(XLEN) add_inst3 (.A(R5Out), .B(R6Out), .clk(clk), .result(result));

    


    
    
endmodule
