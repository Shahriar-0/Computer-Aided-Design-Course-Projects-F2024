module AdderCascade #(parameter XLEN) (
    input [XLEN - 1 : 0] A,
    input [XLEN - 1 : 0] B,
    input carry_in,

    output [XLEN - 1 : 0] out
);

    wire [XLEN : 0] insideOut;
    wire [XLEN : 0] carry;
    assign carry[0] = carry_in;
    assign insideOut[XLEN] = carry[XLEN];

    genvar i;
    generate
        for (i = 0; i < XLEN ; i = i + 1) begin: adders
            Adder adr(A[i], B[i], carry[i], insideOut[i], carry[i+1]);
        end
    endgenerate

    assign out = insideOut[XLEN - 1 : 0];
endmodule