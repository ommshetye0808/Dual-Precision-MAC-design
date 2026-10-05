`timescale 1ns / 1ps

module s4_normalizer (

    input  wire        sign_in,
    input  wire [12:0] mantissa_in,
    input  wire [5:0]  exponent_in,

    output reg         sign_out,
    output reg [12:0]  mantissa_out,
    output reg [5:0]   exponent_out,
    output reg [3:0]   leading_zeros

);

integer i;
reg found;

always @(*) begin

    sign_out      = sign_in;
    mantissa_out  = mantissa_in;
    exponent_out  = exponent_in;
    leading_zeros = 4'd0;
    found         = 1'b0;

    // --------------------------------
    // Leading Zero Detection
    // --------------------------------

    for (i = 12; i >= 0; i = i - 1) begin

        if (!found) begin

            if (mantissa_in[i] == 1'b0)
                leading_zeros = leading_zeros + 1'b1;

            else
                found = 1'b1;

        end

    end


    // --------------------------------
    // Zero result
    // --------------------------------

    if (mantissa_in == 13'b0) begin

        mantissa_out = 13'b0;
        exponent_out = 6'b0;

    end

    // --------------------------------
    // Normalization
    // --------------------------------

    else if (leading_zeros < exponent_in) begin

        mantissa_out = mantissa_in << leading_zeros;
        exponent_out = exponent_in - leading_zeros;

    end

    else begin

        mantissa_out = mantissa_in << leading_zeros;
        exponent_out = 6'b0;

    end

end

endmodule