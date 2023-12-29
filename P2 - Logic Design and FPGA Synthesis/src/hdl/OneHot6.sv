module OneHot6 (
    input  [2:0] i_0, i_1, i_2, i_3, i_4, i_5,
    input  [5:0] sel,

    output [2:0] out
);

    wire [2:0] m_0, m_1, m_2, m_3, m_4, m_5;

    // alternative to using a generate block
    MUX2 #(3) mux_0(.A(3'b0), .B(i_0), .slc(sel[0]), .out(m_0));
    MUX2 #(3) mux_1(.A(3'b0), .B(i_1), .slc(sel[1]), .out(m_1));
    MUX2 #(3) mux_2(.A(3'b0), .B(i_2), .slc(sel[2]), .out(m_2));
    MUX2 #(3) mux_3(.A(3'b0), .B(i_3), .slc(sel[3]), .out(m_3));
    MUX2 #(3) mux_4(.A(3'b0), .B(i_4), .slc(sel[4]), .out(m_4));
    MUX2 #(3) mux_5(.A(3'b0), .B(i_5), .slc(sel[5]), .out(m_5));

    genvar i;
    generate
        for (i = 0; i < 3; i = i + 1) begin
           OR6 or_0(m_0[i], m_1[i], m_2[i], m_3[i], m_4[i], m_5[i], out[i]);
        end
    endgenerate

endmodule
