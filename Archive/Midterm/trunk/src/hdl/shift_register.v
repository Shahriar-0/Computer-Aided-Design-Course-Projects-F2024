module ShiftRegister(clk, rst, clr, ld, shf, serIn, din, dout);
    parameter N = 32;

    input clk, rst, clr, ld, shf, serIn;
    input [N-1:0] din;
    output [N-1:0] dout;

    reg [N-1:0] dout;

    always @(posedge clk or posedge rst) begin
        if (rst || clr)
            dout <= {N{1'b0}};
        else if (ld)
            dout <= din;
        else if (shf)
            dout <= {serIn, dout[N-1:1]};
    end
endmodule
