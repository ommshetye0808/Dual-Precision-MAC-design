`timescale 1ns / 1ps

module s2_alignment (

    input  wire        sign_product,
    input  wire [5:0]  exponent_product,
    input  wire [7:0]  mantissa_product,

    input  wire        sign_c,
    input  wire [4:0]  exponent_c,
    input  wire [7:0]  mantissa_c,

    output reg         sign_out_product,
    output reg         sign_out_c,

    output reg [5:0]   aligned_product,
    output reg [5:0]   aligned_c,

    output reg [5:0]   common_exponent

);

reg [5:0] exponent_difference;

always @(*) begin

    sign_out_product = sign_product;
    sign_out_c       = sign_c;

    if (exponent_product >= exponent_c) begin

        common_exponent   = exponent_product;
        exponent_difference = exponent_product - exponent_c;

        aligned_product = mantissa_product[7:2];

        if (exponent_difference >= 6)
            aligned_c = 6'b0;
        else
            aligned_c = mantissa_c[7:2] >> exponent_difference;

    end

    else begin

        common_exponent   = exponent_c;
        exponent_difference = exponent_c - exponent_product;

        aligned_c = mantissa_c[7:2];

        if (exponent_difference >= 6)
            aligned_product = 6'b0;
        else
            aligned_product = mantissa_product[7:2] >> exponent_difference;

    end

end

endmodule