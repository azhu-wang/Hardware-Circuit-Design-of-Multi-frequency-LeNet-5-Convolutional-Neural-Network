module fully_connected #(parameter BIT_WIDTH = 8, OUT_WIDTH = 32) (
    input clk, // Clock 
    input en,  // Enable 
    input rst_n,
    input signed[BIT_WIDTH-1:0] in1,
    input signed[BIT_WIDTH-1:0] in2,
    input signed[BIT_WIDTH-1:0] weight1, 
    input signed[BIT_WIDTH-1:0] weight2,
    input signed[BIT_WIDTH-1:0] bias,   // Bias value
    output reg ready,
    output reg  signed[OUT_WIDTH-1:0] Value // Output value
);

reg [6:0]reg_count; 

always @(posedge clk or negedge rst_n) begin  //1+36
    if(!rst_n)begin
        reg_count <= 0;
        ready <= 0;
        Value <= 0;
    end
    else 
    if (en && !ready) begin
        if (reg_count == 35)begin
            Value <= Value + bias;
            ready <= 1;
            reg_count <= 0;
        end
        else begin
            Value <= Value + in1 * weight1 + in2 * weight2;
            reg_count <= reg_count + 1;
        end
end

end
endmodule
