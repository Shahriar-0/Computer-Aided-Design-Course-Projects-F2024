module TopModule(input clk,
                 rst,
                 start,
                 output done,
                 output [31:0] maxnumber);
    wire ldX, ldTmp, selTmp, doneInternal;
    DP dp(.clk(clk), .rst(rst), .maxnumber(maxnumber), .done(doneInternal), .ldX(ldX), .ldTmp(ldTmp), .selTmp(selTmp));
    CU cu(.clk(clk), .rst(rst), .start(start), .done(doneInternal), .ldX(ldX), .ldTmp(ldTmp), .selTmp(selTmp));
    assign done = doneInternal;
endmodule
