module DP(input clk, rst,start);
    
    wire [31:0] dmout;
    wire [1:0] address;
    wire [31:0] M1Out, M2Out, M3Out, M4Out;
    wire [31:0] R1Out, R2Out, R3Out, R4Out;
    wire [31:0] end1, end2, end3, end4;//for the output reg
    wire [31:0] PUOut, PU2Out, PU3Out, PU4Out;
    wire [31:0] AOut, A2Out, A3Out, A4Out;
    wire [3:0] mux_sel;
    wire end_case ;
    wire ld1, ld2, ld3, ld4;
    wire done;
    wire Selectm;
    wire ldm1, ldm2, ldm3, ldm4;
    wire lp1,lp2,lp3;


     wire [31:0] maxnumber;


reg [31:0] w [0:3][0:3]; 
    integer i;
    integer j;

    initial begin
        for (i = 0; i < 4; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1) begin
                if (i == j) begin
                    w[i][j] = 32'b00111111100000000000000000000000;
                end else begin
                    w[i][j] = 32'b10111110010011001100110011001101;  // Replace with your epsilon value
                end
            end
        end
    end

CU cntrl(
    .clk(clk),
    .rst(rst),
    .start(start),
    .done(done),
    .flag(end_case),
    .ld1(ld1),
    .ld2(ld2),
    .ld3(ld3),
    .ld4(ld4),
    .mux1_sel(Selectm),
    .ldm1(ldm1),
    .ldm2(ldm2), 
    .ldm3(ldm3), 
    .ldm4(ldm4),
    .address(address),
    .l1(lp1),
    .l2(lp2),
    .l3(lp3)
);




//in contorroler increment addres by one and then put it in the register by l1   
    DataMemory Dm(.clk(clk),.rst(rst),.address(address),.read_data(dmout));
    mux2bit M1(.a(dmout),.b(AOut),.sel(Selectm),.y(M1Out));//first time it gonaa be zero in contoreloer after that 0 all the time
    mux2bit M2(.a(dmout),.b(A2Out),.sel(Selectm),.y(M2Out));//first time it gonaa be zero in contoreloer after that 0 all the time
    mux2bit M3(.a(dmout),.b(A3Out),.sel(Selectm),.y(M3Out));//first time it gonaa be zero in contoreloer after that 0 all the time
    mux2bit M4(.a(dmout),.b(A4Out),.sel(Selectm),.y(M4Out));//first time it gonaa be zero in contoreloer after that 0 all the time
   
    Register R1(.clk(clk),.rst(rst),.load_enable(ld1),.data_in(M1Out),.data_out(R1Out));
    Register R2(.clk(clk),.rst(rst),.data_in(M2Out),.data_out(R2Out),.load_enable(ld2));
    Register R3(.clk(clk),.rst(rst),.data_in(M3Out),.data_out(R3Out),.load_enable(ld3));
    Register R4(.clk(clk),.rst(rst),.data_in(M4Out),.data_out(R4Out),.load_enable(ld4));

    ProcessingUnit p1(.num1(R1Out),.num2(R2Out),.num3(R3Out),.num4(R4Out),.weight1(w[0][0]),.weight2(w[0][1]),.weight3(w[0][2]),.weight4(w[0][3]),.clk(clk),.result(PUOut),.l1(lp1),.l2(lp2),.l3(lp3));
    ProcessingUnit p2(.num1(R1Out),.num2(R2Out),.num3(R3Out),.num4(R4Out),.weight1(w[1][0]),.weight2(w[1][1]),.weight3(w[1][2]),.weight4(w[1][3]),.clk(clk),.result(PU2Out),.l1(lp1),.l2(lp2),.l3(lp3));
    ProcessingUnit p3(.num1(R1Out),.num2(R2Out),.num3(R3Out),.num4(R4Out),.weight1(w[2][0]),.weight2(w[2][1]),.weight3(w[2][2]),.weight4(w[2][3]),.clk(clk),.result(PU3Out),.l1(lp1),.l2(lp2),.l3(lp3));
    ProcessingUnit p4(.num1(R1Out),.num2(R2Out),.num3(R3Out),.num4(R4Out),.weight1(w[3][0]),.weight2(w[3][1]),.weight3(w[3][2]),.weight4(w[3][3]),.clk(clk),.result(PU4Out),.l1(lp1),.l2(lp2),.l3(lp3));

    relu rel1(.B(PUOut),.y(AOut));
    relu rel2(.B(PU2Out),.y(A2Out));
    relu rel3(.B(PU3Out),.y(A3Out));
    relu rel4(.B(PU4Out),.y(A4Out));
    
    check_negatives state_determiner(.in1(AOut),.in2(A2Out),.in3(A3Out),.in4(A4Out),.non_negatives(mux_sel),.three_negatives(end_case));

    Register RO1 (.clk(clk),.rst(rst),.load_enable(ldm1),.data_in(end1),.data_out(end1));
    Register RO2 (.clk(clk),.rst(rst),.data_in(dmout),.data_out(end2),.load_enable(ldm2));
    Register RO3 (.clk(clk),.rst(rst),.data_in(dmout),.data_out(end3),.load_enable(ldm3));
    Register RO4 (.clk(clk),.rst(rst),.data_in(dmout),.data_out(end4),.load_enable(ldm4));


    mux4to1 end_max(end1,end2,end3,end4,mux_sel,end_case,maxnumber);





    
    
endmodule