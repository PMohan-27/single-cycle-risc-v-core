module control_unit(
    input  [6:0] opcode, funct7,
    input  [2:0] funct3,
    input  ZeroFlag, OverflowFlag, NegativeFlag,
    output reg [3:0] AluOp,
    output reg MemWrite, RegWrite, AluSrcBSel, ResultSrc, PCSel,
    output reg [3:0] ImmSel
);



endmodule