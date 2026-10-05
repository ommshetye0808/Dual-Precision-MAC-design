`timescale 1ns / 1ps

module tb_s2_alignment;

    // Inputs
    reg        sign_product;
    reg [5:0]  exponent_product;
    reg [7:0]  mantissa_product;

    reg        sign_c;
    reg [4:0]  exponent_c;
    reg [7:0]  mantissa_c;

    // Outputs
    wire       sign_out_product;
    wire       sign_out_c;

    wire [5:0] aligned_product;
    wire [5:0] aligned_c;

    wire [5:0] common_exponent;


    // DUT
    s2_alignment uut (

        .sign_product(sign_product),
        .exponent_product(exponent_product),
        .mantissa_product(mantissa_product),

        .sign_c(sign_c),
        .exponent_c(exponent_c),
        .mantissa_c(mantissa_c),

        .sign_out_product(sign_out_product),
        .sign_out_c(sign_out_c),

        .aligned_product(aligned_product),
        .aligned_c(aligned_c),

        .common_exponent(common_exponent)
    );


    initial begin

        // -------------------------------
        // Test 1
        // Product exponent > C exponent
        // -------------------------------

        sign_product     = 1'b0;
        exponent_product = 6'd15;
        mantissa_product = 8'b11000000;

        sign_c           = 1'b0;
        exponent_c       = 5'd12;
        mantissa_c       = 8'b10000000;

        #10;

        $display("TEST 1");
        $display("Common Exponent = %d", common_exponent);
        $display("Aligned Product = %b", aligned_product);
        $display("Aligned C       = %b", aligned_c);


        // -------------------------------
        // Test 2
        // C exponent > Product exponent
        // -------------------------------

        sign_product     = 1'b0;
        exponent_product = 6'd10;
        mantissa_product = 8'b11000000;

        sign_c           = 1'b0;
        exponent_c       = 5'd14;
        mantissa_c       = 8'b10000000;

        #10;

        $display("TEST 2");
        $display("Common Exponent = %d", common_exponent);
        $display("Aligned Product = %b", aligned_product);
        $display("Aligned C       = %b", aligned_c);


        // -------------------------------
        // Test 3
        // Equal exponents
        // -------------------------------

        sign_product     = 1'b1;
        exponent_product = 6'd12;
        mantissa_product = 8'b10100000;

        sign_c           = 1'b0;
        exponent_c       = 5'd12;
        mantissa_c       = 8'b01100000;

        #10;

        $display("TEST 3");
        $display("Common Exponent = %d", common_exponent);
        $display("Aligned Product = %b", aligned_product);
        $display("Aligned C       = %b", aligned_c);


        #10;

        $finish;

    end

endmodule