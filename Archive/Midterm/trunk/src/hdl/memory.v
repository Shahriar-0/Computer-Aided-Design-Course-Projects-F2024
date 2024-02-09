module Memory (clk, rst, clr, read, write, adr, din, dout);
    parameter N = 32;
    parameter Size = 64;
    localparam Bits = $clog2(Size);

    input clk, rst, clr, read, write;
    input [Bits-1:0] adr;
    input [N-1:0] din;
    output [N-1:0] dout;

    reg [N-1:0] dout;
    reg [N-1:0] mem [0:Size];

    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst)
            for (i = 0; i < Size; i = i + 1)
                mem[i] <= {N{1'b0}};
        else if (clr)
            mem[i] <= {N{1'b0}};
        else if (write)
            mem[adr] <= din;
    end

    always @(read or adr) begin
        if (read)
            dout = mem[adr];
    end
endmodule
