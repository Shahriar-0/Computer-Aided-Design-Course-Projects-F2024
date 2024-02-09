module BitChanger (clk, rst, clr, ld, en, bitChange, bitSelect, din, dout);
    parameter N = 25;
    localparam Bits = $clog2(N);

    input clk, rst, clr, ld, en, bitChange;
    input [Bits-1:0] bitSelect;
    input [N-1:0] din;
    output [N-1:0] dout;

    reg [N-1:0] dout;

    always @(posedge clk or posedge rst) begin
        if (rst || clr)
            dout <= 0;
        else if (ld)
            dout <= din;
        else if (en)
            dout[bitSelect] <= bitChange;
    end
endmodule
