module Decoder(
    input in1, in2, in3, in4,

    output reg [1:0] out
);
    
    AND2 and1(in4, in2, out[0]);
    AND2 and2(in4, in3, out[1]);

endmodule
