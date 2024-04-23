// RO RNG PUF with 3 ROs and XOR gate, outputs 8-bits every clk cycle

module RO4_PUF(
    input clk,
    input reset,
    input enable,
    output [7:0] rand_num
    );

    // Internal wires
    wire [2:0] RO_out;
    wire xor_out;
    

    // Ring oscillators
    genvar i;
    generate
        for (i=0; i<3; i=i+1) begin
            Oscillator RO(
                .en                 (enable),
                .out_osc            (RO_out[i])
            );
        end
    endgenerate

    // XOR outputs together
    assign xor_out = RO_out[0] ^ RO_out[1] ^ RO_out[2];

    // Store in shift reg and connect parallel out directly to output
    wire [7:0] shreg_par_out;
    Shreg8 shreg(
        .clk                (clk),
        .reset              (reset),
        .shift_in           (xor_out),
        .shift_en           (enable),
        .parallel_out       (rand_num)
    );

endmodule
