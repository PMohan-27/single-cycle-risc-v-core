`ifndef CONSTANTS_VH
`define CONSTANTS_VH

`define ADD 4'b0000
`define SUB 4'b0001
`define XOR 4'b0010
`define OR  4'b0011
`define AND 4'b0100
`define SLL 4'b0101
`define SRL 4'b0110
`define SRA 4'b0111
`define SLT 4'b1000
`define SLTU 4'b1001
`define B_PASS 4'b1010


`define R_TYPE 7'b0110011
`define I_TYPE 7'b0010011
`define I_LOAD 7'b0000011
`define S_TYPE 7'b0100011
`define B_TYPE 7'b1100011
`define J_JAL 7'b1101111
`define I_JALR 7'b1100111
`define U_LUI 7'b0110111
`define U_AUIPC 7'b0010111

`define I_IMM 3'b000
`define S_IMM 3'b001
`define B_IMM 3'b010
`define U_IMM 3'b011
`define J_IMM 3'b100

`endif 