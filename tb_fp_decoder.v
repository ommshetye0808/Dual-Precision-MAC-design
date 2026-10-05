`timescale 1ns / 1ps

module tb_fp_decoder;

    reg [7:0] data_in;
    reg [1:0] mode;

    wire       sign;
    wire [4:0] exponent;
    wire [3:0] mantissa;


    // =================================================
    // DUT
    // =================================================

    fp_decoder DUT (

        .data_in(data_in),
        .mode(mode),

        .sign(sign),
        .exponent(exponent),
        .mantissa(mantissa)

    );


    initial begin

        // =================================================
        // TEST 1
        // FP8 E4M3
        //
        // 1.5
        // Binary representation:
        // 00111100
        // =================================================

        mode    = 2'b00;
        data_in = 8'b00111100;

        #10;

        $display("--------------------------------------");
        $display("FP8 E4M3");
        $display("Input     = %b", data_in);
        $display("Sign      = %b", sign);
        $display("Exponent  = %b", exponent);
        $display("Mantissa  = %b", mantissa);


        // =================================================
        // TEST 2
        // FP8 E5M2
        //
        // 1.5
        // =================================================

        mode    = 2'b01;
        data_in = 8'b00111110;

        #10;

        $display("--------------------------------------");
        $display("FP8 E5M2");
        $display("Input     = %b", data_in);
        $display("Sign      = %b", sign);
        $display("Exponent  = %b", exponent);
        $display("Mantissa  = %b", mantissa);


        // =================================================
        // TEST 3
        // FP4 E2M1
        // =================================================

        mode    = 2'b10;
        data_in = 8'b00000101;

        #10;

        $display("--------------------------------------");
        $display("FP4 E2M1");
        $display("Input     = %b", data_in);
        $display("Sign      = %b", sign);
        $display("Exponent  = %b", exponent);
        $display("Mantissa  = %b", mantissa);


        // =================================================
        // TEST 4
        // FP4 E1M2
        // =================================================

        mode    = 2'b11;
        data_in = 8'b00000110;

        #10;

        $display("--------------------------------------");
        $display("FP4 E1M2");
        $display("Input     = %b", data_in);
        $display("Sign      = %b", sign);
        $display("Exponent  = %b", exponent);
        $display("Mantissa  = %b", mantissa);


        #10;

        $finish;

    end

endmodule