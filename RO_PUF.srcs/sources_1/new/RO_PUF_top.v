// Top level module for RO_PUF
// Inlcudes shift register to create 8-bit output

(* keep_hierarchy = "yes" *)
module RO_PUF_top(
    input clk
    );

    wire [7:0] shreg_out;
    wire resp;
    // VIO outputs
    wire reset;
    wire enable;
    // ILA inputs

    // VIO
    vio_0 vio(
        .clk                    (clk),
        .probe_out0             (reset),
        .probe_out1             (enable)
    );

    // ILA
    ila_0 ila(
        .clk                    (clk),
        .probe0                 (shreg_out),
        .probe1                 (rand_num),
        .probe2                 (enable)
    );

    // Instantiate RO_PUF
    RO2_PUF puf(
        .enable                 (enable),
        .response               (resp)
    );

    // Connect to shreg
    Shreg8 shreg(
        .clk                    (clk),
        .reset                  (reset),
        .shift_in               (resp),
        .shift_en               (enable),
        .parallel_out           (shreg_out)
    );

    // Counter
    wire data_ready;
    Count8 counter(
        .clk                    (clk),
        .reset                  (reset),
        .done                   (data_ready)
    );

    // Load data into Data register when ready
    wire [7:0] rand_num;
    Reg8 rand_num_reg(
        .clk                    (clk),
        .ce                     (data_ready),
        .D                      (shreg_out),
        .Q                      (rand_num)
    );

endmodule
