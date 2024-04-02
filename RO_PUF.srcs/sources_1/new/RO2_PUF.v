// Ring oscillator PUF for RNG stream

(* keep_hierarchy = "yes" *)
module RO2_PUF(
    input enable,
    output response
    );
    // 2 ROs which get XORd together

    // Internal wires
    wire RO_a_out;
    wire RO_b_out;

    // Instantiate 2 ROs
    Oscillator osc_a(
        .en                 (enable),
        .out_osc            (RO_a_out)
    );
    Oscillator osc_b(
        .en                 (enable),
        .out_osc            (RO_b_out)
    );

    // XOR outputs together
    assign response = RO_a_out ^ RO_b_out;

endmodule