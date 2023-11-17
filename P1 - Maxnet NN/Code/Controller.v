`define IDLE         6'd0
`define LD1          6'd1
`define LD2          6'd2
`define LD3          6'd3
`define LD4          6'd4
`define MUL          6'd5
`define SUM1         6'd6
`define SUM2         6'd7
`define ACTIVE_FUNC  6'd8
`define CHECK        6'd9
`define STORE        6'd10

module CU(clk, rst, start, done, flag, ld1, ld2, ld3, ld4,mux1_sel, ldm1, ldm2, ldm3, ldm4);
    
    input clk, rst, start, flag;
    output ld1, ld2, ld3, ld4, ldm1, ldm2, ldm3, ldm4,mux1_sel;
    output done;
    
    reg [5:0] ns, ps;
    reg done;
    
    always @(posedge clk, posedge rst) begin
        if (rst)
            ps <= `IDLE;
        else
            ps <= ns;
    end
    
    always @(ps, start, flag, ld1, ld2, ld3, ld4,ldm1, ldm2, ldm3, ldm4,mux1_se) begin
        case (ps)
            `IDLE        : ns = (start)? `LD1: `IDLE;
            `LD1         : ns = `LD2;
            `LD2         : ns = `LD3;
            `LD3         : ns = `LD4;
            `LD4         : ns = `MUL;
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
        {ld1, ld2, ld3, ld4,ldm1, ldm2, ldm3, ldm4, mux1_se, done} = 10'b0;
        case (ps)
            `IDLE        :10'b0 ;
            `LD1         :10'b1000100010 ;
            `LD2         :10'b0100010010 ;
            `LD3         :10'b0010001010 ;
            `LD4         :10'b0001000110 ;
            `MUL         :10'b0 ;
            `SUM1        :10'b0 ;
            `SUM2        :10'b0 ;
            `ACTIVE_FUNC :10'b0 ;
            `CHECK       :10'b0 ;
            `STORE       :10'b0000000001 ;
            default      : 10'b0;
        endcase
    end
endmodule
