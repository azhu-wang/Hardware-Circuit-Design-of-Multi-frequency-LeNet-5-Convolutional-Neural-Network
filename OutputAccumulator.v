module OutputAccumulator #(parameter BIT_WIDTH = 32, OUT_WIDTH = 32) (
    input clk, // Clock 
    input en,  // Enable 
    input rst_n,
    input signed [BIT_WIDTH-1:0] in1, in2, in3, in4, in5, in6,
    input signed [7:0] bias,
    output reg  [OUT_WIDTH-1:0] AccumulatorValue // Output value
);

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        AccumulatorValue <= 0;
    end
    else 
    if (en) begin
        AccumulatorValue <= (in1 + in2) + (in3 + in4) + (in5 + in6) + bias;
    end
end

endmodule
