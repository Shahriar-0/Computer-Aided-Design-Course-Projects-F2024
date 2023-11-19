module Mux4to1(input [31:0] a,
               b,
               c,
               d,
               input [1:0] sel,
               output reg [31:0] out);

always @(*) begin
    case (sel)
        2'b00  : out = a;
        2'b01  : out = b;
        2'b10  : out = c;
        2'b11  : out = d;
        default: out = 32'bx;
    endcase
end
endmodule
