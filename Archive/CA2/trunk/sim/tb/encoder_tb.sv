`timescale 1ns/1ns

module EncoderTB;
    parameter CLK = 5;

    string testFolder = "file";

    logic clk = 1'b0, rst = 1'b1, start = 1'b0;
    logic [24:0] matrixIn;
    wire ready, putInput, outReady;
    wire [24:0] matrixOut;

    Encoder enc(
        .clk(clk),
        .rst(rst),
        .start(start),
        .in(matrixIn),
        .ready(ready),
        .putInput(putInput),
        .outReady(outReady),
        .out(matrixOut)
    );

    always #CLK clk = ~clk;

    string filenameInp, filenameOut, intStorage;
    int fdInp, fdOut;

    initial begin
        rst = 1'b1;
        matrixIn = 25'd0;
        #(2*CLK) rst = 1'b0;

        for (int i = 1; 1'b1; ++i) begin
            intStorage.itoa(i);
            filenameInp = {testFolder, "/input_", intStorage, ".txt"};
            filenameOut = {testFolder, "/output_", intStorage, ".txt"};

            fdInp = $fopen(filenameInp, "r");
            if (!fdInp) break;
            fdOut = $fopen(filenameOut, "w");

            while (!ready) #CLK;
            start = 1'b1;
            while (ready) #CLK;
            start = 1'b0;

            while (!putInput) #CLK;
            #(2*CLK);

            for (int m = 0; m < 64 && !$feof(fdInp); ++m) begin
                $fscanf(fdInp, "%b", matrixIn);
                #(2*CLK);
            end

            while (!outReady) #CLK;
            #(2*CLK);

            for (int m = 0; m < 64 && !$feof(fdInp); ++m) begin
                $fdisplay(fdOut, "%b", matrixOut);
                #(2*CLK);
            end

            $fclose(fdOut);
            $fclose(fdInp);
        end

        #10 $stop;
    end
endmodule
