module MUX8REG #(parameter XLEN = 5) (
    input clock, reset,
    input [XLEN - 1 : 0] A, B, C, D, E, F, G, H,
    input [2:0] select,
    
    output reg [XLEN - 1 : 0] out
);

    wire [XLEN - 1 : 0] mux4_out_0, mux4_out_1;

    MUX4REG3 #(XLEN) mux4reg_inst_0 (
        .clock(clock),
        .reset(reset),
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .select(select[1:0]),
        .out(mux4_out_0)
    );

    MUX4REG3 #(XLEN) mux4reg_inst_1 (
        .clock(clock),
        .reset(reset),
        .A(E),
        .B(F),
        .C(G),
        .D(H),
        .select(select[1:0]),
        .out(mux4_out_1)
    );

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            out <= 0;
        end else begin
            out <= select[2] ? mux4_out_1 : mux4_out_0; 
        end
    end

endmodule