module input_buffer_2 (
    input  clk,
    input  rst_n,
    input en,
    input  [7:0] in_data,
    output [7:0] out1, out2, out3, out4, out5, out6, out7, out8, out9
);
    parameter KERNEL_SIZE = 3;
    parameter FEATURE_MAP_SIZE = 31;
    
    reg [7:0] buffer [0:FEATURE_MAP_SIZE-1]; // 31個 8 位寄存器 14+14+3
    
    integer i;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < FEATURE_MAP_SIZE; i = i + 1) begin
                buffer[i] <= 8'd0;
            end
        end else if(en) begin
            // 向下移位
            for (i = FEATURE_MAP_SIZE-1; i > 0; i = i - 1) begin
                buffer[i] <= buffer[i-1];
            end
            // 輸入
            buffer[0] <= in_data;
        end
    end

    // 輸出
    assign out9 = buffer[0];
    assign out8 = buffer[1];
    assign out7 = buffer[2];
    assign out6 = buffer[14];
    assign out5 = buffer[15];
    assign out4 = buffer[16];
    assign out3 = buffer[28];
    assign out2 = buffer[29];
    assign out1 = buffer[30];

endmodule