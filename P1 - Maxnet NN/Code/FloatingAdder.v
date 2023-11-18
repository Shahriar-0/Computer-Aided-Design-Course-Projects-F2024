module Adder #(parameter N = 32)
              (input [N-1:0] a,
               b,
               output reg [N-1:0] result);
    
    reg [23:0] aMantis, bMantis, tmpMantis;
    reg [22:0] resultMantis;
    reg [7:0] aExp, bExp, diffExp, resultExp;
    reg aSign, bSign, resultSign, carry, comp;
    wire MSb;
    
    always @(*) begin
        comp = (a[30:23] > b[30:23])? 1'b1 :
        (a[30:23] == b[30:23] && a[22:0] > b[22:0]) ? 1'b1 : 1'b0;
        
        aMantis = comp ? {1'b1,a[22:0]} : {1'b1,b[22:0]};
        aExp    = comp ? a[30:23] : b[30:23];
        
        aSign = comp ? a[31] : b[31];
        
        bMantis = comp ? {1'b1,b[22:0]} : {1'b1,a[22:0]};
        bExp    = comp ? b[30:23] : a[30:23];
        
        bSign = comp ? b[31] : a[31];
        
        diffExp = aExp - bExp;
        
        bMantis = (bMantis >> diffExp);
        
        {carry, tmpMantis} = (aSign  ~^ bSign) ? (aMantis + bMantis) : (aMantis - bMantis);
        
        resultExp = aExp;
        
        if (carry) begin
            tmpMantis = tmpMantis>>1;
            resultExp = resultExp+1'b1;
        end
        else begin
            while(!tmpMantis[23]) begin
                tmpMantis = tmpMantis<<1;
                resultExp = resultExp-1'b1;
            end
        end
        
        resultSign   = aSign;
        resultMantis = tmpMantis[22:0];
        result       = {resultSign, resultExp, resultMantis};
    end
endmodule
