module TopModule #(parameter XLEN = 32) (
    input clk, rst, start,

    output done,
    output [XLEN - 1:0] maxnumber
);
    
    wire ldX, ldTmp, selTmp, doneInternal;
    
    DP dp(
    .clk(clk), .rst(rst), .done(doneInternal),
    .ldX(ldX), .ldTmp(ldTmp), .selTmp(selTmp),
    .maxnumber(maxnumber)
    );
    
    CU cu(
    .clk(clk), .rst(rst), .start(start), .done(doneInternal),
    .ldX(ldX), .ldTmp(ldTmp), .selTmp(selTmp)
    );
    
    assign done = doneInternal;
    
endmodule
