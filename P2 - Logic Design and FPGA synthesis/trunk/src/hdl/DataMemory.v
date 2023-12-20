module DataMemory #(parameter XLEN = 5) (
    input clk, rst,
    
    output [XLEN - 1:0] readData1, readData2, readData3, readData4
);

    reg [XLEN - 1:0] DM [3:0];
    
    initial begin
        $readmemh("./file/DataMemory.dat", DM);
    end
    
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            $readmemh("./file/DataMemory.dat", DM);
        end
    end
    
    assign readData1 = DM[2'b00];
    assign readData2 = DM[2'b01];
    assign readData3 = DM[2'b10];
    assign readData4 = DM[2'b11];
    
endmodule
