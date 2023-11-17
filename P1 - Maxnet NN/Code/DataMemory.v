module DataMemory (input clk,rst,
                   input [1:0] address,
                   output [31:0] read_data);
    
    reg [3:0] data_mem [31:0];
    
    initial begin
        $readmemh("DataMemory.txt", data_mem);
    end
    
    assign read_data = data_mem[address];
    
    always @(posedge clk, posedge rst) begin
        if (rst)
            $readmemh("DataMemory.txt", data_mem);
    end
    
    
    always @(posedge clk) begin
        if (writeEn)
            $writememh("DataMemory.txt", data_mem);
            end
        
        endmodule
