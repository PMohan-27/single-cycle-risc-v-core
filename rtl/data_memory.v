module data_mem(
    input WE, clk, rst, 
    input ExtSign, // 0 = Unsigned, 1 = Signed
    input [1:0] MemSize, // 2'b00 byte, 2'b01 half word, 2'b10 word
    input  [31:0] addr, WD,
    output reg [31:0] read
);
    reg [31:0] memory [0:31];
    integer i;

    reg misalign;
    reg [7:0] byte_selected;
    reg [15:0] hw_selected;

    always @(*)begin
        case(MemSize)
            2'b00: misalign = 1'b0;
            2'b01: misalign = (addr[0] != 1'b0);
            2'b10: misalign = (addr[1:0] != 2'b00);
        endcase

        case(addr[1:0])
            2'b00: byte_selected = memory[addr[31:2]][7:0];
            2'b01: byte_selected = memory[addr[31:2]][15:8];
            2'b10: byte_selected = memory[addr[31:2]][23:16];
            2'b11: byte_selected = memory[addr[31:2]][31:24];
        endcase
        hw_selected = (addr[1] == 1'b0) ? memory[addr[31:2]][15:0] : memory[addr[31:2]][31:16];

        if(misalign == 1'b1)begin
            read = 32'bx;
        end
        else begin
            case(MemSize)
                2'b00: read = (ExtSign == 1'b0) ? {24'b0,byte_selected} : {{24{byte_selected[7]}}, byte_selected};
                2'b01: read = (ExtSign == 1'b0) ? {16'b0, hw_selected} : {{16{hw_selected[15]}}, hw_selected};
                2'b10: read = memory[addr[31:2]];
                default: read = 32'b0;
            endcase
        end
    end
    
   always @(posedge clk or posedge rst) begin
    if(rst == 1'b1) begin
        for (i = 0; i < 32; i = i + 1) begin
            memory[i] <= 32'h0;
        end
    end
    else begin 
        if(WE & !misalign)begin
            case(MemSize) 
            2'b00: begin 
                case (addr[1:0])
                    2'b00: memory[addr[31:2]][7:0] <= WD[7:0];
                    2'b01: memory[addr[31:2]][15:8] <= WD[7:0];
                    2'b10: memory[addr[31:2]][23:16] <= WD[7:0];
                    2'b11: memory[addr[31:2]][31:24] <= WD[7:0];
                endcase 
            end
            2'b01: begin
                case(addr[1])
                    1'b0: memory[addr[31:2]][15:0] <= WD[15:0];
                    1'b1: memory[addr[31:2]][31:16] <= WD[15:0];
                endcase
            end
            2'b10: memory[addr[31:2]] <= WD;
            endcase
        end
    end
   end

endmodule