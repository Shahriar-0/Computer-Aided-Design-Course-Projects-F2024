module DataMemory (input clk,
                   rst,
                   input [1:0] address,
                   output [3:0] readData [31:0]);
    
    reg [3:0] DM [31:0];
    
    initial begin
        $readmemh("DataMemory.txt", DM);
    end
    
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            $readmemh("DataMemory.txt", DM);
        end
    end
    
    assign readData[0] = DM[2'b00];
    assign readData[1] = DM[2'b01];
    assign readData[2] = DM[2'b10];
    assign readData[3] = DM[2'b11];

endmodule
