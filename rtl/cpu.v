`include "constants.vh"

module cpu_top(
    input  clk,
    input  rst
);


    wire  [3:0] AluOp;
    wire [31:0] SrcA, SrcB;
    wire [31:0] AluResult;

    wire PC_sel;
    wire [31:0] PC_in, PC_out;
    
    wire  [6:0] opcode, funct7;
    wire  [2:0] funct3;
    wire  ZeroFlag, OverflowFlag, NegativeFlag, CarryFlag;
    wire ExtSign; // Sign control for Load/store
    wire  MemWrite, RegWrite, AluSrcBSel, ResultSrc, PCSel;
    wire [1:0] MemSize;
    wire [2:0] ImmSel;



    wire [31:0] read;


    wire [4:0] A1, A2, A3;
    wire [31:0] WD3;
    wire WE3;
    wire [31:0] RD1, RD2;
    
    wire [31:0] ImmExt;
    wire [31:0] DataMemResult;

    assign PC_in = (PC_sel == 1'b0) ? PC_out+4 : PC_out+ImmExt;

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
    assign WD3 = (ResultSrc == 1'b0) ? AluResult : DataMemResult; // will be a mux with alu result and data mem read
    assign SrcA = RD1;
    assign SrcB = (AluSrcBSel == 1'b0) ? RD2 : ImmExt;

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
        .WD3(WD3),
        .WE3(RegWrite),
        .RD1(RD1),
        .RD2(RD2),
        .rst(rst)

    );
    ALU alu_inst(
        .AluOp(AluOp),
        .SrcA(SrcA),
        .SrcB(SrcB),
        .ZeroFlag(ZeroFlag),
        .OverflowFlag(OverflowFlag),
        .NegativeFlag(NegativeFlag),
        .CarryFlag(CarryFlag),
        .result(AluResult)
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
        .ImmSel(ImmSel),
        .MemSize(MemSize),
        .ExtSign(ExtSign)
    );

    imm_gen imm_gen_inst(
        .inst(read),
        .ImmSel(ImmSel),
        .ImmExt(ImmExt)
    );  

    data_mem data_memory_inst(
        .WE(MemWrite),
        .clk(clk),
        .rst(rst),
        .ExtSign(ExtSign),
        .MemSize(MemSize),
        .addr(AluResult),
        .WD(RD2),
        .read(DataMemResult)
    );



endmodule