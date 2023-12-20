`define IDLE 3'd0
`define INIT 3'd1
`define MUL  3'd2
`define ADD  3'd3
`define LD   3'd4

module CU(
    input clk, rst, start, done,

    output reg ldTmp, selTmp, ldX
);

    wire top_left_mux_out;
    wire [1:0] middle_left_mux_out;
    wire [1:0]low_left_mux_out;
    wire [2:0]top_left_mux_out_extend,middle_left_mux_out_extend,low_left_mux_out_extend ;
    wire [2:0]ns,ps; 
    wire s1,s2;   

    MUX2Single top_left_mux(.A(1'b0),.B(1'b1),.select(start),.out(top_left_mux_out));
    ZeroExtend1to3 Z1(.in(top_left_mux_out),.out(top_left_mux_out_extend));


    MUX2 middle_left_mux(.A(2'b10),.B(2'b10),.select(start),.out(middle_left_mux_out));
    ZeroExtend2to3 Z2(.in(middle_left_mux_out),.out(middle_left_mux_out_extend));


    MUX2 low_left_mux(.A(2'b0),.B(2'b10),.select(done),.out(low_left_mux_out));
    ZeroExtend2to3 Z3(.in(low_left_mux_out),.out(low_left_mux_out_extend));

    MUX8REG mux8(
    .clock(clk),
    .reset(rst),
    .select(ps),
    .A(top_left_mux_out_extend),
    .B(middle_left_mux_out_extend),
    .C(3'b011),      /// ithink about it u thick too
    .D(3'b100),
    .E(low_left_mux_out_extend),
    .F(3'b0),
    .G(3'b0),
    .H(3'b0),
    .out(ns)
    );

    MUX8 lower_right_mux(
    .select(ps),
    .A(1'b0),
    .B(1'b1),
    .C(1'b0),
    .D(1'b0),
    .E(1'b1),
    .F(1'b0),
    .G(1'b0),
    .H(1'b0),
    .out(ldTmp));

    ThreeBitComparator TBC(.A(ps),.B(3'b011),.Equal(s1));
    MUX2Single mux_right_up (.A(1'b0),.B(1'b1),.select(s1),.out(selTmp));
    ThreeBitComparator TBC2(.A(ps),.B(3'b011),.Equal(s2));
    MUX2Single mux_right_middle (.A(1'b0),.B(1'b1),.select(s2),.out(ldX));


endmodule
