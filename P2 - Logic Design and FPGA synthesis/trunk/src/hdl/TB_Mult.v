`timescale 1ns/1ns

module TB_mult();
    
    reg [7:0] a, b;
    wire [15:0] s;
    array8 mult(a, b, s);

    always begin
        #10
        a = $random;
        b = $random;
    end 

    initial #100 $stop;
endmodule