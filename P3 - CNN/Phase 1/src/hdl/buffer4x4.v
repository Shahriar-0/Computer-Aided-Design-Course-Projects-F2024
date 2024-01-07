module buf4x4(clk, d_in, en, d_out);

	input clk;
	input [7:0] d_in [0:15];
	input [15:0] en;
	output reg [7:0] d_out [0:15];

	integer i;
	always @(posedge clk) begin
		for (i = 0; i < 16; i = i + 1)
			d_out[i] = (en[i]) ? d_in[i] : d_out[i];
  	end
	
endmodule