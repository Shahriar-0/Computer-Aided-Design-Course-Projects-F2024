module FloatingAddition #(parameter XLEN = 32)
                         (input [XLEN-1:0]A,
                          input [XLEN-1:0]B,
                          input clk,
                          output overflow,
                          output underflow,
                          output exception,
                          output reg [XLEN-1:0] result);
    
    reg [23:0] MantisA,MantisB;
    reg [23:0] MantisT;
    reg [22:0] Mantissa;
    reg [7:0] E;
    reg Sign;
    wire MSB;
    reg [7:0] A_E, B_E, Temp_E, diff_E;
    reg signA, signB, Temp_sign;
    reg [32:0] Temp;
    reg carry;
    reg [2:0] one_hot;
    reg comp;
    reg [7:0] exp_adjust;
    
    always @(*) begin
        comp = (A[30:23] > = B[30:23])? 1'b1 : 1'b0;
        
        MantisA = comp ? {1'b1,A[22:0]} : {1'b1,B[22:0]};
        A_E     = comp ? A[30:23] : B[30:23];
        signA   = comp ? A[31] : B[31];
        
        MantisB = comp ? {1'b1,B[22:0]} : {1'b1,A[22:0]};
        B_E     = comp ? B[30:23] : A[30:23];
        signB   = comp ? B[31] : A[31];
        
        diff_E          = A_E-B_E;
        MantisB         = (MantisB >> diff_E);
        {carry,MantisT} = (signA ~^ signB)? MantisA + MantisB : MantisA-MantisB ;
        exp_adjust      = A_E;
        if (carry)
        begin
            MantisT    = MantisT>>1;
            exp_adjust = exp_adjust+1'b1;
        end
        else
        begin
            while(!MantisT[23])
            begin
                MantisT    = MantisT<<1;
                exp_adjust = exp_adjust-1'b1;
            end
        end
        Sign      = signA;
        Mantissa  = MantisT[22:0];
        E         = exp_adjust;
        result    = {Sign E, Mantissa};
        MantisT   = (signA ~^ signB) ? (carry ? MantisT>>1 : MantisT) : (0);
        Temp_E    = carry ? A_E + 1'b1 : A_E;
        Temp_sign = signA;
        result    = {Temp_sign, Temp_E, MantisT[22:0]};
        result    = (A == 32'b0 | B == 32'b0) ? 32'b0 : result;
    end
endmodule
