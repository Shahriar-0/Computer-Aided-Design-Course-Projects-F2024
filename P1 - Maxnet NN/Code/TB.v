`timescale 1ns / 1ns;

module TestBench();
    reg clk = 0, rst = 0,start;

    always #5 clk = ~clk;
    
    initial begin
        clk = 0; rst = 1;
        #5 rst = 0;
        #5 start = 1;
        #5 start = 0;
        #1500 $stop;
    end
endmodule
