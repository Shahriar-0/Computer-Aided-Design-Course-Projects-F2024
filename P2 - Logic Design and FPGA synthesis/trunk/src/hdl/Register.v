module Register #(parameter XLEN = 32)
                 (input clk,
                 input rst,
                 input ld,
                 input [XLEN - 1:0] in,
                 output reg [XLEN - 1:0] out);
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out <= 0;
        end
        else if (ld) begin
            out <= in;
        end
    end
            
endmodule
