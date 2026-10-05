`timescale 1ns / 1ps

module fp_decoder (

    input  wire [7:0] data_in,

    // 00 = FP8 E4M3
    // 01 = FP8 E5M2
    // 10 = FP4 E2M1
    // 11 = FP4 E1M2
    input  wire [1:0] mode,

    output reg        sign,
    output reg [4:0]  exponent,
    output reg [3:0]  mantissa

);

always @(*) begin

    // Default values
    sign     = 1'b0;
    exponent = 5'b0;
    mantissa = 4'b0;

    case (mode)

        // =================================================
        // FP8 E4M3
        //
        // S EEEE MMM
        // =================================================

        2'b00: begin

            sign = data_in[7];

            exponent = {
                1'b0,
                data_in[6:3]
            };

            // Add hidden 1
            mantissa = {
                1'b1,
                data_in[2:0]
            };

        end


        // =================================================
        // FP8 E5M2
        //
        // S EEEEE MM
        // =================================================

        2'b01: begin

            sign = data_in[7];

            exponent = data_in[6:2];

            // Add hidden 1
            // 1 + 2 mantissa bits
            // padded to 4 bits
            mantissa = {
                1'b1,
                data_in[1:0],
                1'b0
            };

        end


        // =================================================
        // FP4 E2M1
        //
        // S EE M
        //
        // We use the lower 4 bits
        // =================================================

        2'b10: begin

            sign = data_in[3];

            exponent = {
                3'b000,
                data_in[2:1]
            };

            // Hidden 1 + M
            mantissa = {
                2'b00,
                1'b1,
                data_in[0]
            };

        end


        // =================================================
        // FP4 E1M2
        //
        // S E MM
        //
        // We use the lower 4 bits
        // =================================================

        2'b11: begin

            sign = data_in[3];

            exponent = {
                4'b0000,
                data_in[2]
            };

            // Hidden 1 + MM
            mantissa = {
                1'b0,
                1'b1,
                data_in[1:0]
            };

        end

    endcase

end

endmodule