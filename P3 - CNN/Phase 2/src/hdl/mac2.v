module mac2(a, b, en, rst, clk, out);
	input[7:0] a, b;
	input en, rst, clk;
	output[11:0] out;
	
	wire [15:0] mult = a * b;
	reg [12:0] sumOfMult;
	always @(posedge clk) begin
		if (rst)
			sumOfMult <= 12'b0;
		else if (en)
			sumOfMult <= sumOfMult + mult[15:8];
	end

	assign out = sumOfMult[11:0];
	
endmodule
