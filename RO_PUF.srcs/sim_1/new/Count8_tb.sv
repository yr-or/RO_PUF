`timescale 1ns / 1ps

module Count8_tb();

    // Internal wires
    reg clk = 0;
    reg reset = 0;
    wire done;

    // Instantiate Counter
    Count8 counter(
        .clk                (clk),
        .reset              (reset),
        .done               (done)
    );



    // Clk gen
    always begin
        #10;
        clk = ~clk;
    end

endmodule
