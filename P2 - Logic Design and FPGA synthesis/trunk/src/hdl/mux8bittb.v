`timescale 1ns / 1ps

module MUX8REG3bit_tb;

    // Parameters
    parameter bits = 3;

    // Inputs
    reg clock;
    reg reset;
    reg [bits-1:0] A, B, C, D, E, F, G, H;
    reg [2:0] select;

    // Output
    wire [bits-1:0] out;

    // Instantiate the Unit Under Test (UUT)
    MUX8REG3bit #(bits) uut (
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
        // Initialize Inputs
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

        // Stimulus: Clock generation
        forever #5 clock = ~clock; // Toggle clock every 5ns
    end

    initial begin
        // Stimulus: Apply test vectors

        // Apply a reset pulse
        #10;
        reset = 1;
        #10;
        reset = 0;

        // Load input values
        A = 3'b000; B = 3'b001; C = 3'b010; D = 3'b011;
        E = 3'b100; F = 3'b101; G = 3'b110; H = 3'b111;

        // Test the multiplexer function
        #10; select = 3'd0; // Output should be A after the next clock edge
        #10; select = 3'd1; // Output should be B after the next clock edge
        #10; select = 3'd2; // Output should be C after the next clock edge
        #10; select = 3'd3; // Output should be D after the next clock edge
        #10; select = 3'd4; // Output should be E after the next clock edge
        #10; select = 3'd5; // Output should be F after the next clock edge
        #10; select = 3'd6; // Output should be G after the next clock edge
        #10; select = 3'd7; // Output should be H after the next clock edge

        // Finish the simulation
        #20 $stop;
    end
      
endmodule