module relu  (
    input wire [31:0] B,
    output wire [31:0] y
);
    assign y = B[31] ? 32'b0 : B;
endmodule

