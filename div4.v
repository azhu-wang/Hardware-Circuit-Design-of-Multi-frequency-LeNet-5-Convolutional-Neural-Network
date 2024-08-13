module div4  (
	input clk,
	input rst_n,
	output reg o_clk
);

reg [1:0] cnt;

always@(posedge clk or negedge rst_n) begin
	if (!rst_n)
		cnt <= 0;
	else if (cnt == 3) // 0 ~ 3
		cnt <= 0;
	else
		cnt <= cnt + 1;
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n)
		o_clk <= 0;
	else if (cnt < 2) // 0 ~ 1
		 o_clk = 0;
	else              // 2 ~ 3
		o_clk = 1;   
end

endmodule