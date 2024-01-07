module countN #(parameter N) (clk, rst, en, cout, num);
    
    input clk, rst, en;
    output reg cout;
    output reg [N-1:0] num;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            num <= 0;
            cout <= 0;
        end else if (en) begin
            if (num == (N-1)) begin
                num <= 0;
                cout <= 1'b1;
            end else begin
                num <= num + 1;
                cout <= 0;
            end
        end
    end
endmodule