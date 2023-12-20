module Mux2to1 #(parameter XLEN = 5)
    (input [XLEN - 1:0] a, b,
    input sel,

    output [XLEN - 1:0] out
);
    
    assign out = (~sel)? a : b;
    
endmodule
