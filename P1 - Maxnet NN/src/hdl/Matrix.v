module Matrix #(parameter XLEN = 32)
               (output [XLEN - 1:0] W0,
                W1,
                W2,
                W3,
                W4,
                W5,
                W6,
                W7,
                W8,
                W9,
                W10,
                W11,
                W12,
                W13,
                W14,
                W15);

    integer i, j;
    
    reg [XLEN - 1:0] matrix [0:15];
    
    initial begin
        for (i = 0; i <= 3; i = i + 1) begin
            for (j = 0; j <= 3; j = j + 1) begin
                matrix[i * 4 + j] = (i == j)? 32'b00111111100000000000000000000000 : 32'b10111110010011001100110011001101; // 1:-.2
            end
        end
    end
    
    assign {W0, W1, W2, W3,
            W4, W5, W6, W7,
            W8, W9, W10, W11,
            W12, W13, W14, W15} = {matrix[0], matrix[1], matrix[2], matrix[3],
                                   matrix[4], matrix[5], matrix[6], matrix[7],
                                   matrix[8], matrix[9], matrix[10], matrix[11],
                                   matrix[12], matrix[13], matrix[14], matrix[15]};

endmodule
