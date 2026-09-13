module div2 (
	input      clk,
	input      rst_n,
	output reg o_clk
 );

// One-cycle clock-enable pulse every two master-clock cycles.
// o_clk is retained as the port name for source compatibility; it is not a clock.
reg cnt;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt   <= 1'b0;
        o_clk <= 1'b0;
    end else begin
        o_clk <= cnt;
        cnt   <= ~cnt;
    end
end

endmodule
