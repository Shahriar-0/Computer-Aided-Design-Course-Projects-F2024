module ALU (input [31:0] data_in1,
            data_in2,
            input [3:0] select,
            output reg [31:0] data_out,
            output reg zero);

parameter [3:0] ADD = 0, SUB = 1, AND = 2, OR = 3, XOR = 4, SLT = 5, beq = 6, bne = 7, blt = 8, bge = 9;

always @(*) begin
    case (select)
        ADD: data_out = data_in1 + data_in2;
        SUB: data_out = data_in1 - data_in2;
        AND: data_out = data_in1 & data_in2;
        OR :data_out  = data_in1 | data_in2;
        XOR: data_out = data_in1 ^ data_in2;
        SLT: data_out = 1 ? (data_in1 < data_in2) : 0;
        
        beq: zero = 1 ? (data_in1 == data_in2) : 0;
        bne: zero = 1 ? (data_in1 ! = data_in2) : 0;
        blt: zero = 1 ? (data_in1 < data_in2) : 0;
        bge: zero = 1 ? (data_in1 > = data_in2) : 0;
        
        default: begin
            zero     = 1'bx;
            data_out = 32'bx;
        end
    endcase
end

endmodule
