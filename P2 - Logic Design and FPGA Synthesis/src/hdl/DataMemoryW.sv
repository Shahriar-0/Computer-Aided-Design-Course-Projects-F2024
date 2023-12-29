module DataMemoryW (
    input clk, read,
    
    output [4:0] w0 [3:0],
    output [4:0] w1 [3:0],
    output [4:0] w2 [3:0],
    output [4:0] w3 [3:0]
);

    reg [4:0] w [0:3][3:0];
    assign w0 = w[0];
    assign w1 = w[1];
    assign w2 = w[2];
    assign w3 = w[3];

    always @(clk) begin
        if(read)
            $readmemb("files/weight.txt", w);
    end
    
endmodule