`timescale 1ns / 1ns;

module TestBench();
    reg clk, rst, start;
    wire [31:0] maxnumber;

    TopModule topModule(.clk(clk), .rst(rst), .start(start), .maxnumber(maxnumber));

    always #5 clk = ~clk;
    
    initial begin
    clk = 0; rst = 1; start = 0;
    #10 rst = 0;
    #10 start = 1;
    #100 start = 0;
    #1000 $stop;
  end

  always @(posedge clk) begin
    $display("Time=%0t rst=%b start=%b maximum_number=%h", $time, rst, start, maxnumber);
  end

endmodule
