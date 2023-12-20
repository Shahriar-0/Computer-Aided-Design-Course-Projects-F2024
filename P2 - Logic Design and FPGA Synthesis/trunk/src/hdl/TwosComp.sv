module TwosComp #(parameter XLEN) (
    input [XLEN - 1 : 0] A,

    output [XLEN - 1 : 0] out
);

    wire [XLEN : 0] res;
    wire [XLEN - 1 : 0] not_A;

    NOT #(XLEN) not_0(A, not_A);
    Adder #(XLEN) adder(not_A, 0, 1'b1, res);
    assign out = res[XLEN - 1 : 0];

endmodule