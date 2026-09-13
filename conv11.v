module conv11 #(parameter BIT_WIDTH = 8, OUT_WIDTH = 32) (  //並行卷積需要兩個
    input clk, // Clock 
    input en,  // Enable 
    input rst_n, //reset
    input signed [BIT_WIDTH-1:0] in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, //36次
    input signed [BIT_WIDTH-1:0] w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12,             // 1x1 filter  //累加器72次
    input signed [BIT_WIDTH-1:0] bias,
    output reg signed[OUT_WIDTH-1:0] convValue // Output value       6*6 map                   
);

wire signed [2*BIT_WIDTH-1:0] product [0:11];
assign product[0]  = in1  * w1;
assign product[1]  = in2  * w2;
assign product[2]  = in3  * w3;
assign product[3]  = in4  * w4;
assign product[4]  = in5  * w5;
assign product[5]  = in6  * w6;
assign product[6]  = in7  * w7;
assign product[7]  = in8  * w8;
assign product[8]  = in9  * w9;
assign product[9]  = in10 * w10;
assign product[10] = in11 * w11;
assign product[11] = in12 * w12;

wire signed [OUT_WIDTH-1:0] bias_ext = {{(OUT_WIDTH-BIT_WIDTH){bias[BIT_WIDTH-1]}}, bias};
wire signed [OUT_WIDTH-1:0] product_ext [0:11];
genvar p;
generate
    for (p = 0; p < 12; p = p + 1) begin : g_product_extend
        assign product_ext[p] = {{(OUT_WIDTH-2*BIT_WIDTH){product[p][2*BIT_WIDTH-1]}}, product[p]};
    end
endgenerate

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        convValue <= 0;
    end
    else 
    if (en) begin
        convValue <= bias_ext + product_ext[0] + product_ext[1] + product_ext[2]
                   + product_ext[3] + product_ext[4] + product_ext[5]
                   + product_ext[6] + product_ext[7] + product_ext[8]
                   + product_ext[9] + product_ext[10] + product_ext[11];
        end
end

endmodule
