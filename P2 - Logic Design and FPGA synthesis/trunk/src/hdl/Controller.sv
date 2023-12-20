`define ZERO  3'b000
`define ONE   3'b001
`define TWO   3'b010
`define THREE 3'b011
`define FOUR  3'b100
`define FIVE  3'b101

module Controller (
    input  clk, rst, s,

    output read, ld_y, slc_y, 
            mult, sum, done
);

    wire [2:0] ps;
    wire [2:0] ns;
    wire [5:0] one_h;
    wire [2:0] revert_mux_out;

    REG #(3) state(.clk(clk), .rst(rst), .ld(1), .in(ns), .out(ps));

    MUX2 #(3) mux_6(.A(`TWO), .B(`FIVE), .slc(s), .out(revert_mux_out));
    
    OneHot6 oneh(
        .i_0(`ONE),  .i_1(`TWO),           .i_2(`THREE), 
        .i_3(`FOUR), .i_4(revert_mux_out), .i_5(`FIVE), 
        .sel(one_h), .out(ns)
    );

    Comparator comp_0(ps, `ZERO,  one_h[0]);
    Comparator comp_1(ps, `ONE,   one_h[1]);
    Comparator comp_2(ps, `TWO,   one_h[2]);
    Comparator comp_3(ps, `THREE, one_h[3]);
    Comparator comp_4(ps, `FOUR,  one_h[4]);
    Comparator comp_5(ps, `FIVE,  one_h[5]);

    wire ld_y_sel_mux_sel;
    MUX2 #(1) mux_0(.A(0), .B(1), .slc(one_h[5]),         .out(done));
    MUX2 #(1) mux_1(.A(0), .B(1), .slc(one_h[4]),         .out(slc_y));
    MUX2 #(1) mux_2(.A(0), .B(1), .slc(one_h[3]),         .out(sum));
    MUX2 #(1) mux_3(.A(0), .B(1), .slc(one_h[2]),         .out(mult));
    MUX2 #(1) mux_4(.A(0), .B(1), .slc(one_h[0]),         .out(read));
    MUX2 #(1) mux_5(.A(0), .B(1), .slc(ld_y_sel_mux_sel), .out(ld_y));

    OR2 or_0(.A(one_h[1]), .B(one_h[4]), .out(ld_y_sel_mux_sel));

endmodule
