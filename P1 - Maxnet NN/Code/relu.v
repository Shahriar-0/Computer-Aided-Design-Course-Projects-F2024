module relu  (
    input wire [31:0] x,
    output wire [31:0] y
);
    assign y = x[31] ? 32'b0 : x;
endmodule

