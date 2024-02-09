module CounterModN (clk, rst, clr, en, q, co);
    parameter N = 64;
    localparam Bits = $clog2(N);

    input clk, rst, clr, en;
    output [Bits-1:0] q;
    output co;

    reg [Bits-1:0] q;

    always @(posedge clk or posedge rst) begin
        if (rst || clr)
            q <= {Bits{1'b0}};
        else if (en) begin
            if (co)
                q <= {Bits{1'b0}};
            else
                q <= q + 1;
        end
    end

    assign co = (q == N - 1);
endmodule
