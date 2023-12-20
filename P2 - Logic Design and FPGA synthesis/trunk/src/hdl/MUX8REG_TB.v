`timescale 1ns / 1ns

module MUX8REG_TB();

    parameter XLEN = 5;

    reg clock;
    reg reset;
    reg [XLEN-1:0] A, B, C, D, E, F, G, H;
    reg [2:0] select;

    wire [XLEN-1:0] out;

    MUX8REG #(XLEN) uut (
        .clock(clock),
        .reset(reset),
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .E(E),
        .F(F),
        .G(G),
        .H(H),
        .select(select),
        .out(out)
    );

    initial begin
        clock = 0;
        reset = 0;
        A = 0;
        B = 0;
        C = 0;
        D = 0;
        E = 0;
        F = 0;
        G = 0;
        H = 0;
        select = 0;

        forever #5 clock = ~clock; 
    end

    initial begin
        #10 reset = 1;
        #10 reset = 0;

        A = 3'b000; B = 3'b001; C = 3'b010; D = 3'b011;
        E = 3'b100; F = 3'b101; G = 3'b110; H = 3'b111;

        #10 select = 3'd0; // Output should be A after the next clock edge
        #10 select = 3'd1; // Output should be B after the next clock edge
        #10 select = 3'd2; // Output should be C after the next clock edge
        #10 select = 3'd3; // Output should be D after the next clock edge
        #10 select = 3'd4; // Output should be E after the next clock edge
        #10 select = 3'd5; // Output should be F after the next clock edge
        #10 select = 3'd6; // Output should be G after the next clock edge
        #10 select = 3'd7; // Output should be H after the next clock edge

        #20 $stop;
    end
      
endmodule