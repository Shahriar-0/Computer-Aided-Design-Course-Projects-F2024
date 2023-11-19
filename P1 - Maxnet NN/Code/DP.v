module DP(input clk,
          rst,
          ldX,
          ldTmp,
          selTmp,
          output done,
          output [31:0] maxnumber);
    
    
    
    
    //in contorroler increment addres by one and then put it in the register by l1
    DataMemory Dm(.clk(clk), .rst(rst), .address(address), .read_data(dmout));
    
    //first time it gonna be zero in controller after that 0 all the time
    mux2bit M1(.a(dmout), .b(AOut),  .sel(Selectm), .y(M1Out));
    mux2bit M2(.a(dmout), .b(A2Out), .sel(Selectm), .y(M2Out));
    mux2bit M3(.a(dmout), .b(A3Out), .sel(Selectm), .y(M3Out));
    mux2bit M4(.a(dmout), .b(A4Out), .sel(Selectm), .y(M4Out));
    
    Register R1(.clk(clk), .rst(rst), .load_enable(ld1), .data_in(M1Out),  .data_out(R1Out));
    Register R2(.clk(clk), .rst(rst), .data_in(M2Out),   .data_out(R2Out), .load_enable(ld2));
    Register R3(.clk(clk), .rst(rst), .data_in(M3Out),   .data_out(R3Out), .load_enable(ld3));
    Register R4(.clk(clk), .rst(rst), .data_in(M4Out),   .data_out(R4Out), .load_enable(ld4));
    
    ProcessingUnit p1(
    .clk(clk), .result(PUOut), .l1(lp1), .l2(lp2), .l3(lp3),
    .num1(R1Out), .num2(R2Out), .num3(R3Out), .num4(R4Out),
    .weight1(w[0][0]), .weight2(w[0][1]), .weight3(w[0][2]), .weight4(w[0][3])
    );
    
    ProcessingUnit p2(
    .clk(clk), .result(PU2Out), .l1(lp1), .l2(lp2), .l3(lp3),
    .num1(R1Out), .num2(R2Out), .num3(R3Out), .num4(R4Out),
    .weight1(w[1][0]), .weight2(w[1][1]), .weight3(w[1][2]), .weight4(w[1][3])
    );
    
    ProcessingUnit p3(
    .clk(clk), .result(PU3Out), .l1(lp1), .l2(lp2), .l3(lp3),
    .num1(R1Out), .num2(R2Out), .num3(R3Out), .num4(R4Out),
    .weight1(w[2][0]), .weight2(w[2][1]), .weight3(w[2][2]), .weight4(w[2][3])
    );
    
    ProcessingUnit p4(
    .clk(clk), .result(PU4Out), .l1(lp1), .l2(lp2), .l3(lp3),
    .num1(R1Out), .num2(R2Out), .num3(R3Out), .num4(R4Out),
    .weight1(w[3][0]), .weight2(w[3][1]), .weight3(w[3][2]), .weight4(w[3][3])
    );
    
    ReLU rel1(.B(PUOut),  .y(AOut));
    ReLU rel2(.B(PU2Out), .y(A2Out));
    ReLU rel3(.B(PU3Out), .y(A3Out));
    ReLU rel4(.B(PU4Out), .y(A4Out));
    
    check_negatives state_determiner(
    .in1(AOut), .in2(A2Out), .in3(A3Out), .in4(A4Out),
    .non_negatives(mux_sel), .three_negatives(end_case)
    );
    
    Register RO1(.clk(clk), .rst(rst), .load_enable(ldm1), .data_in(end1), .data_out(end1));
    Register RO2(.clk(clk), .rst(rst), .data_in(dmout),    .data_out(end2), .load_enable(ldm2));
    Register RO3(.clk(clk), .rst(rst), .data_in(dmout),    .data_out(end3), .load_enable(ldm3));
    Register RO4(.clk(clk), .rst(rst), .data_in(dmout),    .data_out(end4), .load_enable(ldm4));
    
    
    mux4to1 end_max(.a(end1), .b(end2), .c(end3), .d(end4), .mux_sel(mux_sel), .flag(end_case), .y(maxnumber));
    
    );
endmodule
