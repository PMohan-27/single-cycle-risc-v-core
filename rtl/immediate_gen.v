module imm_gen(
    input  [31:0] inst,
    input  [2:0] ImmSel,
    output reg [31:0] ImmExt
);

    always @(*)begin
        case(ImmSel)
        `I_IMM: ImmExt = {{20{inst[31]}}, inst[31:20]};
        `S_IMM: ImmExt = {{20{inst[31]}}, inst[31:25], inst[11:7]};
        `B_IMM: ImmExt = {{19{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};
        `J_IMM: ImmExt = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};
        endcase
    end

endmodule