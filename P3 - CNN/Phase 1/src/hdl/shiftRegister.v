module shiftRegister(clk,en,dataIn,dataOut);
	input clk,en;
	input[7:0] dataIn;
	output reg[7:0] dataOut[3:0];
always @(posedge clk) begin
        if (en) begin
            dataOut[0] <= dataOut[1]; // Shift stage 1 to stage 0
            dataOut[1] <= dataOut[2]; // Shift stage 2 to stage 1
            dataOut[2] <= dataOut[3]; // Shift stage 3 to stage 2
            dataOut[3] <= dataIn;     // New data in to stage 3
        end
    end
endmodule
