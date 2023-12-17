module ZeroExtend1to3(
    input wire in,
    output wire [2:0] out
);

    AND2 and_gate0(.out(out[0]), .A(in), .B(1'b1)); 
    AND2 and_gate1(.out(out[1]), .A(in), .B(1'b0));
    AND2 and_gate2(.out(out[2]), .A(in), .B(1'b0)); 

endmodule