module DP(input clk, rst, ld1, ld2, ld3, ld4, 
          initCounter1, initCounter2, enCounter1, enCounter2, 
          input [31:0] regInput,
          output Co1, Co2);

    wire [1:0] row, column;

    Counter2bit rowCounter(.rst(rst), .clk(clk), .init(initCounter1), .en(enCounter1), .out(row), .Co(Co1));
    Counter2bit columnCounter(.rst(rst), .clk(clk), .init(initCounter2), .en(enCounter2), .out(column), .Co(Co2)); 
    
    
endmodule