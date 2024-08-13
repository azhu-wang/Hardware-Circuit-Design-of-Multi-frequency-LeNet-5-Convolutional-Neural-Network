module conv33 #(parameter BIT_WIDTH = 8, OUT_WIDTH = 32) (
    input clk, // Clock 
    input en,  // Enable 
    input rst_n, //reset
    input signed[BIT_WIDTH-1:0] in1, in2, in3, in4, in5, in6, in7, in8, in9,
    input signed[BIT_WIDTH-1:0] w1, w2, w3, w4, w5, w6, w7, w8, w9, // 3x3 filter
    input signed[BIT_WIDTH-1:0] bias,       // Bias value
    output reg signed[OUT_WIDTH-1:0] convValue // Output value
);

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        convValue <= 0;
    end
    else 
    if (en) begin
        convValue <= ((( bias + in1 * w1) + (in2 * w2 + in3 * w3)) + 
                    ((in4 * w4 + in5 * w5) + (in6 * w6 + in7 * w7)) + 
                    (in8 * w8 + in9 * w9)) ;
        end
end

endmodule
