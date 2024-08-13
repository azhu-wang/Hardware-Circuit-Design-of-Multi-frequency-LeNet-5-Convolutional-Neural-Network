module maxpooling #(parameter BIT_WIDTH = 8)(
	input clk,
	input en,
	input rst_n,
	input signed[BIT_WIDTH-1:0] in1, in2, in3, in4,
	output reg signed[BIT_WIDTH-1:0] max
);

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		max <= 0;
	end
	else begin
		if(en)begin
			if (in1 >= in2 && in1 >= in3 && in1 >= in4) begin
        		max <= in1;
    		end else if (in2 >= in1 && in2 >= in3 && in2 >= in4) begin
        		max <= in2;
    		end else if (in3 >= in1 && in3 >= in2 && in3 >= in4) begin
        		max <= in3;
    		end else begin
        		max <= in4;
    		end
		end
	end
end
endmodule