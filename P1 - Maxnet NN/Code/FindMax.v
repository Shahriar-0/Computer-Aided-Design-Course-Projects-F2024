`timescale 1ns / 1ps

module check_negatives (
    input signed [31:0] in1, in2, in3, in4,
    output reg [3:0] non_negatives,
    output reg three_negatives
);
    always @(*) begin
        non_negatives[0] = (in1 > 0);
        non_negatives[1] = (in2 > 0);
        non_negatives[2] = (in3 > 0);
        non_negatives[3] = (in4 > 0);
        
        integer num_negatives = (in1 == 0) + (in2 == 0) + (in3 == 0) + (in4 == 0);
        three_negatives = (num_negatives == 3);
    end
endmodule

