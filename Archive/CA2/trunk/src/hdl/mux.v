module Mux2to1 (sel, a0, a1, out);
    parameter N = 25;

    input sel;
    input [N-1:0] a0, a1;
    output [N-1:0] out;

    assign out = sel ? a1 : a0;
endmodule

module Mux8to1 (sel, a0, a1, a2, a3, a4, a5, a6, a7, out);
    parameter N = 32;

    input [2:0] sel;
    input [N-1:0] a0, a1, a2, a3, a4, a5, a6, a7;
    output [N-1:0] out;

    assign out = (sel == 4'b000) ? a0 :
                 (sel == 4'b001) ? a1 :
                 (sel == 4'b010) ? a2 :
                 (sel == 4'b011) ? a3 :
                 (sel == 4'b100) ? a4 :
                 (sel == 4'b101) ? a5 :
                 (sel == 4'b110) ? a6 :
                 (sel == 4'b111) ? a7 : {N{1'bz}};
endmodule
