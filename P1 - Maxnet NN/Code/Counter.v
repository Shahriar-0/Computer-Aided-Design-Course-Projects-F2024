module Counter2bit(input rst,
                   clk,
                   init,
                   ld,
                   en,
                   input [1:0] prl,
                   output reg [1:0] out,
                   output Co);
    
    always @(posedge clk or posedge rst) begin
        if (rst || init)
            out <= 2'b0;
        else if (ld)
            out <= prl;
        else if (en)
            out <= out + 1;
        
        assign Co = &out;
    end
    
endmodule
