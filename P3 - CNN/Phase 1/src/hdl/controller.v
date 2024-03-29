module controller #(parameter N) (clk, start, num,
                   cout3, cout5, cout6, cout7, cout8, cout9, cout11, coutN, 
                   en1, en2, en3, en4, en5, en6, en7, en8, en9, en10, en11, en12, rst3,
		           rst5, rst6, rst7, rst8, rst9, rst11, rst12, rstN, 
                   sel, shift, wr, done);

	input clk, start, cout3, cout5, cout6, cout7, cout8, cout9, cout11, coutN;
    input [N-1:0] num;
	output reg en3, en5, en6, en7, en8, en9, en10, en11, en12, 
               rst3, rst5, rst6, rst7, rst8, rst9, rst11, rst12, rstN, 
               shift, wr, done;
	output reg[1:0] sel;
	output reg[15:0] en2, en4;
    output reg [15:0] en1 [N - 1:0];

	parameter [4:0]
    Q0  = 5'b00000, Q1  = 5'b00001, Q2  = 5'b00010, Q3  = 5'b00011,
    Q4  = 5'b00100, Q5  = 5'b00101, Q6  = 5'b00110, Q7  = 5'b00111,
    Q8  = 5'b01000, Q9  = 5'b01001, Q10 = 5'b01010, Q11 = 5'b01011,
    Q12 = 5'b01100, Q13 = 5'b01101, Q14 = 5'b01110, Q15 = 5'b01111,
    Q16 = 5'b10000, Q17 = 5'b10001, Q18 = 5'b10010, Q19 = 5'b10011,
    Q20 = 5'b10100, Q21 = 5'b10101, Q22 = 5'b10110, Q23 = 5'b10111;
	
	reg[4:0] ps=5'b0, ns;
    integer i;
	always @(ps, start, cout3, cout5, cout7, cout8, cout11) begin
		{en2, en3, en4, en5, en6, en7, en8, en9, en10, en11, en12, 
         rst3, rst5, rst6, rst7, rst8, rst9, rst11, rst12, rstN, 
         sel, shift, wr, done} = 55'b0;
        for (i = 0; i < N; i = i + 1)  en1[i] = 16'b0; 
        
        case(ps)
            
            Q0 : begin
                rst3  = 1'b1; rst5  = 1'b1; rst6  = 1'b1; rst7  = 1'b1; rst8  = 1'b1; 
                rst9  = 1'b1; rst11 = 1'b1; rst12 = 1'b1; rstN  = 1'b1;
            end
            Q1 : begin rst9 = 1'b0; en1[num][15:12] = 4'b1111; sel = 2'b01; en9 = 1'b1; end
            Q2 : begin en1[num][11:8] = 4'b1111; sel = 2'b01; en9 = 1'b1; end
            Q3 : begin en1[num][7:4] = 4'b1111; sel = 2'b01; en9 = 1'b1; end
            Q4 : begin en1[num][3:0] = 4'b1111; sel = 2'b01; en9 = 1'b1; end
            Q5 : begin en2[15:12] = 4'b1111; sel = 2'b00; en6 = 1'b1; end
            Q6 : begin en2[11:8] = 4'b1111; sel = 2'b00; en6 = 1'b1; end
            Q7 : begin en2[7:4] = 4'b1111; sel = 2'b00; en6 = 1'b1; end
            Q8 : begin en2[3:0] = 4'b1111; sel = 2'b00; en6 = 1'b1; en11 = 1'b1; end
            Q9 : shift = 1'b1;
            Q10: begin en3 = 1'b1; en4 = 16'hFFFF; end
            Q11: begin en5 = 1'b1; en12 = 1'b1; end
            Q12: begin en8 = 1'b1; en10 = 1'b1; rst5 = 1'b1; rst12 = 1'b1; end
            Q13: begin wr = 1'b1; en7 = 1'b1; sel = 2'b10; rst8 = 1'b1; end
            Q14: begin shift = 1'b1; rst3  = 1'b1; end
            Q15: begin en2[15:12] = 4'b1111; sel = 2'b00; en6 = 1'b1; end
            Q16: begin en2[11:8] = 4'b1111; sel = 2'b00; en6 = 1'b1; end
            Q17: begin en2[7:4] = 4'b1111; sel = 2'b00; en6 = 1'b1; end
            Q18:begin en2[3:0] = 4'b1111; sel = 2'b00; en6 = 1'b1; end
            Q19: en10 = 1'b1;
            Q20: en10 = 1'b1;
            Q21: en10 = 1'b1;
            Q22: begin wr = 1'b1; sel = 2'b11; end
            Q23: done = 1'b1;
        endcase
    end

    always @(ps, start, cout3, cout5, cout7, cout8, cout11) begin
        ns = ps; 
        case (ps)
            Q0 : ns = start ? Q1 : Q0;                              
            Q1 : ns = Q2;                                           
            Q2 : ns = Q3;                                           
            Q3 : ns = Q4;                                           
            Q4 : ns = coutN ? Q5 : Q1;
            Q5 : ns = Q6;                                           
            Q6 : ns = Q7;                                           
            Q7 : ns = Q8;                                           
            Q8 : ns = cout11 ? Q10 : Q9;                            
            Q9 : ns = Q5;                                           
            Q10: ns = Q11;                                          
            Q11: ns = cout5 ? Q12 : Q11;
            Q12: ns = (cout3 == 1'b0) && (cout8 == 1'b0) ? Q10 : (cout3 == 1'b1) && (cout8 == 1'b0) ? Q14 : Q13;
            Q13: ns = cout3 ? Q14 : Q10;                            
            Q14: ns = cout7 ? Q19 : Q15;                            
            Q15: ns = Q16;                                          
            Q16: ns = Q17;                                          
            Q17: ns = Q18;                                          
            Q18: ns = Q10;                                          
            Q19: ns = Q20;                                          
            Q20: ns = Q21;                                          
            Q21: ns = Q22;                                          
            Q22: ns = Q23;                                          
            Q23: ns = Q0;                                           
            default: ns = Q0;                                       
        endcase
    end

	always @(posedge clk) ps <= ns;
    
endmodule
