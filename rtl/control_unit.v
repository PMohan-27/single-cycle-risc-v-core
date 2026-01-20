module control_unit(
    input  [6:0] opcode, funct7,
    input  [2:0] funct3,
    input  ZeroFlag, OverflowFlag, NegativeFlag, CarryFlag, 
    output reg [3:0] AluOp,
    output reg [1:0] MemSize, ResultSrc, PCSel,
    output reg MemWrite, RegWrite, AluSrcBSel, ExtSign,
    output reg [2:0] ImmSel
);

    always @(*)begin
        PCSel = 0;
        ImmSel = 0;
        RegWrite = 1;

        case(opcode)
        `R_TYPE:
            begin
                RegWrite = 1;
                ResultSrc = 2'b00;
                AluSrcBSel = 0;
                PCSel = 2'b00;
                MemSize = 0;
                MemWrite = 0;
                ExtSign = 0;
                ImmSel = 0;
                
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
            end
        `I_TYPE: begin 
                RegWrite = 1;
                ResultSrc = 2'b00;
                AluSrcBSel = 1;
                PCSel = 2'b00;
                ImmSel = `I_IMM;
                MemSize = 0;
                MemWrite = 0;
                ExtSign = 0;

                case(funct3) 
                    3'b000: AluOp = `ADD;
                    3'b100: AluOp = `XOR;
                    3'b110: AluOp = `OR;
                    3'b111: AluOp = `AND;
                    3'b001: AluOp = `SLL;
                    3'b101: AluOp = (funct7 == 7'h20) ? `SRA : `SRL; // funct7 == imm[11:5]
                    3'b010: AluOp = `SLT;
                    3'b011: AluOp = `SLTU;
                endcase
            end
        `I_LOAD: 
            begin
                RegWrite = 1;
                MemWrite = 0;
                ResultSrc = 2'b01;
                AluSrcBSel = 1;
                PCSel = 2'b00;
                ImmSel = `I_IMM;
                AluOp = `ADD;
                
                case(funct3)
                    3'b000: begin MemSize = 2'b00; ExtSign = 1; end
                    3'b001: begin MemSize = 2'b01; ExtSign = 1; end
                    3'b010: begin MemSize = 2'b10; ExtSign = 1; end
                    3'b100: begin MemSize = 2'b00; ExtSign = 0; end
                    3'b101: begin MemSize = 2'b01; ExtSign = 0; end
                endcase
            end
        `S_TYPE:
            begin
                RegWrite = 0;
                MemWrite = 1;
                ResultSrc = 2'b01;
                AluSrcBSel = 1;
                PCSel = 2'b00;
                ImmSel = `S_IMM;
                AluOp = `ADD;
                ExtSign = 0;
                case(funct3)
                    3'b000: MemSize = 2'b00; 
                    3'b001: MemSize = 2'b01; 
                    3'b010: MemSize = 2'b10; 
                endcase
            end
        `B_TYPE: 
            begin
                AluOp = `SUB;
                RegWrite = 0;
                MemWrite = 0;
                AluSrcBSel = 0;
                ImmSel = `B_IMM;
                MemSize = 0;
                ResultSrc = 0;
                ExtSign = 0;
                case(funct3) 
                    3'b000: PCSel = ZeroFlag ? 2'b01 : 2'b00;
                    3'b001: PCSel = ~ZeroFlag ? 2'b01 : 2'b00;
                    3'b100: PCSel = (NegativeFlag ^ OverflowFlag) ? 2'b01 : 2'b00;
                    3'b101: PCSel = ~(NegativeFlag ^ OverflowFlag) ? 2'b01 : 2'b00;
                    3'b110: PCSel = ~CarryFlag ? 2'b01 : 2'b00;
                    3'b111: PCSel = CarryFlag ? 2'b01 : 2'b00;
                endcase
            end
        `J_JAL:
            begin
            AluOp = 0;
            ResultSrc = 2'b10;
            RegWrite = 1;
            ImmSel = `J_IMM;
            PCSel = 2'b01;
            MemSize = 0;
            MemWrite = 0;
            AluSrcBSel = 0;
            ExtSign = 0;
            end
        `I_JALR: 
            begin
                if(funct3 == 3'b000)begin
                    AluOp = `ADD;
                    ResultSrc = 2'b10;
                    RegWrite = 1;
                    ImmSel = `I_IMM;
                    PCSel = 2'b10;
                    MemSize = 0;
                    MemWrite = 0;
                    AluSrcBSel = 1;
                    ExtSign = 0;
                end
            end
        endcase
    end


endmodule