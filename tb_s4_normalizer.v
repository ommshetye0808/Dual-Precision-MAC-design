`timescale 1ns / 1ps

module tb_s4_normalizer;

    // Inputs
    reg         sign_in;
    reg  [12:0] mantissa_in;
    reg  [5:0]  exponent_in;

    // Outputs
    wire        sign_out;
    wire [12:0] mantissa_out;
    wire [5:0]  exponent_out;
    wire [3:0]  leading_zeros;


    // DUT
    s4_normalizer uut (

        .sign_in(sign_in),
        .mantissa_in(mantissa_in),
        .exponent_in(exponent_in),

        .sign_out(sign_out),
        .mantissa_out(mantissa_out),
        .exponent_out(exponent_out),
        .leading_zeros(leading_zeros)
    );


    initial begin

        // --------------------------------
        // TEST 1: Normalization required
        // --------------------------------

        sign_in     = 1'b0;
        mantissa_in = 13'b0000011010000;
        exponent_in = 6'd15;

        #10;

        $display("--------------------------------");
        $display("TEST 1");
        $display("Input Mantissa  = %b", mantissa_in);
        $display("Leading Zeros   = %d", leading_zeros);
        $display("Output Mantissa = %b", mantissa_out);
        $display("Input Exponent  = %d", exponent_in);
        $display("Output Exponent = %d", exponent_out);


        // --------------------------------
        // TEST 2: No leading zeros
        // --------------------------------

        sign_in     = 1'b0;
        mantissa_in = 13'b1000000000000;
        exponent_in = 6'd20;

        #10;

        $display("--------------------------------");
        $display("TEST 2");
        $display("Input Mantissa  = %b", mantissa_in);
        $display("Leading Zeros   = %d", leading_zeros);
        $display("Output Mantissa = %b", mantissa_out);
        $display("Input Exponent  = %d", exponent_in);
        $display("Output Exponent = %d", exponent_out);


        // --------------------------------
        // TEST 3: Negative result
        // --------------------------------

        sign_in     = 1'b1;
        mantissa_in = 13'b0000001110000;
        exponent_in = 6'd18;

        #10;

        $display("--------------------------------");
        $display("TEST 3");
        $display("Input Sign      = %b", sign_in);
        $display("Leading Zeros   = %d", leading_zeros);
        $display("Output Mantissa = %b", mantissa_out);
        $display("Output Sign     = %b", sign_out);
        $display("Output Exponent = %d", exponent_out);


        // --------------------------------
        // TEST 4: Zero input
        // --------------------------------

        sign_in     = 1'b0;
        mantissa_in = 13'b0;
        exponent_in = 6'd20;

        #10;

        $display("--------------------------------");
        $display("TEST 4: ZERO");
        $display("Leading Zeros   = %d", leading_zeros);
        $display("Output Mantissa = %b", mantissa_out);
        $display("Output Exponent = %d", exponent_out);


        #10;

        $finish;

    end

endmodule