module cpu_top(
    input  clk,
    input  rst
);



    reg  [3:0] AluOp;
    reg [31:0] SrcA, SrcB;
    reg ZeroFlag, OverflowFlag, NegativeFlag, CarryFlag;
    reg [31:0] result;
    wire [31:0] PC_in, PC_out;
    wire [31:0] immExt;

    assign PC_in = (PC_sel == 1'b0) ? PC+4 : PC+immExt;
    PC pc_inst(
        .clk(clk),
        .PC_in(PC_in),
        .PC_out(PC_out)
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





endmodule