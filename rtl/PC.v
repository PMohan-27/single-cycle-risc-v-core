module PC(
    input clk,
    input [31:0] PC_in,
    output reg [31:0] PC_out
);

    always_ff @(posedge clk) begin
        PC_out <= PC_in;
    end

endmodule