module __ACT_S2 #(parameter XLEN) ( // this module is based on the __ACT_C1 module
    input clk, rst,
    input [XLEN - 1 : 0] D00, D01, D10, D11,
    input A1, B1, A0, B0,

    output reg [XLEN - 1 : 0] out
);

    wire S0, S1;
    assign S0 = (A0 & B0);
    assign S1 = (A1 | B1);

    wire [XLEN - 1 : 0] D;
    assign D = (S1 == 0 && S0 == 0) ? D00 :
               (S1 == 0 && S0 == 1) ? D01 :
               (S1 == 1 && S0 == 0) ? D10 :
               (S1 == 1 && S0 == 1) ? D11 : 'bz;

    always @(posedge clk or posedge rst) begin
        if (rst) 
            out = 0;
        else 
            out = D;
    end

endmodule
