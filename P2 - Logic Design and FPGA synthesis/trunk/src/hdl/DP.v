module DP #(parameter XLEN = 5) (
    input clk, rst, ldX, ldTmp, selTmp,

    output done,
    output [XLEN - 1:0] maxnumber
);

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
    REG #(XLEN) x1(.clk(clk), .rst(rst), .ld(ldX), .in(readData1), .out(x1Out));
    REG #(XLEN) x2(.clk(clk), .rst(rst), .ld(ldX), .in(readData2), .out(x2Out));
    REG #(XLEN) x3(.clk(clk), .rst(rst), .ld(ldX), .in(readData3), .out(x3Out));
    REG #(XLEN) x4(.clk(clk), .rst(rst), .ld(ldX), .in(readData4), .out(x4Out));
    
    Decoder decoder(.in1(val1Or), .in2(val2Or), .in3(val3Or), .in4(val4Or), .out(decoderOut));
    MUX4 #(XLEN) outputMux(.a(x1Out), .b(x2Out), .c(x3Out), .d(x4Out), .sel(decoderOut), .out(maxnumber));
    
    
    // checking if we found the maximum number
    assign val1Or = |val1;
    assign val2Or = |val2;
    assign val3Or = |val3;
    assign val4Or = |val4;
    
    Check checker(.in1(val1Or), .in2(val2Or), .in3(val3Or), .in4(val4Or), .out(done));
    
    
    //recording value of x1, x2, x3, x4 as the model trains
    MUX2 #(XLEN) mux1(.a(readData1), .b(relu1Out), .sel(~selTmp), .out(mux1Out));
    MUX2 #(XLEN) mux2(.a(readData2), .b(relu2Out), .sel(~selTmp), .out(mux2Out));
    MUX2 #(XLEN) mux3(.a(readData3), .b(relu3Out), .sel(~selTmp), .out(mux3Out));
    MUX2 #(XLEN) mux4(.a(readData4), .b(relu4Out), .sel(~selTmp), .out(mux4Out));
    
    REG #(XLEN) tmp1(.clk(clk), .rst(rst), .ld(ldTmp), .in(mux1Out), .out(val1));
    REG #(XLEN) tmp2(.clk(clk), .rst(rst), .ld(ldTmp), .in(mux2Out), .out(val2));
    REG #(XLEN) tmp3(.clk(clk), .rst(rst), .ld(ldTmp), .in(mux3Out), .out(val3));
    REG #(XLEN) tmp4(.clk(clk), .rst(rst), .ld(ldTmp), .in(mux4Out), .out(val4));
    
    
    // processing unit 1
    PU1 #(XLEN) pu1(
    .clk(clk), .rst(rst), 
    .num1(val1), .num2(val2), 
    .num3(val3), .num4(val4), 
    .result(PU1Out)
    );

    // processing unit 2
    PU2 #(XLEN) pu2(
    .clk(clk), .rst(rst),
    .num1(val1), .num2(val2),
    .num3(val3), .num4(val4),
    .result(PU2Out)
    );

    // processing unit 3
    PU3 #(XLEN) pu3(
    .clk(clk), .rst(rst),
    .num1(val1), .num2(val2),
    .num3(val3), .num4(val4),
    .result(PU3Out)
    );

    // processing unit 4
    PU4 #(XLEN) pu4(
    .clk(clk), .rst(rst),
    .num1(val1), .num2(val2),
    .num3(val3), .num4(val4),
    .result(PU4Out)
    );
    
    ReLU relu1(.in(PU1Out), .out(relu1Out));
    ReLU relu2(.in(PU2Out), .out(relu2Out));
    ReLU relu3(.in(PU3Out), .out(relu3Out));
    ReLU relu4(.in(PU4Out), .out(relu4Out));
    
endmodule
