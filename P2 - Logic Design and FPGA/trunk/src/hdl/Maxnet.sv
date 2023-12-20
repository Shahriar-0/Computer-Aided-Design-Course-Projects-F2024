module MaxNet (
    input clk, rst,
    output done,
    output [4:0] max 
);

    wire [4:0] w0 [3:0];
    wire [4:0] w1 [3:0];
    wire [4:0] w2 [3:0];
    wire [4:0] w3 [3:0];
    wire [4:0] x_in [3:0];
    wire [4:0] y_out [3:0];
    wire [4:0] y_in [3:0];
    wire [4:0] p_out [3:0];
    wire read, slc_y, ld_y, ld_mult, ld_sum, s0, s1, s2, s3, 
         not_s0, not_s1, not_s2, not_s3, sx0, sx1, sx2, sx3;

    NOT not_0(s0, not_s0);
    NOT not_1(s1, not_s1);
    NOT not_2(s2, not_s2);
    NOT not_3(s3, not_s3);

    AND6 and_0(s0, not_s1, not_s2, not_s3, 1, 1, sx0);
    AND6 and_1(not_s0, s1, not_s2, not_s3, 1, 1, sx1);
    AND6 and_2(not_s0, not_s1, s2, not_s3, 1, 1, sx2);
    AND6 and_3(not_s0, not_s1, not_s2, s3, 1, 1, sx3);
    OR6 or_0(sx0, sx1, sx2, sx3, 0, 0, s);

    DataMemoryX RX(clk, read, x_in);
    DataMemoryW RW(clk, read, w0, w1, w2, w3);
    DataMemoryY RY(clk, ld_y, y_in, y_out);

    MUX2PAR RYS(x_in, p_out, slc_y, y_in);

    ProcessUnit PU_0(clk, ld_mult, ld_sum, y_out, w0, s0, p_out[0]);
    ProcessUnit PU_1(clk, ld_mult, ld_sum, y_out, w1, s1, p_out[1]);
    ProcessUnit PU_2(clk, ld_mult, ld_sum, y_out, w2, s2, p_out[2]);
    ProcessUnit PU_3(clk, ld_mult, ld_sum, y_out, w3, s3, p_out[3]);

    OneHot4 oneh(x_in[0], x_in[1], x_in[2], x_in[3], {s0,s1,s2,s3}, max);

    Controller cu(clk, rst, s, read, ld_y, slc_y, ld_mult, ld_sum, done);
endmodule