`define IDLE 3'd0
`define INIT 3'd1
`define MUL  3'd2
`define ADD  3'd3
`define LD   3'd4

module CU(
    input clk, rst, start, done,
    
    output reg ldTmp, selTmp, ldX
);
    
    reg [2:0] ns, ps;
    
    always @(*) begin
        case (ps)
            `IDLE  : ns = (start)? `INIT: `IDLE;
            `INIT  : ns = (start)? `INIT: `MUL;
            `MUL   : ns = `ADD;
            `ADD   : ns = `LD;
            `LD    : ns = (done)? `IDLE: `MUL;
            default: ns = `IDLE;
        endcase
    end
    
    always @(ps) begin
        {ldX, ldTmp, selTmp} = 3'b0;
        case (ps)
            `INIT: {ldX, ldTmp, selTmp} = 3'b111;
            `LD  : ldTmp                = 1'b1;
        endcase
    end
    
    always @(posedge clk, posedge rst) begin
        if (rst)
            ps <= `IDLE;
        else
            ps <= ns;
    end
    
endmodule
