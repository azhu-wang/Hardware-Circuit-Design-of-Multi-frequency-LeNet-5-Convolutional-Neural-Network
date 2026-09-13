module conv33 #(
    parameter BIT_WIDTH = 8,
    parameter OUT_WIDTH = 32,
    parameter DSP_STYLE = "auto",
    parameter PIPELINED = 0
) (
    input clk, // Clock 
    input en,  // Enable 
    input rst_n, //reset
    input signed[BIT_WIDTH-1:0] in1, in2, in3, in4, in5, in6, in7, in8, in9,
    input signed[BIT_WIDTH-1:0] w1, w2, w3, w4, w5, w6, w7, w8, w9, // 3x3 filter
    input signed[BIT_WIDTH-1:0] bias,       // Bias value
    output reg signed[OUT_WIDTH-1:0] convValue // Output value
);

(* use_dsp = DSP_STYLE *) wire signed [2*BIT_WIDTH-1:0] raw_product [0:8];
wire signed [2*BIT_WIDTH-1:0] product [0:8];
assign raw_product[0] = in1 * w1;
assign raw_product[1] = in2 * w2;
assign raw_product[2] = in3 * w3;
assign raw_product[3] = in4 * w4;
assign raw_product[4] = in5 * w5;
assign raw_product[5] = in6 * w6;
assign raw_product[6] = in7 * w7;
assign raw_product[7] = in8 * w8;
assign raw_product[8] = in9 * w9;

wire signed [OUT_WIDTH-1:0] bias_ext = {{(OUT_WIDTH-BIT_WIDTH){bias[BIT_WIDTH-1]}}, bias};
wire signed [OUT_WIDTH-1:0] product_ext [0:8];
genvar p;
generate
    for (p = 0; p < 9; p = p + 1) begin : g_product_extend
        assign product_ext[p] = {{(OUT_WIDTH-2*BIT_WIDTH){product[p][2*BIT_WIDTH-1]}}, product[p]};
    end
endgenerate

// Keep the nine-product reduction balanced.  The former left-associated
// expression could place several LUT/carry adders after a LUT multiplier,
// which was the first-layer 100 MHz critical path.
wire signed [OUT_WIDTH-1:0] sum_01 = product_ext[0] + product_ext[1];
wire signed [OUT_WIDTH-1:0] sum_23 = product_ext[2] + product_ext[3];
wire signed [OUT_WIDTH-1:0] sum_45 = product_ext[4] + product_ext[5];
wire signed [OUT_WIDTH-1:0] sum_67 = product_ext[6] + product_ext[7];
wire signed [OUT_WIDTH-1:0] sum_8b = product_ext[8] + bias_ext;
wire signed [OUT_WIDTH-1:0] sum_0123 = sum_01 + sum_23;
wire signed [OUT_WIDTH-1:0] sum_4567 = sum_45 + sum_67;
wire signed [OUT_WIDTH-1:0] sum_0_7 = sum_0123 + sum_4567;
wire signed [OUT_WIDTH-1:0] dot_product = sum_0_7 + sum_8b;

generate
    if (PIPELINED != 0) begin : g_pipelined
        reg signed [2*BIT_WIDTH-1:0] product_q [0:8];
        reg en_q;
        integer q;

        for (p = 0; p < 9; p = p + 1) begin : g_product_q_output
            assign product[p] = product_q[p];
        end

        // A synchronous reset lets Vivado use the DSP48 output register.
        always @(posedge clk) begin
            if (!rst_n) begin
                en_q <= 1'b0;
                for (q = 0; q < 9; q = q + 1)
                    product_q[q] <= 0;
            end else begin
                en_q <= en;
                if (en) begin
                    for (q = 0; q < 9; q = q + 1)
                        product_q[q] <= raw_product[q];
                end
            end
        end

        always @(posedge clk or negedge rst_n) begin
            if (!rst_n)
                convValue <= 0;
            else if (en_q)
                convValue <= dot_product;
        end
    end else begin : g_unpipelined
        for (p = 0; p < 9; p = p + 1) begin : g_product_direct
            assign product[p] = raw_product[p];
        end

        always @(posedge clk or negedge rst_n) begin
            if (!rst_n)
                convValue <= 0;
            else if (en)
                convValue <= dot_product;
        end
    end
endgenerate

endmodule
