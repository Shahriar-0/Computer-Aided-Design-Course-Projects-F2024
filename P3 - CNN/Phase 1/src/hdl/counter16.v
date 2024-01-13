module count16(clk, rst, en, cout, num);

	input clk, rst, en;
	output cout;
	output reg [3:0] num;

	always @(posedge clk or posedge rst) begin
		if (rst)
			num <= 4'b0000;
		else if (en)
			num <= num+1;
	end

	assign cout = (num == 4'b1111) ? 1'b1 : 1'b0;
	
endmodule 