module Multiplier(a, b, out);
    parameter N = 32;

    input [N-1:0] a, b;
    output [N*N-1:0] out;

    assign out = a * b;
endmodule
