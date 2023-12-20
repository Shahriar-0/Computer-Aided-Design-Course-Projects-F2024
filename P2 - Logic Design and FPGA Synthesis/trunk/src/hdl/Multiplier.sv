module Multiplier #(parameter XLEN = 5) (
    input [XLEN - 1 : 0] A,
    input [XLEN - 1 : 0] B,

    output [2 * XLEN - 1 : 0] out
);

    wire xv [XLEN : 0][XLEN : 0] ;
    wire yv [XLEN : 0][XLEN : 0] ;
    wire cv [XLEN : 0][XLEN : 0] ;
    wire pv [XLEN : 0][XLEN : 0] ;

    genvar i, j;

    generate
        for (i = 0; i < XLEN; i = i + 1) begin
            for (j = 0; j < XLEN; j = j + 1) begin
                bitmult bitm(
                    .xin(xv[i][j]), .yin(yv[i][j]), .cin(cv[i][j]),
                    .pin(pv[i][j + 1]), .xout(xv[i][j + 1]),
                    .yout(yv[i + 1][j]), .cout(cv[i][j + 1]), .pout(pv[i + 1][j])
                );
            end
        end
    endgenerate

    generate
        for (i = 0; i < XLEN; i = i + 1) begin
            assign xv[i][0] = A[i];
            assign cv[i][0] = 1'b0;
            assign pv[0][i + 1] = 1'b0;
            assign pv[i + 1][XLEN] = cv[i][XLEN];
            assign yv[0][i] = B[i];
            assign out[i] = pv[i + 1][0];
            assign out[i + XLEN] = pv[XLEN][i + 1];
        end
    endgenerate
endmodule