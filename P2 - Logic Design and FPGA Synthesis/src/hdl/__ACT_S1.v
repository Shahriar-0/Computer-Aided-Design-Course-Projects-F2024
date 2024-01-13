module Actel_S1(
    input rst, clk, 
          D00, D01, D10, D11, A1, B1, A0, 

    output reg out
);

    wire[0:0] S0 = A0 & rst;
    wire[0:0] S1 = A1 | B1;
    wire[1:0] sel = {S1, S0};

    always @(posedge clk or posedge rst) begin
        if (rst)  
            out <= 1'b0;
        else begin
            case(sel)
                2'b00 : out <= D00;
                2'b01 : out <= D01;
                2'B10 : out <= D10;
                2'B11 : out <= D11;
            endcase
        end
    end

endmodule
