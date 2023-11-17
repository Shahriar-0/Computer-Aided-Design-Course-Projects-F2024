module Matrix (input [1:0] row,
               column,
               output reg [31:0] Out);
    reg [31:0] matrix [0:3][0:3];
    integer i;
    integer j;
    
    initial begin
        for (i = 0; i < 4; i = i + 1) begin
            for(j = 0; j < 4; j = j + 1)begin
                if (i == j)begin
                    matrix[i][j] = 32'b00111110010011001100110011001101;
                end
                else begin
                    matrix[i][j] = 32'b0;
                end
            end
        end
    end
    assign Out = matrix[row][column];
endmodule
