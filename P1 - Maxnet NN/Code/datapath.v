module TopModule (
    input clock, reset, writeEn,
    input [31:0] address, write_data, num1, num2, num3, num4, weight1, weight2, weight3, weight4,
    output [31:0]result
);
    wire [31:0] data_out, relu_out,read_data;
    wire [31:0]  weight1, weight2, weight3, weight4,
    output [31:0]result
    wire s1, s2, s3, s4;
    wire [1:0] findmax;
    DataMemory mem1 (.clock(clock), .writeEn(writeEn), .reset(reset), .address(address), .write_data(data_out), .read_data(read_data));

    Register reg1 (.clock(clock), .reset(reset), .data_in(write_data), .data_out(data_out));
    
    
    DataMemory mem1 (.clock(clock), .writeEn(writeEn), .reset(reset), .address(address), .write_data(data_out), .read_data(read_data));
    relu relu1 (.x(num1), .y(relu_out));
    findmaxout max1 (.s1(s1), .s2(s2), .s3(s3), .s4(s4), .findmax(findmax));
    ProcessingUnit proc1 (.num1(num1), .num2(num2), .num3(num3), .num4(num4), .weight1(weight1), .weight2(weight2), .weight3(weight3), .weight4(weight4), .clk(clock), .result(result));

endmodule
