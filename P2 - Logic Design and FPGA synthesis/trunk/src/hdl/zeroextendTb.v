`timescale 1ns / 1ps

module ZeroExtend2to3_tb;

    reg [1:0] in;

    // Outputs
    wire [2:0] out;

    ZeroExtend2to3 uut (
        .in(in), 
        .out(out)
    );

    initial begin
        // Initialize Inputs
        in = 0;

        #100;
        
        $display("Time\tIn\tOut");
        #10 in = 2'b00; $display("%g\t%b\t%b", $time, in, out);
        #10 in = 2'b01; $display("%g\t%b\t%b", $time, in, out);
        #10 in = 2'b10; $display("%g\t%b\t%b", $time, in, out);
        #10 in = 2'b11; $display("%g\t%b\t%b", $time, in, out);

        #10 $finish;
    end
      
endmodule