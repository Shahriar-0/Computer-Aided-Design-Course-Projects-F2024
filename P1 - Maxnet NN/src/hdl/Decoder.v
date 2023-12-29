module Decoder(input in1,
               in2,
               in3,
               in4,
               output reg [1:0] out);

    always @(*) begin
        if (in1)
            out = 2'b00;
        else if (in2)
            out = 2'b01;
        else if (in3)
            out = 2'b10;
        else if (in4)
            out = 2'b11;
        else
            out = 2'b00;
    end
    
endmodule
