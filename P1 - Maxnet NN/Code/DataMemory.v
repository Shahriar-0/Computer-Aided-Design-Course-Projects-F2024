module DataMemory (input clk,
                   rst,
                   output [31:0] readData1
                   readData2
                   readData3
                   readData4);
    
    reg [3:0] DM [31:0];
    
    initial begin
        $readmemh("DataMemory.txt", DM);
    end
    
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            $readmemh("DataMemory.txt", DM);
        end
    end
    
    assign readData1 = DM[2'b00];
    assign readData2 = DM[2'b01];
    assign readData3 = DM[2'b10];
    assign readData4 = DM[2'b11];

endmodule
