module topModule(input clk,
                 rst,
                 start,
                 output [31:0] maxnumber);
    wire ldX, ldTmp, selTmp, done;
    DP dp(.clk(clk), .rst(rst), .maxnumber(maxnumber), .done(done), .ldX(ldX), .ldTmp(ldTmp), .selTmp(selTmp));
    CU cu(.clk(clk), .rst(rst), .start(start), .done(done), .ldX(ldX), .ldTmp(ldTmp), .selTmp(selTmp));
endmodule
