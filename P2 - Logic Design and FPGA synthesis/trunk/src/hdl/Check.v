
module Check(
    input in1, in2, in3, in4,
    
    output out
);
    
    wire w1, w2, w3, w4, w5;
    
    AND4NOT3 and4not3_0(in1, in2, in3, in4, w1);
    AND4NOT3 and4not3_1(in2, in1, in3, in4, w2);
    AND4NOT3 and4not3_2(in3, in2, in1, in4, w3);
    AND4NOT3 and4not3_3(in4, in2, in3, in1, w4);
    AND4NOT4 and4not4_0(w1, w2, w3, w4, w5);

    OR5 or5_0(w1, w2, w3, w4, w5, out);
    
endmodule
