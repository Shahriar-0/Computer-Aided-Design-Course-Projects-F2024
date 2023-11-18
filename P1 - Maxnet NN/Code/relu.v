module relu  (
    input wire [31:0] B,
    output wire [31:0] y
);
    reg[31:0] zero = 32'h0;
    assign y = B[31] ? zero : B;
endmodule

