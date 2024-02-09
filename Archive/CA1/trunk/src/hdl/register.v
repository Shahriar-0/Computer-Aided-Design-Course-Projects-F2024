module Register (clk, rst, clr, ld, din, dout);
    parameter N = 25;

    input clk, rst, clr, ld;
    input [N-1:0] din;
    output [N-1:0] dout;

    reg [N-1:0] dout;

    always @(posedge clk or posedge rst) begin
        if (rst || clr)
            dout <= 0;
        else if (ld)
            dout <= din;
    end
endmodule
