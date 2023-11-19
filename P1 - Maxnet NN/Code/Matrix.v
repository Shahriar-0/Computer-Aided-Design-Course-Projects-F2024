module Matrix (output reg [31:0] W0,
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

reg [31:0] buffer [0:15];

initial begin
    for (i = 0; i < = 3; i = i + 1) begin
        for (j = 0; j < = 3; j = j + 1) begin
            if (i == j) begin
                // 1.0 in IEEE 754 format
                buffer[i*4+j] = 32'b00111111100000000000000000000000;
            end
            else begin
                // -0.2 in IEEE 754 format
                buffer[i*4+j] = 32'b10111110010011001100110011001101;
            end
        end
    end
end

assign {W0,  W1,  W2,  W3}  = {buffer[0],  buffer[1],  buffer[2],  buffer[3]};
assign {W4,  W5,  W6,  W7}  = {buffer[4],  buffer[5],  buffer[6],  buffer[7]};
assign {W8,  W9,  W10, W11} = {buffer[8],  buffer[9],  buffer[10], buffer[11]};
assign {W12, W13, W14, W15} = {buffer[12], buffer[13], buffer[14], buffer[15]};

endmodule
