module MUX2PAR #(parameter XLEN = 5) (
    input [XLEN - 1 : 0] data_in1[3:0],
    input [XLEN - 1 : 0] data_in2[3:0],
    input slc,

    output [XLEN - 1 : 0] data_out[3:0]
);

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin
            MUX2 #(XLEN) mux_0(data_in1[i], data_in2[i], slc, data_out[i]);
        end
    endgenerate

endmodule