`define IDLE 3'b000
`define INIT 3'b001
`define MUL  3'b010
`define ADD  3'b011
`define LD   3'b100

// BIT 0
//      is 1 in INIT and ADD state
//      INIT => (IDLE & start) | (INIT & start)
//      ADD  => MUL 
// BIT 1
//      is 1 in MUL and ADD state
//      MUL  => (INIT & ~start) | (LD & ~done)
//      ADD  => MUL 
// BIT 2
//      is 1 in LD state
//      LD   => ADD

module CU(
    input clk, rst, start, done,
    
    output reg ldTmp, selTmp, ldX
);
    
    reg [2:0] ns, ps;
    
    wire isIDLE, isINIT, isMUL, isADD, isLD,
         IDLEandSTART, INITandSTART, 
         INITandNOTSTART, LDandNOTDONE;
        
    assign isIDLE = (ps == `IDLE);
    assign isINIT = (ps == `INIT);
    assign isMUL  = (ps == `MUL);
    assign isADD  = (ps == `ADD);
    assign isLD   = (ps == `LD);

    AND2 and2_0(isIDLE, start, IDLEandSTART);
    AND2 and2_1(isINIT, start, INITandSTART);
    AND2 and2_2(isINIT, ~start, INITandNOTSTART);
    AND2 and2_3(isLD, ~done, LDandNOTDONE);

    OR3 or3_0(IDLEandSTART, INITandSTART, isMUL, ns[0]);
    OR3 or3_1(INITandNOTSTART, LDandNOTDONE, isMUL, ns[1]);
    assign ns[2] = isADD;
    
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
