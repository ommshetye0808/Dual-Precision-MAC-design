`timescale 1ns / 1ps

module s3_accumulator (

    input  wire        clk,
    input  wire        rst,

    input  wire        sign_product,
    input  wire        sign_c,

    input  wire [5:0]  aligned_product,
    input  wire [5:0]  aligned_c,

    input  wire [5:0]  common_exponent,

    output reg         sign_result,
    output reg [12:0]  mantissa_result,
    output reg [5:0]   exponent_result

);

reg [6:0] sum;
reg [6:0] carry;
reg [6:0] final_sum;

always @(posedge clk) begin

    if (rst) begin

        sign_result     <= 1'b0;
        mantissa_result <= 13'b0;
        exponent_result <= 6'b0;

    end

    else begin

        exponent_result <= common_exponent;

        // Same signs → addition
        if (sign_product == sign_c) begin

            sign_result <= sign_product;

            // Carry Save representation
            sum   = aligned_product ^ aligned_c;
            carry = (aligned_product & aligned_c) << 1;

            // Final addition
            final_sum = sum + carry;

            mantissa_result <= final_sum;

        end

        // Different signs → subtraction
        else begin

            if (aligned_product >= aligned_c) begin

                sign_result <= sign_product;
                mantissa_result <= aligned_product - aligned_c;

            end

            else begin

                sign_result <= sign_c;
                mantissa_result <= aligned_c - aligned_product;

            end

        end

    end

end

endmodule