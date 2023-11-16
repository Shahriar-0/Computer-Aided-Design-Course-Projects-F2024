module RegisterFile (
    input clock, writeEn, reset,    
    input[4:0] address_rd1, address_rd2, address_wr,
    input [31:0] write_data,
    output [31:0] read_data1, read_data2
);

reg [31:0] regfile [31:0];
integer i;
initial begin
    for(i = 0; i < 32; i = i + 1)
        regfile[i] = 32'b0;
end

assign read_data1 = regfile[address_rd1];
assign read_data2 = regfile[address_rd2];

always @(posedge clock, posedge reset) begin
    if(reset) begin
        for(i = 0; i < 32; i = i + 1)
            regfile[i] = 32'b0;
    end
    else if(writeEn)
        regfile[address_wr] = write_data;
end
    
endmodule