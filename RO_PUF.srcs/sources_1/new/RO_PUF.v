// Ring oscillator PUF with comparators

(* keep_hierarchy = "yes" *)
module RO_PUF(
    input [2:0] challenge,
    input enable,
    output response
    );

    localparam NUM_RO = 5;

    // Internal wires
    wire [NUM_RO-1:0] RO_bus_a;
    wire [NUM_RO-1:0] RO_bus_b;
    assign RO_bus_b = {RO_bus_a[0], RO_bus_a[1], RO_bus_a[2], RO_bus_a[3], RO_bus_a[4]};

    // Instantitate 5 ROs
    genvar i;
    generate
        for (i=0; i<NUM_RO; i=i+1) begin
            Oscillator osc(
                .en                 (enable),
                .out_osc            (RO_bus_a[i])
            );
        end
    endgenerate

    // MUXes
    wire mux_a_out;
    wire mux_b_out;

    Mux5 mux_a(
        .inputs             (RO_bus_a),
        .sel                (challenge),
        .out                (mux_a_out)
    );

    Mux5 mux_b(
        .inputs             (RO_bus_b),
        .sel                (challenge),
        .out                (mux_b_out)
    );

    assign response = mux_a_out ^ mux_b_out;

endmodule