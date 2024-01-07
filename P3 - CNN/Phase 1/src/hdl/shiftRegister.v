module shiftRegister(clk, en, dataIn, dataOut);

	input clk, en;
	input[7:0] dataIn;
	output reg[7:0] dataOut[3:0];

    always @(posedge clk) begin
        if (en) begin
            dataOut[0] <= dataOut[1]; 
            dataOut[1] <= dataOut[2]; 
            dataOut[2] <= dataOut[3]; 
            dataOut[3] <= dataIn;     
        end
    end

endmodule
