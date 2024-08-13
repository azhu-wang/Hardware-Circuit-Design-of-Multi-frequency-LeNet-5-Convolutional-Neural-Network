module ReLU #(parameter BIT_WIDTH = 32)(
	input [BIT_WIDTH-1:0] in,
	output [7:0] out
);

// check MSB = 1 
assign out = (in[BIT_WIDTH-1]) ? 0 : (in > 65536 ) ? 8'b0111_1111:{1'b0,in[16:10]} ;

endmodule
