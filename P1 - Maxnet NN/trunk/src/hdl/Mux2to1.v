module Mux2to1(input [31:0] a,
               b,
               input sel,
               output [31:0] out);


assign out = (~sel)? a : b;

endmodule
