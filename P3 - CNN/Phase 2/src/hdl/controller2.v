module controller2(
    clk, done, cout6_2, cout14, cout5_2, cout7_2, cout3_2, en1_2, 
    en9_2, sel_2, en2_2, en6_2, en14, en4_2, en5_2, en12_2, en13, en10_2, en8_2, en7_2, wr2,
    rst9_2, rst6_2, rst13, rst14, rst7_2, rst12_2, rst8_2, rst5_2, done_2
) ;

    input clk;
    input done, cout6_2, cout14, cout5_2, cout7_2, cout3_2;
    output reg [15:0] en1_2 [0:3];
    output reg en9_2, sel_2, en2_2, en6_2, en14, en5_2, en12_2, en13, en10_2, en8_2, en7_2, wr2;
    output reg [15:0] en4_2;
    output reg rst9_2, rst6_2, rst13, rst14, rst7_2, rst12_2, rst8_2, rst5_2;
    output reg done_2;

    parameter [3:0] 
    Q0 = 0, Q1 = 1, Q2 = 2, Q3 = 3, Q4 = 4, 
    Q5 = 5, Q6 = 6, Q7 = 7, Q8 = 8, Q9 = 9, Q10 = 10, Q11 = 11;

    reg [3:0] ps = 4'b0, ns;

    wire [31:0] kernel;
    reg enK, rstK;
    wire coutK;

    kernelCounter #4 myCounter(.clk(clk), .rst(rstK), .en(enK), .count(kernel), .cout(coutK));

    integer i;
    always @(ps, done, cout6_2, cout14, cout5_2, cout7_2) begin
        for (i = 0; i < 4; i = i + 1) begin
            en1_2[i] = 16'b0;
        end
        {enK, rstK, en9_2, sel_2, en2_2, en6_2, en14, 
        en4_2, en5_2, en12_2, en13, en10_2, en8_2, en7_2, 
        wr2, rst9_2, rst6_2, rst13, rst14, 
        rst7_2, rst12_2, rst8_2, rst5_2, done_2} = 0;
        case (ps)
            Q0: begin
                rst9_2 = 1'b1;  rst6_2 = 1'b1; rst13  = 1'b1; rst14 = 1'b1; rst7_2 = 1'b1;
                rst12_2 = 1'b1; rst8_2 = 1'b1; rst5_2 = 1'b1; rstK  = 1'b1;
            end
            Q1: begin rst9_2 = 1'b0; en1_2[kernel][15:12] = 4'b1111; sel_2 = 1'b1; en9_2 = 1'b1; end
            Q2: begin en1_2[kernel][11:8] = 4'b1111; sel_2 = 1'b1; en9_2 = 1'b1; end
            Q3: begin en1_2[kernel][7:4] = 4'b1111; sel_2 = 1'b1; en9_2 = 1'b1; end
            Q4: begin en1_2[kernel][3:0] = 4'b1111; sel_2 = 1'b1; en9_2 = 1'b1; enK = 1'b1; end
            Q5: begin en2_2 = 1'b1; en6_2 = 1'b1; end
            Q6: begin en14 = 1'b1; en4_2 = 16'b1111111111111111; end
            Q7: begin en12_2 = 1'b1; en5_2 = 1'b1; end
            Q8: en13 = 1'b1;
            Q9: begin en10_2 = 1'b1; en8_2 = 1'b1; rst12_2 = 1'b1; end
            Q10: begin wr2 = 1'b1; en7_2 = 1'b1; end
            Q11: done_2 = 1'b1;
        endcase
    end

    always @(ps, done, cout6_2, cout14, cout5_2, cout7_2) begin
        case (ps)
            Q0: ns = done ? Q1 : Q0;
            Q1: ns = Q2;
            Q2: ns = Q3;
            Q3: ns = Q4;
            Q4: ns = coutK ? Q5 : Q1;
            Q5: ns = cout6_2 ? Q6 : Q5;
            Q6: ns = cout14 ? Q8 : Q7;
            Q7: ns = cout5_2 ? Q9 : Q7;
            Q8: ns = Q7;
            Q9: ns = cout3_2 ? Q10 : Q6;
            Q10: ns = cout7_2 ? Q11 : Q6;
            Q11: ns = Q0;
        endcase
    end

    always @(posedge clk) begin
        ps <= ns;
    end
    
endmodule
