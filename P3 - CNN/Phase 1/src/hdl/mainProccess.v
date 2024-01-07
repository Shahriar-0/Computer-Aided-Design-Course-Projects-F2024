module mainProccess(clk, start, X, Y, Z, done);
    parameter N = 4; 

    input clk;    
    input start;  
    input [7:0] X, Y, Z; 
    output done; 

    wire rst3, rst5, rst6, rst7, rst8, rst9, rst11, rst12,rstN;
    wire en3, en5, en6, en7, en8, en9, en10, en11, en12;
    wire cout3, cout5, cout6, cout7, cout8, cout9, cout11, countN;
    wire wr, shift;
    wire [1:0] sel;
    wire [15:0] en2, en4;
	wire [15:0]en1[N-1:0];
    wire [(N-1):0] num;

    controller #(.N(N))  myController(
        .clk(clk),     .start(start), .sel(sel),       .shift(shift), .wr(wr),
        .rst3(rst3),   .rst5(rst5),   .rst6(rst6),     .rst7(rst7),
        .rst8(rst8),   .rst9(rst9),   .rst11(rst11),   .rst12(rst12), .rstN(rstN),
        .en1(en1),     .en2(en2),     .en3(en3),       .en4(en4),
        .en5(en5),     .en6(en6),     .en7(en7),       .en8(en8),
        .en9(en9),     .en10(en10),   .en11(en11),     .en12(en12),
        .cout3(cout3), .cout5(cout5), .cout6(cout6),   .cout7(cout7),
        .cout8(cout8), .cout9(cout9), .cout11(cout11), .coutN(countN),
        .num(num),     .done(done)
    );

    dataPath #(.N(N))  myDataPath(
        .clk(clk),     .sel(sel),      .wr(wr),         .shift(shift),
        .rst6(rst6),   .rst7(rst7),    .rst9(rst9),     .rst11(rst11),
        .rst3(rst3),   .rst5(rst5),    .rst8(rst8),     .rst12(rst12), .rstN(rstN),
        .en1(en1),     .en2(en2),      .en3(en3),       .en4(en4),
        .en5(en5),     .en6(en6),      .en7(en7),       .en8(en8),
        .en9(en9),     .en10(en10),    .en11(en11),     .en12(en12),
        .cout3(cout3), .cout5(cout5),  .cout6(cout6),   .cout7(cout7),
        .cout8(cout8), .cout9(cout9),  .cout11(cout11), .coutN(countN),
        .num(num),     .X(X),          .Y(Y),           .Z(Z)  
    );

endmodule 