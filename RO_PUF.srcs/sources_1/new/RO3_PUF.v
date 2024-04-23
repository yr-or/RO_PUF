// Ring oscillator RNG PUF with muxes and feedback to sel lines of muxes

module RO3_PUF(
    input clk,
    input reset,
    input enable,
    output [7:0] rand_num
    );
    // 3 ROs per MUX then output gets XORd

    // Internal wires
    wire [2:0] RO_a_out;
    wire [2:0] RO_b_out;
    wire [1:0] feedback_sel_a;
    wire [1:0] feedback_sel_b;
    wire mux_a_out;
    wire mux_b_out;

    // Ring Oscillators
    // Top ROs
    genvar i;
    generate
        for (i=0; i<3; i=i+1) begin
            Oscillator osc_a(
                .en                 (enable),
                .out_osc            (RO_a_out[i])
            );
        end
    endgenerate
    // Bottom ROs
    generate
        for (i=0; i<3; i=i+1) begin
            Oscillator osc_b(
                .en                 (enable),
                .out_osc            (RO_b_out[i])
            );
        end
    endgenerate

    // Top mux
    Mux3 mux_a(
        .inputs                 (RO_a_out),
        .sel                    (feedback_sel_a),
        .out                    (mux_a_out)
    );
    // Bottom mux
    Mux3 mux_b(
        .inputs                 (RO_b_out),
        .sel                    (feedback_sel_b),
        .out                    (mux_b_out)
    );

    // XOR outputs of muxes together
    wire xor_out;
    assign xor_out = mux_a_out ^ mux_b_out;

    // Store in shift reg
    wire [7:0] shreg_par_out;
    Shreg8 shreg(
        .clk                (clk),
        .reset              (reset),
        .shift_in           (xor_out),
        .shift_en           (enable),
        .parallel_out       (shreg_par_out)
    );

    // Connect first 4 bits of parallel out to sel signals
    assign feedback_sel_a = shreg_par_out[1:0];
    assign feedback_sel_b = shreg_par_out[3:2];

    // Connect parallel out to data register
    // Counter
    wire data_ready;
    Count8 counter(
        .clk                    (clk),
        .reset                  (reset),
        .done                   (data_ready)
    );
    // Load data into Data register when ready
    Reg8 rand_num_reg(
        .clk                    (clk),
        .ce                     (data_ready),
        .D                      (shreg_par_out),
        .Q                      (rand_num)
    );

endmodule
