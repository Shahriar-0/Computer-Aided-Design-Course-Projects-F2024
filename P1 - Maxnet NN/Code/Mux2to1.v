module mux2bit (input [31:0] a,
                b,
                input sel,
                output reg [31:0] y);

    always @(*) begin
        if (sel)
            y = b;
        else
            y = a;
    end
    
endmodule
