`include "constants.vh"

module cpu_top(
    input  clk,
    input  rst
);


    wire  [3:0] AluOp;
    wire [31:0] SrcA, SrcB;
    wire [31:0] result;

    wire PC_sel;
    wire [31:0] PC_in, PC_out;
    
    wire  [6:0] opcode, funct7;
    wire  [2:0] funct3;
    wire  ZeroFlag, OverflowFlag, NegativeFlag, CarryFlag;
    wire  MemWrite, RegWrite, AluSrcBSel, ResultSrc, PCSel;
    wire  [3:0] ImmSel;

    wire [31:0] immExt;


    wire [31:0] read;


    wire [4:0] A1, A2, A3;
    wire [31:0] WD3;
    wire WE3;
    wire [31:0] RD1, RD2;

    assign PC_in = (PC_sel == 1'b0) ? PC_out+4 : PC_out+immExt;

    instr_mem instruction_memory_inst(
        .addr(PC_out),
        .read(read)
    );

    assign opcode = read[6:0];
    assign funct3 = read[14:12];
    assign funct7 = read[31:25];
    assign A1 = read[19:15];
    assign A2 = read[24:20];
    assign A3 = read[11:7];
    assign WD3 = result; // will be a mux with alu result and data mem read


    PC pc_inst(
        .clk(clk),
        .PC_in(PC_in),
        .PC_out(PC_out),
        .rst(rst)
    );

    reg_file reg_file_inst(
        .clk(clk),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .WD3(result),
        .WE3(RegWrite),
        .RD1(SrcA),
        .RD2(SrcB)

    );
    ALU alu_inst(
        .AluOp(AluOp),
        .SrcA(SrcA),
        .SrcB(SrcB),
        .ZeroFlag(ZeroFlag),
        .OverflowFlag(OverflowFlag),
        .NegativeFlag(NegativeFlag),
        .CarryFlag(CarryFlag),
        .result(result)
    );

    control_unit control_unit_inst(
        .opcode(opcode),
        .funct7(funct7),
        .funct3(funct3),
        .ZeroFlag(ZeroFlag),
        .OverflowFlag(OverflowFlag),
        .NegativeFlag(NegativeFlag),
        .CarryFlag(CarryFlag),
        .AluOp(AluOp),
        .MemWrite(MemWrite),
        .RegWrite(RegWrite),
        .AluSrcBSel(AluSrcBSel),
        .ResultSrc(ResultSrc),
        .PCSel(PC_sel),
        .ImmSel(ImmSel)
    );





endmodule