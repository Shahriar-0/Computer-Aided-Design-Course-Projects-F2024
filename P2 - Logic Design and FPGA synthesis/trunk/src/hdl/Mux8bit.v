module MUX8 #(parameter bits = 1) (
    input [bits - 1 : 0] A, B, C, D, E, F, G, H,
    input [2:0] select,  

    output [bits - 1 : 0] out
);
    wire [bits - 1 : 0] mux4_out_0, mux4_out_1;
    
    MUX4 #(bits) lower_mux4 (
        .A(A), .B(B), .C(C), .D(D),
        .select(select[1:0]),
        .out(mux4_out_0)
    );
    
    MUX4 #(bits) upper_mux4 (
        .A(E), .B(F), .C(G), .D(H),
        .select(select[1:0]),
        .out(mux4_out_1)
    );
    
    MUX2 #(bits) final_mux4 (
        .A(mux4_out_0), .B(mux4_out_1),
        .select({1'b0, select[2]}),  
        .out(out)
    );

endmodule