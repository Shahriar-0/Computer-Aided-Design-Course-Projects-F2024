`define IDLE         6'd0
`define L1           6'd1
`define L2           6'd2
`define L3           6'd3
`define L4           6'd4
`define MUL          6'd5
`define SUM1         6'd6
`define SUM2         6'd7
`define ACTIVE_FUNC  6'd8
`define CHECK        6'd9
`define STORE        6'd10

module CU(clk, rst, start, done, flag, l1, l2, l3, l4);
    
    input clk, rst, start, flag;
    output l1, l2, l3, l4;
    output done;
    
    reg [5:0] ns, ps;
    reg done;
    
    always @(posedge clk, posedge rst) begin
        if (rst)
            ps <= `IDLE;
        else
            ps <= ns;
    end
    
    always @(ps, start, flag, l1, l2, l3, l4) begin
        case (ps)
            `IDLE        : ns = (start)? `L1: `IDLE;
            `L1          : ns = `L2;
            `L2          : ns = `L3;
            `L3          : ns = `L4;
            `L4          : ns = `MUL;
            `MUL         : ns = `SUM1;
            `SUM1        : ns = `SUM2;
            `SUM2        : ns = `ACTIVE_FUNC;
            `ACTIVE_FUNC : ns = `CHECK;
            `CHECK       : ns = (flag)? `MUL : `STORE;
            `STORE       : ns = `IDLE;
            default      : ns = `IDLE;
        endcase
    end
    
    always @(ps) begin
        {l1, l2, l3, l4, done} = 5'b0;
        case (ps)
            `IDLE        : ;
            `L1          : ;
            `L2          : ;
            `L3          : ;
            `L4          : ;
            `MUL         : ;
            `SUM1        : ;
            `SUM2        : ;
            `ACTIVE_FUNC : ;
            `CHECK       : ;
            `STORE       : ;
            default      : ;
        endcase
    end
endmodule
