module DataMemoryY (
    input clk, ld,
    input [4:0] in [3:0],

    output [4:0] out [3:0]
);

    REG y0(clk, 1'b0, ld, in[0], out[0]);
    REG y1(clk, 1'b0, ld, in[1], out[1]);
    REG y2(clk, 1'b0, ld, in[2], out[2]);
    REG y3(clk, 1'b0, ld, in[3], out[3]);

endmodule