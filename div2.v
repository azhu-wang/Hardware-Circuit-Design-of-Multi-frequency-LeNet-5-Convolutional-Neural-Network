module div2 (
	input      clk,
	input      rst_n,
	output reg o_clk
 );
 
reg cnt;
 
always@(posedge clk or negedge rst_n) begin
	if (!rst_n)
	    cnt <= 0;
	else if (cnt == 1) // 0 ~ 1
		cnt <= 0;
	else
		cnt <= cnt + 1;
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n)
 		o_clk <= 0;
	else if (cnt < 1) // 0
		o_clk = 0;
	else              // 1
		o_clk = 1;
end

endmodule