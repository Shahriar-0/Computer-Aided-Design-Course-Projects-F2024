module Mapper (in, out);
    parameter N = 5;
    localparam InputLenBitCount = $clog2(N*N);
    localparam HalfN = N[0] ? ((N / 2) + 1) : N / 2;

    input [(N*N)-1:0] in;
    output [(N*N)-1:0] out;

    function [InputLenBitCount-1:0] index2DTo1D;
        input [InputLenBitCount-1:0] i;
        input [InputLenBitCount-1:0] j;

        begin: index2DTo1DBlock
            reg [InputLenBitCount-1:0] row, col;
            row = (j + N - HalfN) % N;
            col = (i + N - HalfN) % N;
            index2DTo1D = row * N + col;
        end
    endfunction

    function [InputLenBitCount-1:0] findDst;
        input [InputLenBitCount-1:0] i;
        input [InputLenBitCount-1:0] j;

        begin
            findDst = index2DTo1D(j, (2 * i + 3 * j) % N);
        end
    endfunction

    genvar i, j;
    generate
        for (i = 0; i < N; i = i + 1) begin
            for (j = 0; j < N; j = j + 1) begin
                assign out[findDst(i, j)] = in[index2DTo1D(i, j)];
            end
        end
    endgenerate
endmodule
