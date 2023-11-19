module DP(input clk,
          rst,
          ldX,
          ldTmp,
          selTmp,
          output done,
          output [31:0] maxnumber);
    
    wire [31:0] readData1, readData2, readData3, readData4;
    wire [1:0] decoderOut;
    wire [31:0] relu1Out, relu2Out, relu3Out, relu4Out;
    wire [31:0] mux1Out, mux2Out, mux3Out, mux4Out;
    wire [31:0] x1Out, x2Out, x3Out, x4Out;
    wire [31:0] val1Out, val2Out, val3Out, val4Out;
    wire val1OutOr, val2OutOr, val3OutOr, val4OutOr;
    wire [31:0] w11, w12, w13, w14;
    wire [31:0] w21, w22, w23, w24;
    wire [31:0] w31, w32, w33, w34;
    wire [31:0] w41, w42, w43, w44;
    wire [31:0] PU1Out, PU2Out, PU3Out, PU4Out;
    
    DataMemory DM(
        .clk(clk), .rst(rst), 
        .readData1(readData1), .readData2(readData2), 
        .readData3(readData3), .readData4(readData4)
    );

    
    
    // this part is for showing the maximum number
    Register x1(.clk(clk), .rst(rst), .ld(ldX), .in(readData1), .out(x1Out));
    Register x2(.clk(clk), .rst(rst), .ld(ldX), .in(readData2), .out(x2Out));
    Register x3(.clk(clk), .rst(rst), .ld(ldX), .in(readData3), .out(x3Out));
    Register x4(.clk(clk), .rst(rst), .ld(ldX), .in(readData4), .out(x4Out));
    Decoder decoder(.in1(val1OutOr), .in2(val2OutOr), .in3(val3OutOr), .in4(val4OutOr), .out(decoderOut));
    Mux4to1 outputMux(.a(x1Out), .b(x2Out), .c(x3Out), .d(x4Out), .sel(decoderOut), .out(maxnumber));
    
    // this part for recording value of x1, x2, x3, x4 as the model trains
    Mux2to1 mux1(.a(readData1), .b(relu1Out), .sel(selTmp), .out(mux1Out));
    Mux2to1 mux2(.a(readData2), .b(relu2Out), .sel(selTmp), .out(mux2Out));
    Mux2to1 mux3(.a(readData3), .b(relu3Out), .sel(selTmp), .out(mux3Out));
    Mux2to1 mux4(.a(readData4), .b(relu4Out), .sel(selTmp), .out(mux4Out));
    
    Register tmp1(.clk(clk), .rst(rst), .ld(ldTmp), .in(mux1Out), .out(val1Out));
    Register tmp2(.clk(clk), .rst(rst), .ld(ldTmp), .in(mux2Out), .out(val2Out));
    Register tmp3(.clk(clk), .rst(rst), .ld(ldTmp), .in(mux3Out), .out(val3Out));
    Register tmp4(.clk(clk), .rst(rst), .ld(ldTmp), .in(mux4Out), .out(val4Out));
    
    // this part is for pu and relu
    Matrix matrix(
        .W0(w11), .W1(w12), .W2(w13), .W3(w14),
        .W4(w21), .W5(w22), .W6(w23), .W7(w24),
        .W8(w31), .W9(w32), .W10(w33), .W11(w34),
        .W12(w41), .W13(w42), .W14(w43), .W15(w44)
    );

    assign val1OutOr = |val1Out;
    assign val2OutOr = |val2Out;
    assign val3OutOr = |val3Out;
    assign val4OutOr = |val4Out;
    
    Check checker(.in1(val1OutOr), .in2(val2OutOr), .in3(val3OutOr), .in4(val4OutOr), .out(done));
    
    ProcessingUnit p1(
        .clk(clk), .rst(rst), .result(PU1Out),
        .num1(val1Out), .num2(val2Out), .num3(val3Out), .num4(val4Out),
        .weight1(w11), .weight2(w12), .weight3(w13), .weight4(w14)
    );

    ProcessingUnit p2(
        .clk(clk), .rst(rst), .result(PU2Out),
        .num1(val1Out), .num2(val2Out), .num3(val3Out), .num4(val4Out),
        .weight1(w21), .weight2(w22), .weight3(w23), .weight4(w24)
    );

    ProcessingUnit p3(
        .clk(clk), .rst(rst), .result(PU3Out),
        .num1(val1Out), .num2(val2Out), .num3(val3Out), .num4(val4Out),
        .weight1(w31), .weight2(w32), .weight3(w33), .weight4(w34)
    );

    ProcessingUnit p4(
        .clk(clk), .rst(rst), .result(PU4Out),
        .num1(val1Out), .num2(val2Out), .num3(val3Out), .num4(val4Out),
        .weight1(w41), .weight2(w42), .weight3(w43), .weight4(w44)
    );
        
    ReLU relu1(.in(PU1Out), .out(relu1Out));
    ReLU relu2(.in(PU2Out), .out(relu2Out));
    ReLU relu3(.in(PU3Out), .out(relu3Out));
    ReLU relu4(.in(PU4Out), .out(relu4Out));

endmodule
