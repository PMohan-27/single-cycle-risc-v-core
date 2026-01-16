module reg_file(
    input clk, rst,
    input [4:0] A1, A2, A3,
    input [31:0] WD3,
    input WE3,
    output [31:0] RD1, RD2
);  
    reg [31:0] registers [0:31];

    // since x0 is set to 0 
    assign RD1 = (A1 == 5'b0) ? 32'b0 : registers[A1];
    assign RD2 = (A2 == 5'b0) ? 32'b0 : registers[A2];

    always @(posedge clk or posedge rst)begin
        if(rst == 1'b1)begin
            integer  i = 0;
           for (i = 1; i < 32; i = i + 1) begin
                registers[i] <= 32'h0;
            end
        end
        if(WE3 && A3 != 5'b0)begin
            registers[A3] <= WD3;
        end
    end


endmodule