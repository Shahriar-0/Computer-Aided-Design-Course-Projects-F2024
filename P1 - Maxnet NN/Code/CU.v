`define IDLE 6'd0
`define INIT 6'd4
`define MUL  6'd5
`define ADD  6'd6
`define LD   6'd7

module CU(clk,
          rst,
          start,
          done,
          flag,
          ld1,
          mux1_sel,
          ldm1,
          ldm2,
          ldm3,
          ldm4,
          address,
          l1,
          l2,
          l3);
    
    input clk, rst, start, flag;
    output reg ld1, ld2, ld3, ld4, ldm1, ldm2, ldm3, ldm4, mux1_sel,l1,l2,l3;
    output reg done;
    output reg [1:0]address;
    
    reg [5:0] ns, ps;
    
    always @(posedge clk, posedge rst) begin
        if (rst)
            ps <= `IDLE;
        else
            ps <= ns;
    end
    
    always @(ps, start, flag, ld1, ld2, ld3, ld4,ldm1, ldm2, ldm3, ldm4,mux1_sel,done,address,l1,l2,l3) begin
        case (ps)
            `IDLE        : ns = (start)? `LD1: `IDLE;
            `LD1         : ns = `LD2;
            `LD2         : ns = `LD3;
            `LD3         : ns = `LD4;
            `LD4         : ns = `MUL;
            `MUL         : ns = `SUM1;
            `SUM1        : ns = `SUM2;
            `SUM2        : ns = `CHECK;
            `CHECK       : ns = (flag)? `MUL : `STORE;
            `STORE       : ns = `IDLE;
            default      : ns = `IDLE;
        endcase
    end
    
    always @(ps) begin
        {ld1, ld2, ld3, ld4,ldm1, ldm2, ldm3, ldm4, mux1_sel, done,address,l1,l2,l3} = 15'b0;
        case (ps)
            `IDLE        :{ld1, ld2, ld3, ld4,ldm1, ldm2, ldm3, ldm4, mux1_sel, done}                  = 15'b0;
            `LD1         :{ld1, ldm1,mux1_sel,address}                                                 = 5'b11000;
            `LD2         :{ld2, ldm2,mux1_sel,address}                                                 = 5'b11001 ;
            `LD3         :{ld3, ldm3,mux1_sel,address}                                                 = 5'b11010  ;
            `LD4         :{ld4, ldm4,mux1_sel,address}                                                 = 5'b11011 ;
            `MUL         :{l1,l2,l3}                                                                   = 3'b100;
            `SUM1        :{l1,l2,l3}                                                                   = 3'b010;
            `SUM2        :{mux1_sel,l1,l2,l3}                                                          = 4'b1001;
            `CHECK       :{ld1, ld2, ld3, ld4,mux1_sel}                                                = 5'b11111;
            `STORE       :{done}                                                                       = 1'b1 ;
            default      :{ld1, ld2, ld3, ld4,ldm1, ldm2, ldm3, ldm4, mux1_sel, done,address,l1,l2,l3} = 15'b0;
        endcase
    end
endmodule
