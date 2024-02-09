`timescale 1ns/1ns

module ColParityTB;
    parameter CLK = 5;
    parameter Count = 64;

    string testFolder = "file";

    logic clk, rst, start;
    logic [24:0] matrixIn;
    wire ready, putInput, outReady;
    wire [24:0] matrixOut;

    Main main(
        .clk(clk),
        .rst(rst),
        .start(start),
        .matrixIn(matrixIn),
        .ready(ready),
        .putInput(putInput),
        .outReady(outReady),
        .matrixOut(matrixOut)
    );

    always #CLK clk = ~clk;

    string filenameInp, filenameOut, intStorage;
    int fdInp, fdOut;

    initial begin
        {clk, rst, start} = 3'b010;
        matrixIn = 0;
        #CLK rst = 1'b0;

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

            for (int m = 0; m < Count && !$feof(fdInp); ++m) begin
                while (!putInput) #CLK;
                $fscanf(fdInp, "%b", matrixIn);
                #(2 * CLK);
            end

            while (!outReady) #CLK;
            #(2 * CLK + 1);

            for (int m = 0; m < Count; ++m) begin
                $fdisplay(fdOut, "%b", matrixOut);
                #(2 * CLK);
            end

            $fclose(fdOut);
            $fclose(fdInp);
        end

        #10 $stop;
    end
endmodule
