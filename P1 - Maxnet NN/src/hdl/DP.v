module DP #(parameter XLEN = 32)
           (input clk,
            rst,
            ldX,
            ldTmp,
            selTmp,
            output done,
            output [XLEN - 1:0] maxnumber);
    
    wire [XLEN - 1:0] readData1, readData2, readData3, readData4;
    wire [1:0] decoderOut;
    wire [XLEN - 1:0] relu1Out, relu2Out, relu3Out, relu4Out;
    wire [XLEN - 1:0] mux1Out, mux2Out, mux3Out, mux4Out;
    wire [XLEN - 1:0] x1Out, x2Out, x3Out, x4Out;
    wire [XLEN - 1:0] val1, val2, val3, val4;
    wire val1Or, val2Or, val3Or, val4Or;
    wire [XLEN - 1:0] w11, w12, w13, w14;
    wire [XLEN - 1:0] w21, w22, w23, w24;
    wire [XLEN - 1:0] w31, w32, w33, w34;
    wire [XLEN - 1:0] w41, w42, w43, w44;
    wire [XLEN - 1:0] PU1Out, PU2Out, PU3Out, PU4Out;
    
    
    // input data
    DataMemory DM(
    .clk(clk), .rst(rst),
    .readData1(readData1), .readData2(readData2),
    .readData3(readData3), .readData4(readData4)
    );
    
    
    // showing the maximum number
    Register x1(.clk(clk), .rst(rst), .ld(ldX), .in(readData1), .out(x1Out));
    Register x2(.clk(clk), .rst(rst), .ld(ldX), .in(readData2), .out(x2Out));
    Register x3(.clk(clk), .rst(rst), .ld(ldX), .in(readData3), .out(x3Out));
    Register x4(.clk(clk), .rst(rst), .ld(ldX), .in(readData4), .out(x4Out));
    
    Decoder decoder(.in1(val1Or), .in2(val2Or), .in3(val3Or), .in4(val4Or), .out(decoderOut));
    Mux4to1 outputMux(.a(x1Out), .b(x2Out), .c(x3Out), .d(x4Out), .sel(decoderOut), .out(maxnumber));
    
    
    // checking if we found the maximum number
    assign val1Or = |val1;
    assign val2Or = |val2;
    assign val3Or = |val3;
    assign val4Or = |val4;
    
    Check checker(.in1(val1Or), .in2(val2Or), .in3(val3Or), .in4(val4Or), .out(done));
    
    
    //recording value of x1, x2, x3, x4 as the model trains
    Mux2to1 mux1(.a(readData1), .b(relu1Out), .sel(~selTmp), .out(mux1Out));
    Mux2to1 mux2(.a(readData2), .b(relu2Out), .sel(~selTmp), .out(mux2Out));
    Mux2to1 mux3(.a(readData3), .b(relu3Out), .sel(~selTmp), .out(mux3Out));
    Mux2to1 mux4(.a(readData4), .b(relu4Out), .sel(~selTmp), .out(mux4Out));
    
    Register tmp1(.clk(clk), .rst(rst), .ld(ldTmp), .in(mux1Out), .out(val1));
    Register tmp2(.clk(clk), .rst(rst), .ld(ldTmp), .in(mux2Out), .out(val2));
    Register tmp3(.clk(clk), .rst(rst), .ld(ldTmp), .in(mux3Out), .out(val3));
    Register tmp4(.clk(clk), .rst(rst), .ld(ldTmp), .in(mux4Out), .out(val4));
    
    
    // pu and relu
    Matrix matrix(
    .W0(w11),  .W1(w12),  .W2(w13),  .W3(w14),
    .W4(w21),  .W5(w22),  .W6(w23),  .W7(w24),
    .W8(w31),  .W9(w32),  .W10(w33), .W11(w34),
    .W12(w41), .W13(w42), .W14(w43), .W15(w44)
    );
    
    ProcessingUnit p1(
    .clk(clk),     .rst(rst),     .result(PU1Out),
    .num1(val1),   .num2(val2),   .num3(val3),   .num4(val4),
    .weight1(w11), .weight2(w12), .weight3(w13), .weight4(w14)
    );
    
    ProcessingUnit p2(
    .clk(clk),     .rst(rst),     .result(PU2Out),
    .num1(val1),   .num2(val2),   .num3(val3),   .num4(val4),
    .weight1(w21), .weight2(w22), .weight3(w23), .weight4(w24)
    );
    
    ProcessingUnit p3(
    .clk(clk),     .rst(rst),     .result(PU3Out),
    .num1(val1),   .num2(val2),   .num3(val3),   .num4(val4),
    .weight1(w31), .weight2(w32), .weight3(w33), .weight4(w34)
    );
    
    ProcessingUnit p4(
    .clk(clk),     .rst(rst),     .result(PU4Out),
    .num1(val1),   .num2(val2),   .num3(val3),   .num4(val4),
    .weight1(w41), .weight2(w42), .weight3(w43), .weight4(w44)
    );
    
    ReLU relu1(.in(PU1Out), .out(relu1Out));
    ReLU relu2(.in(PU2Out), .out(relu2Out));
    ReLU relu3(.in(PU3Out), .out(relu3Out));
    ReLU relu4(.in(PU4Out), .out(relu4Out));
    
endmodule
