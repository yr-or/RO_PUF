
module LFSR_top(
    input clk
    );

    // Wires
    wire [7:0] lfsr_out;
    wire [7:0] seed;

    // LFSR
    LFSR lfsr(
        .clk                (clk),
        .reset              (reset),
        .seed               (seed),
        .parallel_out       (lfsr_out)
    );

    // VIO
    vio_1 vio(
        .clk                (clk),
        .probe_out0         (reset),
        .probe_out1         (seed)
    );

    // ILA
    ila_1 ila(
        .clk                (clk),
        .probe0             (reset),
        .probe1             (lfsr_out)
    );

endmodule
