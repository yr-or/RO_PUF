// 8-bit shift-register

module Shreg8(
        input clk,
        input reset,
        input shift_in,
        input shift_en,
        output [7:0] parallel_out
    );

    reg [7:0] data_ff;

    always @(posedge clk) begin
        if (reset) begin
            data_ff <= 8'b0;
        end else if (shift_en) begin
            data_ff <= {data_ff[6:0], shift_in};
        end
    end

    assign parallel_out = data_ff;

endmodule
