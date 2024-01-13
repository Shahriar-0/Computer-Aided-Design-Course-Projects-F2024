`timescale 1ns/1ns

module TB();
    reg clk, rst;
    wire [4:0] max;
    wire done;
    MaxNet m(clk, rst, done, max);
    always #5 clk = ~clk;

    initial begin
        #10 rst = 0;
        #10 rst = 1;
        #10 rst = 0;
        #400 $stop;
    end
    
endmodule