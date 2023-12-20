module MUX8 #(parameter XLEN = 1) (
    input [XLEN - 1 : 0] A, B, C, D, E, F, G, H,
    input [2:0] select,  

    output [XLEN - 1 : 0] out
);
    wire [XLEN - 1 : 0] mux4_out_0, mux4_out_1;
    
    MUX4 #(XLEN) lower_mux4 (
        .A(A), .B(B), .C(C), .D(D),
        .select(select[1:0]),
        .out(mux4_out_0)
    );
    
    MUX4 #(XLEN) upper_mux4 (
        .A(E), .B(F), .C(G), .D(H),
        .select(select[1:0]),
        .out(mux4_out_1)
    );
    
    MUX2 #(XLEN) final_mux2 (
        .A(mux4_out_0), .B(mux4_out_1),
        .select({1'b0, select[2]}),  
        .out(out)
    );

endmodule