module Mux2bit (input [31:0] a,
                b,
                input sel,
                output reg [31:0] out);

always @(*) begin
    if (sel)
        out = b;
    else
        out = a;
end

endmodule
