module cpu_top(
    input  clk,
    input  rst
);
    reg  [3:0] AluOp;
    reg [31:0] SrcA, SrcB;
    reg ZeroFlag, OverflowFlag, NegativeFlag, CarryFlag;
    reg [31:0] result;
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





endmodule