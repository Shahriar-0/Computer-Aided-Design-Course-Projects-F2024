module DataMemoryX (
    input clk, read, 
    output reg [4:0] out [3:0]
);

    reg [4:0] to_save [3:0];

    always @(posedge clk) begin
        if(read)
            $readmemb("files/input.txt", to_save);
    end

    assign out = to_save;
endmodule