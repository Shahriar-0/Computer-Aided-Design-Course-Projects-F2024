module InstructionMem (input [31:0] address,
                       output [31:0] instruction);
reg [31:0] inst_mem [31:0];
integer i;

initial begin
    $readmemh("Instructions.txt", inst_mem);
end

assign instruction = inst_mem[address];

endmodule
