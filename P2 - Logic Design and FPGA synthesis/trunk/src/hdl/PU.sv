module ProcessUnit (
    input clk, ld_mult, ld_sum,
    input [4:0] x[3:0],
    input [4:0] w[3:0],

    output s,
    output [4:0] out
);

    wire smult_0, smult_1, smult_2, smult_3;
    wire [9:0] mult_0, mult_1, mult_2, mult_3,
               mult_0_in, mult_1_in, mult_2_in, mult_3_in, 
               mult_0_out, mult_1_out, mult_2_out, mult_3_out;

    wire [4:0] x_abs[3:0];
    wire [4:0] w_abs[3:0];
    wire [11:0] mres_1, mres_2, mres_out;
    wire [12:0] mres_in;

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin
            ABS #(5) absoluteX(x[i], x[i][4], x_abs[i]);
            ABS #(5) absoluteW(w[i], w[i][4], w_abs[i]);
        end
    endgenerate

    XOR2 xor_0(x[0][4], w[0][4], smult_0);
    XOR2 xor_1(x[1][4], w[1][4], smult_1);
    XOR2 xor_2(x[2][4], w[2][4], smult_2);
    XOR2 xor_3(x[3][4], w[3][4], smult_3);

    Multiplier mul_0(x_abs[0], w_abs[0], mult_0);
    Multiplier mul_1(x_abs[1], w_abs[1], mult_1);
    Multiplier mul_2(x_abs[2], w_abs[2], mult_2);
    Multiplier mul_3(x_abs[3], w_abs[3], mult_3);

    ABS #(10) abs_0(mult_0, smult_0, mult_0_in);
    ABS #(10) abs_1(mult_1, smult_1, mult_1_in);
    ABS #(10) abs_2(mult_2, smult_2, mult_2_in);
    ABS #(10) abs_3(mult_3, smult_3, mult_3_in);

    REG #(10) mult_4(clk, 1'b0, ld_mult, mult_0_in, mult_0_out);
    REG #(10) mult_5(clk, 1'b0, ld_mult, mult_1_in, mult_1_out);
    REG #(10) mult_6(clk, 1'b0, ld_mult, mult_2_in, mult_2_out);
    REG #(10) mult_7(clk, 1'b0, ld_mult, mult_3_in, mult_3_out);
    REG #(12) mreg(clk, 1'b0, ld_sum, mres_in[11:0], mres_out);

    MUX2 mux_out(
        {mres_out[11], mres_out[6], mres_out[5:3]}, 
        5'b0, mres_out[11], out
    );

    OR6 or_0(out[0], out[1], out[2], out[3], out[4], 0, s);

    Adder #(11) add_0(
        {mult_0_out[9], mult_0_out}, {mult_1_out[9], 
        mult_1_out}, 1'b0, mres_1
    );
    
    Adder #(11) add_1(
        {mult_2_out[9], mult_2_out}, {mult_3_out[9], 
        mult_3_out}, 1'b0, mres_2
    );
    
    Adder #(12) add_2(
        {mres_1[10], mres_1[10:0]}, {mres_2[10], 
        mres_2[10:0]}, 1'b0, mres_in
    );

endmodule