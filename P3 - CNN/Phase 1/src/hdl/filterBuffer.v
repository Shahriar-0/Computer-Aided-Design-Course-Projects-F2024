module filterBuffer(clk, dataIn, en, dataOut);
    input clk;
    input [7:0] dataIn [0:3];
    input [15:0] en;
    output reg [7:0] dataOut [0:15];

    integer i;
    reg exitLoop; // A flag to indicate when to exit the loop

    always @(posedge clk) begin
        exitLoop = 0; // Reset exit flag each clock cycle's beginning
        for (i = 0; i < 16 && !exitLoop; i = i + 1) begin
            if(en[15-i]) begin
                // Make sure not to exceed array bounds
                if (i + 3 < 16) begin
                    dataOut[i] = dataIn[0];
                    dataOut[i+1] = dataIn[1];
                    dataOut[i+2] = dataIn[2];
                    dataOut[i+3] = dataIn[3];
                end
                exitLoop = 1; // Set the flag to exit the loop
            end
        end
    end
endmodule