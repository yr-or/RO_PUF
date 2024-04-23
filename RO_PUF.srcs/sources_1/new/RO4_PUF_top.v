// Top level module for RO4_PUF to connect to ILA and VIO

module RO4_PUF_top(
    input clk
    );

    // VIO outputs
    wire reset;
    wire enable;
    // ILA inputs
    wire [7:0] rand_num;

    // VIO
    vio_0 vio(
        .clk                    (clk),
        .probe_out0             (reset),
        .probe_out1             (enable)
    );

    // ILA
    ila_0 ila(
        .clk                    (clk),
        .probe0                 (rand_num),
        .probe1                 (enable)
    );

    // RO3_PUF
    RO4_PUF ro_puf(
        .clk                    (clk),
        .reset                  (reset),
        .enable                 (enable),
        .rand_num               (rand_num)
    );

endmodule
