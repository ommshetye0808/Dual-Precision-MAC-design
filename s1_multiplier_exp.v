`timescale 1ns / 1ps

module s1_multiplier_exp (

    input  wire        sign_a,
    input  wire        sign_b,

    input  wire [4:0]  exponent_a,
    input  wire [4:0]  exponent_b,

    input  wire [3:0]  mantissa_a,
    input  wire [3:0]  mantissa_b,

    output reg         sign_product,
    output reg [7:0]   mantissa_product,
    output reg [5:0]   exponent_product

);

always @(*) begin

    // Sign of A × B
    sign_product = sign_a ^ sign_b;

    // Mantissa multiplication
    mantissa_product = mantissa_a * mantissa_b;

    // Product exponent
    exponent_product = exponent_a + exponent_b;

end

endmodule