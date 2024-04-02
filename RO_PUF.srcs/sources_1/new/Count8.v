// 8 value counter

module Count8 (
    input clk,
    input reset,
    output done
    );

    // unsigned counter with 2^k values
    reg [2:0] clk_count = 0;    // 3-bits as need to count from 0-7
    wire done;

    always @(posedge clk) begin
        if (reset) begin
            clk_count <= 1'b0;
        end else begin
            // 8 clock cycles
            if (clk_count < 3'b111) begin
                clk_count <= clk_count + 1;
            end else begin
                // reset for next cycle
                clk_count <= 0;
            end
        end
    end

    // Assert done when clk_count = 7 (8th clk cycle)
    assign done = (clk_count == 3'b111) ? 1 : 0;

endmodule
