`timescale 1ns/1ns

module RISC_V_SingleCycle(
    input clock, reset
);


    wire mem_write, ALU_src, reg_write, zero;
    wire [1:0] PC_src, result_src;
    wire [2:0] extend_src;
    wire [3:0] ALU_control;
    wire [31:0] PC_next, PC_out ,instr, src_A, src_B, imm_ext, PC_plus_4, PC_target, write_data, read_data, result, ALU_result;

    Register pc(.clock(clock), .reset(reset), .data_in(PC_next), .data_out(PC_out));
    DataMemory dm(.clock(clock), .reset(reset), .writeEn(mem_write), .address(ALU_result), .write_data(write_data), .read_data(read_data));
    RegisterFile rf(.clock(clock), .reset(reset), .writeEn(reg_write), .address_rd1(instr[19:15]), .address_rd2(instr[24:20]), .address_wr(instr[11:7]), .write_data(result), .read_data1(src_A), .read_data2(write_data));
    InstructionMem im(.address(PC_out), .instruction(instr));

    Controller cntrl(
        .opcode(instr[6:0]),
        .func3(instr[14:12]),
        .func7(instr[31:25]),
        .zero(zero),
        
        .PC_src(PC_src),
        .result_src(result_src),
        .mem_write(mem_write),
        .ALU_control(ALU_control),
        .ALU_src(ALU_src),
        .extend_src(extend_src),
        .reg_write(reg_write)
    );


    MUX4 pc_mux(.data_in1(PC_plus_4), .data_in2(PC_target), .data_in3(ALU_result), .data_in4(32'bz), .select(PC_src), .data_out(PC_next));
    
    Adder pc_4(.data_in1(PC_out), .data_in2(1), .data_out(PC_plus_4));
    Extend ex(.data_in(instr[31:7]), .select(extend_src), .data_out(imm_ext));
    MUX2 src_B_mux(.data_in1(write_data), .data_in2(imm_ext), .select(ALU_src), .data_out(src_B));
    ALU alu(.data_in1(src_A), .data_in2(src_B), .select(ALU_control), .data_out(ALU_result), .zero(zero));
    Adder pc_jump(.data_in1(PC_out), .data_in2(imm_ext), .data_out(PC_target));
    MUX4 result_mux(.data_in1(ALU_result), .data_in2(read_data), .data_in3(PC_plus_4), .data_in4(imm_ext), .select(result_src), .data_out(result));

    
   
    

endmodule