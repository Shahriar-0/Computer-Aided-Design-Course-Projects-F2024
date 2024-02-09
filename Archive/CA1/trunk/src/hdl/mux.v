module Mux2to1 (sel, a0, a1, out);
    parameter N = 25;

    input sel;
    input [N-1:0] a0, a1;
    output [N-1:0] out;

    assign out = sel ? a1 : a0;
endmodule
