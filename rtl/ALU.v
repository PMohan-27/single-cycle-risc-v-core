`include "constants.vh"
module ALU(
    input  [3:0] AluOp,
    input  [31:0] SrcA, SrcB,
    output reg ZeroFlag, OverflowFlag, NegativeFlag, CarryFlag,
    output reg [31:0] result
);
    
    always @(*)begin
        // defaults
        CarryFlag = 0;
        OverflowFlag = 0;
        result = 32'b0;
        
        case(AluOp)
            `ADD:
                begin
                    // Carry checks for uint overflow
                    {CarryFlag, result} = SrcA + SrcB;
                    //over flow checking: make sure sign bits are equal (bc only pos + pos and neg + neg can overflow). 
                    //then check if the result has gone in the same direction (ex: pos + pos should yield a positive result). 
                    OverflowFlag = ((SrcA[31] == SrcB[31]) && (SrcA[31] != result[31]));
                end
            `SUB: 
                begin
                    //Carry acts as an inverse borrow for sub
                    {CarryFlag, result} = SrcA - SrcB;
                    CarryFlag = ~CarryFlag;
                    //make sure sign bits are opposite (bc only pos - neg and neg - pos can overflow)
                    //then we check if the result has the expected sign (pos - neg should result in a pos)
                    OverflowFlag = ((SrcA[31] != SrcB[31] )&&(SrcA[31] != result[31]));
                end
            `XOR: result = SrcA^SrcB;
            `OR: result = SrcA|SrcB;
            `AND: result = SrcA&SrcB;
            `SLL: result = SrcA << SrcB[4:0];
            `SRL: result = SrcA >> SrcB[4:0];
            `SRA: result = $signed(SrcA) >>> SrcB[4:0];
            `SLT: result = ($signed(SrcA) < $signed(SrcB)) ? 32'd1 : 32'd0;
            `SLTU: result = (SrcA < SrcB) ? 32'd1 : 32'd0;
            `B_PASS: result = SrcB;
            default: result = 32'b0;
        endcase
        ZeroFlag = (result == 32'b0); 
        NegativeFlag = result[31];
    end
   
    

endmodule