module MUX22bit #(parameter bits = 2) (
    input [bits - 1 : 0] A, B,
    input select,
    output [bits - 1 : 0] out
);

generate
    genvar i;
    for(i = 0; i < bits; i = i + 1) begin: mux_loop
        _ACT_C2 #(bits) my_mux2(A[i], B[i], 0, 0, 0, 0, select, 1, out[i]);
    end
endgenerate

endmodule