module MUX2REG #(parameter bits = 3) (
    input clock, reset, enable,
    input [bits-1:0] A, B, 
    input select,
    output reg [bits-1:0] out 
);

    genvar i;
    generate
        for (i = 0; i < bits; i = i + 1) begin : bit_mux
            __ACT_S2 #(1) mux2reg(
                .clock(clock),
                .reset(reset),
                .in0(A[i]), 
                .in1(B[i]), 
                .out(out[i]), 
                .enable(enable), 
                .select(select)
            );
        end
    endgenerate

endmodule