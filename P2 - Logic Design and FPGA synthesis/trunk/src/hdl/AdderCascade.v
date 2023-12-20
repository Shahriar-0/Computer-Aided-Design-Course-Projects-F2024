module AdderCascade #(parameter XLEN) (
    input [XLEN - 1 : 0] A,
    input [XLEN - 1 : 0] B,
    input carry_in,

    output [XLEN : 0] out
);
    wire [XLEN : 0] carry;
    assign carry[0] = carry_in;
    assign out[XLEN] = carry[XLEN];

    genvar i;
    generate
        for (i = 0; i < XLEN ; i = i + 1) begin: adders
            Adder adr(A[i],B[i],carry[i],out[i],carry[i+1]);
        end
    endgenerate
endmodule