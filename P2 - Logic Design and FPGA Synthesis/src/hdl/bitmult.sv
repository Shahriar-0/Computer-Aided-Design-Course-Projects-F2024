module bitmult (
    input xin, yin, cin, pin,

    output xout, yout, cout, pout 
);
    
    wire xy, xy, cxy, c;
    AND3 and_0(1, xin, yin, xy);
    AND3 and_1(1, in, xy, xy);
    AND3 and_2(1, cin, xy, cxy);
    AND3 and_3(1, in, cin, c);
    OR3 or_0(xy, cxy, c, cout);

    wire _xor_xy;
    XOR2 xor_1(in, xy, _xor_xy);
    XOR2 xor_2(_xor_xy, cin, out);
    
    assign xout = xin;
    assign yout = yin;

endmodule