`timescale 1ns / 1ps

module dual_precision_mac (

    input wire        clk,
    input wire        rst,

    input wire [7:0]  A,
    input wire [7:0]  B,
    input wire [7:0]  C,

    input wire [1:0]  mode,

    output wire [7:0] result

);

    // =====================================================
    // S0 - Decoder
    // =====================================================

    wire       sign_a;
    wire       sign_b;
    wire       sign_c;

    wire [4:0] exponent_a;
    wire [4:0] exponent_b;
    wire [4:0] exponent_c;

    wire [3:0] mantissa_a;
    wire [3:0] mantissa_b;
    wire [3:0] mantissa_c;


    fp_decoder decoder_a (
        .data_in(A),
        .mode(mode),
        .sign(sign_a),
        .exponent(exponent_a),
        .mantissa(mantissa_a)
    );


    fp_decoder decoder_b (
        .data_in(B),
        .mode(mode),
        .sign(sign_b),
        .exponent(exponent_b),
        .mantissa(mantissa_b)
    );


    fp_decoder decoder_c (
        .data_in(C),
        .mode(mode),
        .sign(sign_c),
        .exponent(exponent_c),
        .mantissa(mantissa_c)
    );


    // =====================================================
    // S1 - Multiplication + Exponent
    // =====================================================

    wire       sign_product;
    wire [7:0] mantissa_product;
    wire [5:0] exponent_product;


    s1_multiplier_exp multiplier_exp (

        .sign_a(sign_a),
        .sign_b(sign_b),

        .exponent_a(exponent_a),
        .exponent_b(exponent_b),

        .mantissa_a(mantissa_a),
        .mantissa_b(mantissa_b),

        .sign_product(sign_product),
        .mantissa_product(mantissa_product),
        .exponent_product(exponent_product)
    );


    // =====================================================
    // S2 - Exponent Alignment
    // =====================================================

    wire       sign_out_product;
    wire       sign_out_c;

    wire [5:0] aligned_product;
    wire [5:0] aligned_c;

    wire [5:0] common_exponent;


    s2_alignment alignment (

        .sign_product(sign_product),
        .exponent_product(exponent_product),
        .mantissa_product(mantissa_product),

        .sign_c(sign_c),
        .exponent_c(exponent_c),
        .mantissa_c({4'b0000, mantissa_c}),

        .sign_out_product(sign_out_product),
        .sign_out_c(sign_out_c),

        .aligned_product(aligned_product),
        .aligned_c(aligned_c),

        .common_exponent(common_exponent)
    );


    // =====================================================
    // S3 - CSA / CSLA Accumulation
    // =====================================================

    wire        sign_result_s3;
    wire [12:0] mantissa_result_s3;
    wire [5:0]  exponent_result_s3;


    s3_accumulator accumulator (

        .clk(clk),
        .rst(rst),

        .sign_product(sign_out_product),
        .sign_c(sign_out_c),

        .aligned_product(aligned_product),
        .aligned_c(aligned_c),

        .common_exponent(common_exponent),

        .sign_result(sign_result_s3),
        .mantissa_result(mantissa_result_s3),
        .exponent_result(exponent_result_s3)
    );


    // =====================================================
    // S4 - Normalization
    // =====================================================

    wire        sign_result_s4;
    wire [12:0] mantissa_result_s4;
    wire [5:0]  exponent_result_s4;
    wire [3:0]  leading_zeros;


    s4_normalizer normalizer (

        .sign_in(sign_result_s3),
        .mantissa_in(mantissa_result_s3),
        .exponent_in(exponent_result_s3),

        .sign_out(sign_result_s4),
        .mantissa_out(mantissa_result_s4),
        .exponent_out(exponent_result_s4),
        .leading_zeros(leading_zeros)
    );


    // =====================================================
    // S5 - Output Encoder + ReLU
    // =====================================================

    s5_encoder_relu encoder_relu (

        .sign_in(sign_result_s4),
        .exponent_in(exponent_result_s4),
        .mantissa_in(mantissa_result_s4),

        .mode(mode),

        .data_out(result)
    );


endmodule