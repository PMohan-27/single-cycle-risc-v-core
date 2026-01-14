module instr_mem(
    input  [31:0] addr,
    output [31:0] read
);
    reg [31:0] instr[0:255];

    assign read = instr[addr[31:2]];

endmodule