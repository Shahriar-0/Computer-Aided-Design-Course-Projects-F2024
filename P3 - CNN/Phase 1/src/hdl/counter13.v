module cto13(input clk, rst, en, output cout, output reg [3:0] num);
	always @(posedge clk or posedge rst)
	begin
		if(rst)
			num <= 4'b0000;
		else if(en) 
			num <= (num == 4'b1101)? 4'b0000 : num+1;
	end
	assign cout = (num == 4'b1101) ? 1'b1 : 1'b0;
endmodule 