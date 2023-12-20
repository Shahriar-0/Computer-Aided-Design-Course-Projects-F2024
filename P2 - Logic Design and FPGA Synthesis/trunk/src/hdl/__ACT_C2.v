module __ACT_C2 #(parameter XLEN) ( // this module is based on the __ACT_C1 module
    input [XLEN - 1 : 0] D00, D01, D10, D11,
    input A1, B1, A0, B0,
    
    output [XLEN - 1 : 0] out
);
    wire S0, S1;
    assign S0 = (A0 & B0);
    assign S1 = (A1 | B1);

    assign out = (S1 == 0 && S0 == 0) ? D00 :
                 (S1 == 0 && S0 == 1) ? D01 :
                 (S1 == 1 && S0 == 0) ? D10 :
                 (S1 == 1 && S0 == 1) ? D11 : 'bz;
endmodule
