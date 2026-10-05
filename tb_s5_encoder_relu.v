`timescale 1ns / 1ps

module tb_s5_encoder_relu;

    reg        sign_in;
    reg [5:0]  exponent_in;
    reg [12:0] mantissa_in;
    reg [1:0]  mode;

    wire [7:0] data_out;

    // DUT
    s5_encoder_relu uut (
        .sign_in(sign_in),
        .exponent_in(exponent_in),
        .mantissa_in(mantissa_in),
        .mode(mode),
        .data_out(data_out)
    );

    initial begin

        // --------------------------------
        // TEST 1: FP8 E4M3
        // --------------------------------
        sign_in     = 1'b0;
        exponent_in = 6'd7;
        mantissa_in = 13'b1000000000000;
        mode        = 2'b00;

        #10;

        $display("--------------------------------");
        $display("TEST 1: FP8 E4M3");
        $display("Output = %b", data_out);


        // --------------------------------
        // TEST 2: FP8 E5M2
        // --------------------------------
        sign_in     = 1'b0;
        exponent_in = 6'd15;
        mantissa_in = 13'b1100000000000;
        mode        = 2'b01;

        #10;

        $display("--------------------------------");
        $display("TEST 2: FP8 E5M2");
        $display("Output = %b", data_out);


        // --------------------------------
        // TEST 3: FP4 E2M1
        // --------------------------------
        sign_in     = 1'b0;
        exponent_in = 6'd2;
        mantissa_in = 13'b1000000000000;
        mode        = 2'b10;

        #10;

        $display("--------------------------------");
        $display("TEST 3: FP4 E2M1");
        $display("Output = %b", data_out);


        // --------------------------------
        // TEST 4: FP4 E1M2
        // --------------------------------
        sign_in     = 1'b0;
        exponent_in = 6'd1;
        mantissa_in = 13'b1100000000000;
        mode        = 2'b11;

        #10;

        $display("--------------------------------");
        $display("TEST 4: FP4 E1M2");
        $display("Output = %b", data_out);


        // --------------------------------
        // TEST 5: ReLU
        // Negative input
        // --------------------------------
        sign_in     = 1'b1;
        exponent_in = 6'd10;
        mantissa_in = 13'b1000000000000;
        mode        = 2'b00;

        #10;

        $display("--------------------------------");
        $display("TEST 5: ReLU");
        $display("Output = %b", data_out);


        #10;

        $finish;

    end

endmodule