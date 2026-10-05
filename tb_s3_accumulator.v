`timescale 1ns / 1ps

module tb_s3_accumulator;

    // Inputs
    reg        clk;
    reg        rst;

    reg        sign_product;
    reg        sign_c;

    reg [5:0]  aligned_product;
    reg [5:0]  aligned_c;

    reg [5:0]  common_exponent;

    // Outputs
    wire       sign_result;
    wire [12:0] mantissa_result;
    wire [5:0]  exponent_result;


    // DUT
    s3_accumulator uut (

        .clk(clk),
        .rst(rst),

        .sign_product(sign_product),
        .sign_c(sign_c),

        .aligned_product(aligned_product),
        .aligned_c(aligned_c),

        .common_exponent(common_exponent),

        .sign_result(sign_result),
        .mantissa_result(mantissa_result),
        .exponent_result(exponent_result)
    );


    // Clock generation
    initial begin
        clk = 1'b0;

        forever #5 clk = ~clk;
    end


    // Test cases
    initial begin

        // Initial reset
        rst = 1'b1;

        sign_product     = 1'b0;
        sign_c           = 1'b0;
        aligned_product  = 6'b0;
        aligned_c        = 6'b0;
        common_exponent  = 6'b0;

        #12;

        rst = 1'b0;


        // --------------------------------
        // TEST 1: Same signs → Addition
        // --------------------------------

        sign_product    = 1'b0;
        sign_c          = 1'b0;

        aligned_product = 6'd20;
        aligned_c       = 6'd10;

        common_exponent = 6'd15;

        #10;

        $display("--------------------------------");
        $display("TEST 1: ADDITION");
        $display("Product = %d", aligned_product);
        $display("C       = %d", aligned_c);
        $display("Result  = %d", mantissa_result);
        $display("Sign    = %b", sign_result);
        $display("Exponent= %d", exponent_result);


        // --------------------------------
        // TEST 2: Same signs → Addition
        // --------------------------------

        sign_product    = 1'b1;
        sign_c          = 1'b1;

        aligned_product = 6'd25;
        aligned_c       = 6'd15;

        common_exponent = 6'd12;

        #10;

        $display("--------------------------------");
        $display("TEST 2: NEGATIVE ADDITION");
        $display("Product = %d", aligned_product);
        $display("C       = %d", aligned_c);
        $display("Result  = %d", mantissa_result);
        $display("Sign    = %b", sign_result);
        $display("Exponent= %d", exponent_result);


        // --------------------------------
        // TEST 3: Different signs
        // Product > C
        // --------------------------------

        sign_product    = 1'b0;
        sign_c          = 1'b1;

        aligned_product = 6'd30;
        aligned_c       = 6'd10;

        common_exponent = 6'd14;

        #10;

        $display("--------------------------------");
        $display("TEST 3: SUBTRACTION");
        $display("Product = %d", aligned_product);
        $display("C       = %d", aligned_c);
        $display("Result  = %d", mantissa_result);
        $display("Sign    = %b", sign_result);
        $display("Exponent= %d", exponent_result);


        // --------------------------------
        // TEST 4: Different signs
        // C > Product
        // --------------------------------

        sign_product    = 1'b1;
        sign_c          = 1'b0;

        aligned_product = 6'd10;
        aligned_c       = 6'd25;

        common_exponent = 6'd13;

        #10;

        $display("--------------------------------");
        $display("TEST 4: SUBTRACTION");
        $display("Product = %d", aligned_product);
        $display("C       = %d", aligned_c);
        $display("Result  = %d", mantissa_result);
        $display("Sign    = %b", sign_result);
        $display("Exponent= %d", exponent_result);


        #10;

        $finish;

    end

endmodule