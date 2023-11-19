module FloatingMultiplication #(parameter XLEN = 32)
                               (input [XLEN - 1:0] a,
                                b,
                                output reg [XLEN - 1:0] result);
    
    reg [47:0] tempMantis;
    reg [23:0] aMantis, bMantis;
    reg [22:0] resultMantis;
    reg [7:0] aExp, bExp, tmpExp, resultExp;
    reg aSign, bSign, resultSign;
    
    always @(*) begin
        aMantis = {1'b1, a[22:0]};
        aExp    = a[30:23];
        aSign   = a[31];
        
        bMantis = {1'b1, b[22:0]};
        bExp    = b[30:23];
        bSign   = b[31];
        
        tmpExp     = aExp + bExp - 127;
        tempMantis = aMantis * bMantis;
        
        resultExp    = tempMantis[47] ? tmpExp + 1'b1 : tmpExp;
        resultMantis = tempMantis[47] ? tempMantis[46:24] : tempMantis[45:23];
        resultSign = aSign ^ bSign;
        
        result = (a == 32'b0 || b == 32'b0) ? 0 : {resultSign, resultExp, resultMantis};
    end
    
endmodule
