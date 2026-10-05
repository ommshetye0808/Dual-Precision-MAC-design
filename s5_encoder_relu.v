`timescale 1ns / 1ps

module s5_encoder_relu (

    input  wire        sign_in,
    input  wire [5:0]  exponent_in,
    input  wire [12:0] mantissa_in,

    input  wire [1:0]  mode,

    output reg  [7:0]  data_out

);

always @(*) begin

    // --------------------------------
    // ReLU
    // Negative result = 0
    // --------------------------------

    if (sign_in == 1'b1) begin

        data_out = 8'b00000000;

    end

    else begin

        case (mode)

            // -------------------------
            // FP8 E4M3
            // -------------------------
            2'b00: begin

                data_out = {
                    1'b0,
                    exponent_in[3:0],
                    mantissa_in[11:9]
                };

            end


            // -------------------------
            // FP8 E5M2
            // -------------------------
            2'b01: begin

                data_out = {
                    1'b0,
                    exponent_in[4:0],
                    mantissa_in[11:10]
                };

            end


            // -------------------------
            // FP4 E2M1
            // -------------------------
            2'b10: begin

                data_out = {
                    4'b0000,
                    1'b0,
                    exponent_in[1:0],
                    mantissa_in[11]
                };

            end


            // -------------------------
            // FP4 E1M2
            // -------------------------
            2'b11: begin

                data_out = {
                    4'b0000,
                    1'b0,
                    exponent_in[0],
                    mantissa_in[11:10]
                };

            end


            default: begin

                data_out = 8'b00000000;

            end

        endcase

    end

end

endmodule