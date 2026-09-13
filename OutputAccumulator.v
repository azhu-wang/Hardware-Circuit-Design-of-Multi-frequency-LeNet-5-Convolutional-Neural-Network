module OutputAccumulator #(parameter BIT_WIDTH = 32, OUT_WIDTH = 32) (
    input clk, // Clock 
    input en,  // Enable 
    input rst_n,
    input signed [BIT_WIDTH-1:0] in1, in2, in3, in4, in5, in6,
    input signed [7:0] bias,
    output reg signed [OUT_WIDTH-1:0] AccumulatorValue // Output value
);

wire signed [OUT_WIDTH-1:0] in_ext [0:5];
assign in_ext[0] = {{(OUT_WIDTH-BIT_WIDTH){in1[BIT_WIDTH-1]}}, in1};
assign in_ext[1] = {{(OUT_WIDTH-BIT_WIDTH){in2[BIT_WIDTH-1]}}, in2};
assign in_ext[2] = {{(OUT_WIDTH-BIT_WIDTH){in3[BIT_WIDTH-1]}}, in3};
assign in_ext[3] = {{(OUT_WIDTH-BIT_WIDTH){in4[BIT_WIDTH-1]}}, in4};
assign in_ext[4] = {{(OUT_WIDTH-BIT_WIDTH){in5[BIT_WIDTH-1]}}, in5};
assign in_ext[5] = {{(OUT_WIDTH-BIT_WIDTH){in6[BIT_WIDTH-1]}}, in6};
wire signed [OUT_WIDTH-1:0] bias_ext = {{(OUT_WIDTH-8){bias[7]}}, bias};

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        AccumulatorValue <= 0;
    end
    else 
    if (en) begin
        AccumulatorValue <= in_ext[0] + in_ext[1] + in_ext[2]
                          + in_ext[3] + in_ext[4] + in_ext[5] + bias_ext;
    end
end

endmodule
