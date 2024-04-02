// 5 input multiplexer

module Mux5(
    input [4:0] inputs,
    input [2:0] sel,
    output reg out
    );

    always @(*) begin
        case (sel)
            3'b000:
                out = inputs[0];
            3'b001:
                out = inputs[1];
            3'b010:
                out = inputs[2];
            3'b011:
                out = inputs[3];
            3'b100:
                out = inputs[4];
            default:
                out = 1'b0;
        endcase
    end

endmodule