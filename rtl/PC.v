module PC(
    input clk, rst,
    input [31:0] PC_in,
    output reg [31:0] PC_out
);

    always @(posedge clk or posedge rst) begin
        if(rst == 1'b1)begin
            PC_out <= 32'b0;
        end
        else begin
            PC_out <= PC_in;
        end
    end

endmodule