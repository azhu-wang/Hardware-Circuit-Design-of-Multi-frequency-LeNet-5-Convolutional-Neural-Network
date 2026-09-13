module div4 #(
	parameter [1:0] RESET_COUNT = 2'd0
) (
	input clk,
	input rst_n,
	output reg o_clk
);

// One-cycle clock-enable pulse every four master-clock cycles.
// o_clk is retained as the port name for source compatibility; it is not a clock.
reg [1:0] cnt;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt   <= RESET_COUNT;
        o_clk <= 1'b0;
    end else begin
        o_clk <= (cnt == 2'd3);
        cnt   <= cnt + 2'd1;
    end
end

endmodule
