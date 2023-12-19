module MUX4REG3 #(parameter bits = 3) ( 
    input clock, reset,
    input [bits - 1 : 0] A, B, C, D,
    input [1:0] select,
    output [bits - 1 : 0] out
);

genvar i;
generate
    for (i = 0; i < bits; i = i + 1) begin: mux_cascade
        __ACT_S2 #(1) mux4reg(
            .clock(clock), 
            .reset(reset),
            .D00(A[i]),
            .D01(B[i]), 
            .D10(C[i]), 
            .D11(D[i]), 
            .A1(select[1]),
            .B1(0), 
            .A0(select[0]),
            .B0(1), 
            .out(out[i])
        );
    end
    // __ACT_S2
endgenerate

endmodule