module ReLU #(
    parameter BIT_WIDTH = 32,
    parameter SHIFT = 7
)(
	input signed [BIT_WIDTH-1:0] in,
	output signed [7:0] out
);

localparam signed [BIT_WIDTH-1:0] SATURATION = 127 <<< SHIFT;
localparam signed [BIT_WIDTH-1:0] ROUNDING = 1 <<< (SHIFT-1);
wire signed [BIT_WIDTH-1:0] rounded = in + ROUNDING;
wire signed [BIT_WIDTH-1:0] shifted = rounded >>> SHIFT;

assign out = (in <= 0) ? 8'sd0 :
             (rounded >= SATURATION) ? 8'sd127 : shifted[7:0];

endmodule
