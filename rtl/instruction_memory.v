module instr_mem(
    input clk,
    input  [31:0] addr,
    output reg [31:0] read
);
    reg [31:0] instr[0:255];
        
     initial begin
        instr[0] = 32'h00500113; // addi x2, x0, 5       x2 = 5
        instr[1] = 32'h00A00193; // addi x3, x0, 10      x3 = 10
        instr[2] = 32'h003101B3; // add  x3, x2, x3      x3 = 15
        instr[3] = 32'hFFF18113; // addi x2, x3, -1      x2 = 14
        instr[4] = 32'h00312023; // sw   x3, 0(x2)       mem[14] = 15
        instr[5] = 32'h00012283; // lw   x5, 0(x2)       x5 = mem[14]
        instr[6] = 32'h005101B3; // add  x3, x2, x5      x3 = 29
        instr[7] = 32'h00000013; // NOP
    end
    always @(posedge clk) begin
        read <= instr[addr[31:2]];
    end
    
endmodule