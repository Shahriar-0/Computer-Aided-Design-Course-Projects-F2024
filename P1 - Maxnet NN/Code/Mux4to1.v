module mux4to1 (
    input [31:0] a,
    b,
    c,
    d,
    input [3:0] mux_sel,
    input flag,
    output reg [31:0] y
);
    always @(*) begin
        if (flag) begin
            case (mux_sel)
                4'b0001: y = a;
                4'b0010: y = b;
                4'b0100:  y = c;
                4'b1000:  y = d;
                default: y = 32'b x;
            endcase
        end
        else
            y = 32'b x;
    end
endmodule
