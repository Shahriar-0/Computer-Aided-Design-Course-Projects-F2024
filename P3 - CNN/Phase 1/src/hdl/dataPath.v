module dataPath #(parameter N)(clk, sel, wr, shift, X, Y, Z, 
				  rst3, rst6, rst7, rst9, rst11, rst5, rst12, rst8, rstN,
				  en2, en1, en4, en3, en6, en7, en9, en11, en5, en12, en10, en8, 
				  cout3, cout6, cout7, cout9, cout11, cout5, cout8, coutN, num);

	input clk, wr, shift, 
		  rst3, rst6, rst7, rst9, rst11, rst5, rst12, rst8, rstN, 
		  en3, en6, en7, en9, en11, en5, en12, en10, en8;
	input [1:0] sel;
	input [7:0] X, Y, Z;
	input [15:0] en2, en4; 
	input [15:0]en1 [N - 1:0];

	wire [7:0] buf16O [0:15];
	wire [7:0] filterout [0:15];
	wire [7:0] maskOut [0:15];
	wire [7:0] sumX,sumY,sumZ;
	wire [3:0] counterOut;
	wire [7:0] macOut;
	wire [7:0] mac_in,mac2_in;
	wire [1:0] addtoY;
	wire [5:0] addtoX,addtoZ;
	wire [1:0] shiftcount,shiftregcount;
	wire [3:0] addres;
	wire [7:0] muxOut;
	wire [7:0] shiftregO[3:0];
	wire [7:0] memO[3:0];


	output [N - 1:0] num;
	output cout3,cout6,cout7,cout9,cout11,cout5,cout8,coutN;

	mux3to1 mux3(.sel(sel), .a(sumX), .b(sumY), .c(sumZ), .out(muxOut));
	memory  Mem(.clk(clk), .address(muxOut), .wrData(shiftregO), .wr(1'b0), .rdData(memO));

	count4	Counter         (.clk(clk), .rst(rst11), .en(en11),  .cout(cout11), .num(shiftcount));
	count64	XCounter        (.clk(clk), .rst(rst6),  .en(en6),   .cout(cout6),  .num(addtoX));
	count43	ZCounter        (.clk(clk), .rst(rst7),  .en(en7),   .cout(cout7),  .num(addtoZ));
	count4	YCounter        (.clk(clk), .rst(rst9),  .en(en9),   .cout(cout9),  .num(addtoY));
	count16	myCounter3      (.clk(clk), .rst(rst5),  .en(en5),   .cout(cout5),  .num(counterOut));
	count4	myCounter4      (.clk(clk), .rst(rst8),  .en(en8),   .cout(cout8),  .num(shiftregcount));
	countN #(.N(N)) CounterN(.clk(clk), .rst(rstN),  .en(cout9), .cout(coutN),  .num(num));	
	
	mux16to1 	mux2(.sel(counterOut), .in(maskOut), .out(mac2_in));

	buffer4x16	betweenbuffer(.clk(clk), .shift(shift), .en(en2), .dataIn(memO), .readIdx(addres), .dataOut(buf16O));
	count13	Counter2(.clk(clk), .rst(rst3), .en(en3), .cout(cout3), .num(addres));
	buf4x4	mask(.clk(clk), .d_in(buf16O), .en(en4), .d_out(maskOut));
	
	genvar i;
	generate
		for (i = 0; i < N; i = i + 1) begin 
			pe #(.N(N)) peunit(
			.clk(clk),
			.memO(memO),
			.mac2_in(mac2_in),
			.en1(en1[i]),
			.sel(counterOut),
			.en12(en12),
			.rst12(rst12),
			.en10(en10),
			.wr(wr),
			.muxOut(muxOut));
		end
	endgenerate

	assign sumX = addtoX  + X;
	assign sumY = addtoY + {num,2'b0} + Y;
	assign sumZ = addtoZ + Z;

endmodule

