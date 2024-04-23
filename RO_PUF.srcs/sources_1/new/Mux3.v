// 3 input Mux

module Mux3(
    input [2:0] inputs,
    input [1:0] sel,
    output reg out
    );

    always @(*) begin
        case (sel)
            2'b00:
                out = inputs[0];
            2'b01:
                out = inputs[1];
            2'b10:
                out = inputs[2];
            default:
                out = 1'b0;
        endcase
    end

endmodule
