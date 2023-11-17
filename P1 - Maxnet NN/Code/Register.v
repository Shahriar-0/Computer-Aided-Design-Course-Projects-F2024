module Register (
    input clk,
    input rst,
    input load_enable,
    input [31:0] data_in,
    output reg [31:0] data_out
);
    initial data_out = 32'b0;
    
    always @(posedge clk, posedge rst) begin
        if (rst)
            data_out <= 0;
        else if (load_enable)
            data_out <= data_in;
    end
    
endmodule
