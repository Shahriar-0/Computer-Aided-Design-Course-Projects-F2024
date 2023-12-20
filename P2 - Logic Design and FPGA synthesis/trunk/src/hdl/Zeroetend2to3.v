module ZeroExtend2to3 (
    input wire [1:0] in,
    output wire [2:0] out
);

    AND2 and_gate0(.out(out[0]), .A(in[0]), .B(1'b1)); 
    AND2 and_gate1(.out(out[1]), .A(in[1]), .B(1'b1)); 

    AND2 and_gate2(.out(out[2]), .A(1'b0), .B(1'b0)); 
endmodule