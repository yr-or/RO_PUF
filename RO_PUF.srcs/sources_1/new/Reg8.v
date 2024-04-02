// 8-bit register with CE

module Reg8(
    input clk,
    input ce,
    input [7:0] D,
    output [7:0] Q
    );

    reg [7:0] data_ff = 0;

    always @(posedge clk) begin
        if (ce) begin
            data_ff <= D;
        end
    end

    assign Q = data_ff;

endmodule
