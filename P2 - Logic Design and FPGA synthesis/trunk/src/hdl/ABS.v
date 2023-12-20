module ABS #(parameter XLEN) (
    input [XLEN - 1 : 0] A,
    input sign,

    output [XLEN - 1 : 0] out
);

    wire [XLEN - 1 : 0] A_twos_comp;

    TwosComp #(XLEN) ATwoComp(A, A_twos_comp);
    
    MUX2 #(XLEN) mux_0(A, A_twos_comp, sign, out);

endmodule