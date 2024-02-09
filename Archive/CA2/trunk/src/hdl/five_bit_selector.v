module FiveBitSelector(sel0, sel1, sel2, sel3, sel4, din, dout);
    input [4:0] sel0, sel1, sel2, sel3, sel4;
    input [24:0] din;
    output [4:0] dout;

    assign dout = {din[sel4], din[sel3], din[sel2], din[sel1], din[sel0]};
endmodule
