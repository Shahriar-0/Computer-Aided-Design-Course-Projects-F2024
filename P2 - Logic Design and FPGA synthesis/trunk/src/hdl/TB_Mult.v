`timescale 1ns/1ns

module TB_mult();
    
    reg [9:0] a, b;
    wire [19:0] s;
    MULT #(10) mult(a, b, s);

    always begin
        #10
        a = $random;
        b = $random;
    end 

    initial #100 $stop;
endmodule