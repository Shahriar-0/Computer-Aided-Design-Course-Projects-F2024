
module Check(input in1,
             in2,
             in3,
             in4,
             output out);
    
    wire w1, w2, w3, w4, w5;
    
    assign w1  =  in1 & ~in2 & ~in3 & ~in4;
    assign w2  = ~in1 &  in2 & ~in3 & ~in4;
    assign w3  = ~in1 & ~in2 &  in3 & ~in4;
    assign w4  = ~in1 & ~in2 & ~in3 &  in4;
    assign w5  = ~in1 & ~in2 & ~in3 & ~in4;

    assign out = w1 | w2 | w3 | w4 | w5;
    
endmodule
