`timescale 1ns / 1ns;

module TestBench();
    reg clk, rst, start;
    wire [31:0] maxnumber;

    TopModule topModule(.clk(clk), .rst(rst), .start(start), .maxnumber(maxnumber));

    always #5 clk = ~clk;
    
    initial begin
        clk = 0; rst = 1; start = 1;
        #5 rst = 0;
        #5 start = 0;
        #1500 $stop;
    end
endmodule
