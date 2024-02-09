module ShiftRegister(clk, rst, clr, ld, shR, shL, serIn, din, dout);
    parameter N = 32;

    input clk, rst, clr, ld, shR, shL, serIn;
    input [N-1:0] din;
    output [N-1:0] dout;

    reg [N-1:0] dout;

    always @(posedge clk or posedge rst) begin
        if (rst || clr)
            dout <= {N{1'b0}};
        else if (ld)
            dout <= din;
        else if (shR)
            dout <= {serIn, dout[N-1:1]};
        else if (shL)
            dout <= {dout[N-2:0], serIn};
    end
endmodule
