module mux3to1(a, b, c, sel, out);

    input [7:0] a, b, c;
    input [1:0] sel;
    output reg [7:0] out;
    
    always @(*) begin 
        case(sel)
            2'b00: out = a;    
            2'b01: out = b;    
            2'b10: out = c;    
            default: out = 7'b0; 
        endcase
    end

endmodule