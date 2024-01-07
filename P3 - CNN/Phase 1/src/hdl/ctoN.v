module ctoN #(parameter N ) (
    input clk,
    input rst,
    input en,
    output reg co,
    output reg [N-1:0] num
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            num <= 0;
            co <= 0;
        end else if (en) begin
            if (num == (N-1)) begin
                num <= 0;
                co <= 1'b1;
            end else begin
                num <= num + 1;
                co <= 0;
            end
        end
    end
endmodule