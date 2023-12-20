module BIT_MULT(
    input xi, yi, pi, ci,
    
    output xo, yo, po, co
);
    wire xy, pi_and_xy, pi_and_ci, xy_and_ci;
    
    AND2 and2_1(xi, yi, xy);
    AND2 and2_2(pi, xy, pi_and_xy);
    AND2 and2_3(pi, ci, pi_and_ci);
    AND2 and2_4(xy, ci, xy_and_ci);

    OR3 or3_1(pi_and_xy, pi_and_ci, xy_and_ci, co);
    XOR3 xor3_1(pi, xy, ci, po);
    assign xo = xi;
    assign yo = yi;
    // BUF buf_1(xi, xo);
    // BUF buf_2(yi, yo);
endmodule
