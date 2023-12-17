module MUX2REG3bit #(parameter bits = 3) (
    input clock, reset, enable,
    input [bits-1:0] A, B,  // Now A and B are 3-bits wide
    input select,
    output reg [bits-1:0] out // Output out is 3-bits wide
);

    genvar i;
    generate
        for (i = 0; i < bits; i = i + 1) begin : bit_mux
            _ACT_S2 #(1) mux2reg(
                .clock(clock),
                .reset(reset),
                .in0(A[i]), 
                .in1(B[i]), 
                .out(out[i]), 
                .enable(enable), 
                .select(select), 
            );
        end
    endgenerate

endmodule