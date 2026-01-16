module control_unit(
    input  [6:0] opcode, funct7,
    input  [2:0] funct3,
    input  ZeroFlag, OverflowFlag, NegativeFlag,
    output reg [3:0] AluOp,
    output reg MemWrite, RegWrite, AluSrcBSel, ResultSrc, PCSel,
    output reg [3:0] ImmSel
);

    always @(*)begin
        case(opcode)
        `R_TYPE:
            RegWrite = 1;
            ResultSrc = 0;
            AluSrcBSel = 0;
            PCSel = 0;
            
            case({funct7[5],funct3})
            {1'b0,3'b000}: AluOp = `ADD;
            {1'b0,3'b100}: AluOp = `XOR;
            {1'b0,3'b110}: AluOp = `OR;
            {1'b0, 3'b111}: AluOp = `AND;
            {1'b0, 3'b001}: AluOp =  `SLL;
            {1'b0, 3'b101}: AluOp =  `SRL;
            {1'b0, 3'b010}: AluOp =  `SLT;
            {1'b0, 3'b011}: AluOp =  `SLTU;

            {1'b1,3'b000}: AluOp = `SUB;
            {1'b1,3'b101}: AluOp = `SRA;
            endcase
        endcase
    end


endmodule