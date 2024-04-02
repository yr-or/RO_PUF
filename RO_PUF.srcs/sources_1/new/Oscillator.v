// Oscillator module
// Based on: https://ieeexplore.ieee.org/document/7195665 and https://github.com/stnolting/neoTRNG?tab=readme-ov-file

(* keep_hierarchy = "yes" *)
module Oscillator(
    input en,
    output out_osc
);
    
    // Design: 5 NOT gates with transparent D-latches in between
    // Internal wires
    reg latch_out1, latch_out2, latch_out3, latch_out4, latch_out5;
    wire not1, not2, not3, not4, not5;

    // Create latches
    always @(*) begin
        if (en) begin
            // When enabled, latch passes input to output
            latch_out1 = not1;
            latch_out2 = not2;
            latch_out3 = not3;
            latch_out4 = not4;
            latch_out5 = not5;
        end
    end

    // Create NOT gates
    assign not1 = ~latch_out5;
    assign not2 = ~latch_out1;
    assign not3 = ~latch_out2;
    assign not4 = ~latch_out3;
    assign not5 = ~latch_out4;

    // Output
    assign out_osc = latch_out5;


endmodule