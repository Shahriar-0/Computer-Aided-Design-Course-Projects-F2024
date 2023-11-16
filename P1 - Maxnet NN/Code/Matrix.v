module Matrix (input [1:0] row,
               column,
               output reg [31:0] Out);

    assign Out = (row == column)? 32'b1_01111100_10011001100110011001101 : 32'b0;

endmodule
