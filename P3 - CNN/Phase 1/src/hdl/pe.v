module pe#(parameter N) (clk, memO, mac2_in, en1, en12, rst12, en10, wr, sel, muxOut);

    input clk, en12, rst12, en10, wr;
    input [7:0] memO[3:0];
    input [7:0] mac2_in;
	input [15:0]en1;
    input [3:0]sel;
    input [7:0] muxOut;

	wire [7:0] filterout [0:15];
    wire [7:0] macOut,mac_in;
    wire [7:0] shiftregO[3:0];

    filterBuffer filter(.clk(clk), .dataIn(memO), .en(en1),  .dataOut(filterout));

    mux16to1 mux1(.in(filterout), .sel(sel), .out(mac_in));

    mac myMAC(.a(mac_in), .b(mac2_in), .en(en12), .rst(rst12), .clk(clk), .out(macOut));

    shiftRegister shiftRegister(.clk(clk), .en(en10), .dataIn(macOut), .dataOut(shiftregO));

    ofm OFM(.clk(clk), .address(muxOut), .wrData(shiftregO), .wr(wr), .rdData(memO));

endmodule