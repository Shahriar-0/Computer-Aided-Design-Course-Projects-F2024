module count64(clk, rst, en, cout, num);

	input clk, rst, en;
	output cout;
	output reg [5:0] num;

	always @(posedge clk or posedge rst) begin
		if (rst)
			num <= 6'b000000;
		else if (en)
			num <= num+1;
	end

	assign cout = (num == 6'b111111) ? 1'b1 : 1'b0;
	
endmodule
