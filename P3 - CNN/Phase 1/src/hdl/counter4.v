module count4(clk, rst, en, cout, num);

	input clk, rst, en; 
	output cout;
	output reg [1:0] num;

	always @(posedge clk or posedge rst) begin
		if (rst)
			num <= 2'b00;
		else if (en)
			num <= num + 1;
	end

	assign cout = (num == 2'b11) ? 1'b1 : 1'b0;

endmodule 
