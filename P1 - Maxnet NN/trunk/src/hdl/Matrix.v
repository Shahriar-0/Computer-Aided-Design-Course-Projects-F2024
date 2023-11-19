module Matrix(output [31:0] W0,
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

reg [31:0] matrix [0:15];

initial begin
    for (i = 0; i <= 3; i = i + 1) begin
        for (j = 0; j <= 3; j = j + 1) begin
            if (i == j) begin
                // 1.0 in IEEE 754 format
                matrix[i * 4 + j] = 32'b00111111100000000000000000000000;
            end
            else begin
                // -0.2 in IEEE 754 format
                matrix[i * 4 + j] = 32'b10111110010011001100110011001101;
            end
        end
    end
end

assign {W0,  W1,  W2,  W3}  = {matrix[0],  matrix[1],  matrix[2],  matrix[3]};
assign {W4,  W5,  W6,  W7}  = {matrix[4],  matrix[5],  matrix[6],  matrix[7]};
assign {W8,  W9,  W10, W11} = {matrix[8],  matrix[9],  matrix[10], matrix[11]};
assign {W12, W13, W14, W15} = {matrix[12], matrix[13], matrix[14], matrix[15]};

endmodule
