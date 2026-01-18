module imm_gen(
    input  [31:0] inst,
    input  [2:0] ImmSel,
    output reg [31:0] ImmExt
);

    always @(*)begin
        case(ImmSel)
        `I_IMM: ImmExt = {{20{inst[31]}},inst[31:20]};
        // `S_IMM: 
        // `B_IMM:
        endcase
    end

endmodule