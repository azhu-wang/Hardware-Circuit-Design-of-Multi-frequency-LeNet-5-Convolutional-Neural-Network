module conv11 #(parameter BIT_WIDTH = 8, OUT_WIDTH = 32) (  //並行卷積需要兩個
    input clk, // Clock 
    input en,  // Enable 
    input rst_n, //reset
    input signed [BIT_WIDTH-1:0] in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, //36次
    input signed [BIT_WIDTH-1:0] w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12,             // 1x1 filter  //累加器72次
    input signed [BIT_WIDTH-1:0] bias,
    output reg signed[OUT_WIDTH-1:0] convValue // Output value       6*6 map                   
);

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        convValue <= 0;
    end
    else 
    if (en) begin
        convValue <= ((bias + (in1 * w1) + (in2 * w2)) + ((in3 * w3) + (in4 * w4))) + (((in5 * w5) + (in6 * w6)) + 
                    ((in7 * w7) + (in8 * w8))) + (((in9 * w9) + (in10 * w10)) + ((in11 * w11) + (in12 * w12))) ;
        end
end

endmodule