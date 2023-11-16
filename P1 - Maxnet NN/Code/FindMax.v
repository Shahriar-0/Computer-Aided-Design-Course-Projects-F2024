`timescale 1ns / 1ps

module findmaxout #(parameter XLEN = 32)
                   (input s1,
                    s2,
                    s3,
                    s4,
                    output reg [1:0] findmax);
    
    always @(*)
    begin
        findmax                                   = 2'b00;
        if (!s1 && (s2 || s3 || s4)) findmax      = 2'b01;
        else if (!s2 && (s1 || s3 || s4)) findmax = 2'b10;
        else if (!s3 && (s1 || s2 || s4)) findmax = 2'b11;
        else if (!s4 && (s1 || s2 || s3)) findmax = 2'b100;
    end
    
endmodule
