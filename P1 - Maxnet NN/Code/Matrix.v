module matrix (input [1:0] row,
               column,
               output reg [31:0] Out);

    assign Out = (row == column)? 32'b00111110010011001100110011001101 : 32'b0;
    
endmodule
