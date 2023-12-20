module bitmult (
    input xin, yin, cin, pin,

    output xout, yout, cout, pout 
);
    
    wire xy, pxy, cxy, pc;
    AND3 and_0(1, xin, yin, xy);
    AND3 and_1(1, pin, xy, pxy);
    AND3 and_2(1, cin, xy, cxy);
    AND3 and_3(1, pin, cin, pc);
    OR3 or_0(pxy, cxy, pc, cout);

    wire p_xor_xy;
    XOR2 xor_1(pin, xy, p_xor_xy);
    XOR2 xor_2(p_xor_xy, cin, pout);
    
    assign xout = xin;
    assign yout = yin;

endmodule