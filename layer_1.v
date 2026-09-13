module layer_1 (    //in:30*30 out:14*14*6
    input clk,
    input en,
    input rst_n,
    input load_weight,
    output reg start,
    output reg stall_out,
    output reg ready,
    output signed[7:0] out1, out2, out3, out4, out5, out6
);
parameter BIT_WIDTH_8 = 8;
// Nine signed 8x8 products plus an 8-bit bias fit in 19 signed bits.
// Keep one guard bit while avoiding 13 unused adder/register bits per filter.
parameter BIT_WIDTH_32 = 20;

reg signed[7:0] picture_data[0:899]; //圖片30*30*8
reg signed[7:0] in_data;

reg signed[7:0] weight_data_1[0:8];  //weight1 (3*3 weights + 1bias)*6 *8bits
reg signed[7:0] weight_data_2[0:8];
reg signed[7:0] weight_data_3[0:8];
reg signed[7:0] weight_data_4[0:8];
reg signed[7:0] weight_data_5[0:8];
reg signed[7:0] weight_data_6[0:8];
reg signed[7:0]bias[0:5];  //6

reg en_c1;  //控制c1
reg en_max2; //控制m2
reg en_bf_max;
reg en_bf_max_d;
reg en_max2_d;
reg en_max2_stall_d1;
reg en_max2_stall_d2;
wire [7:0]convIn[0:8];     //每個map輸入一致

/////////////////////////////////////////////////////////////////////////////// 圖片讀取ROM(30*30*10)
reg [13:0] addra_picture;
wire [7:0] douta_picture;
reg  ena_picture;

blk_mem_gen_picture bp1(
    .clka(clk),
    .ena(ena_picture),
    .addra(addra_picture),
    .douta(douta_picture) 
);

/////////////////////////////////////////////////////////////////////////////// 權重ROM (3*3*6+6)
reg [5:0] addra_c1;
wire [7:0] douta_c1;
reg  ena_c1;

blk_mem_gen_c1 bc1(
    .clka(clk),
    .ena(ena_c1),
    .addra(addra_c1),
    .douta(douta_c1) 
);

///////////////////////////////////////////////////////////////////////////////
//C1
input_buffer_1 i1(
    .clk(clk),
    .rst_n(rst_n),
    .in_data(in_data),
    .out1(convIn[0]), 
    .out2(convIn[1]), 
    .out3(convIn[2]), 
    .out4(convIn[3]), 
    .out5(convIn[4]), 
    .out6(convIn[5]), 
    .out7(convIn[6]), 
    .out8(convIn[7]), 
    .out9(convIn[8])
);
//
wire [BIT_WIDTH_32-1:0]convOut[0:5];
//16+log784=26bit 不會溢位
//cycle:28*28+1reset+1bias = 786 ,6 maps 
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32), .DSP_STYLE("yes"), .PIPELINED(1)) c1(
    .clk(clk), // Clock 
    .en(en_c1),  // Enable 
    .rst_n(rst_n),
    .in1(convIn[0]), 
    .in2(convIn[1]), 
    .in3(convIn[2]), 
    .in4(convIn[3]), 
    .in5(convIn[4]), 
    .in6(convIn[5]), 
    .in7(convIn[6]), 
    .in8(convIn[7]), 
    .in9(convIn[8]),
    .w1(weight_data_1[0]), 
    .w2(weight_data_1[1]), 
    .w3(weight_data_1[2]), 
    .w4(weight_data_1[3]), 
    .w5(weight_data_1[4]), 
    .w6(weight_data_1[5]), 
    .w7(weight_data_1[6]), 
    .w8(weight_data_1[7]), 
    .w9(weight_data_1[8]), // 3x3 filter
    .bias(bias[0]),       // Bias value
    .convValue(convOut[0]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32), .DSP_STYLE("yes"), .PIPELINED(1)) c2(
    .clk(clk), // Clock 
    .en(en_c1),  // Enable 
    .rst_n(rst_n),
    .in1(convIn[0]), 
    .in2(convIn[1]), 
    .in3(convIn[2]), 
    .in4(convIn[3]), 
    .in5(convIn[4]), 
    .in6(convIn[5]), 
    .in7(convIn[6]), 
    .in8(convIn[7]), 
    .in9(convIn[8]),
    .w1(weight_data_2[0]), 
    .w2(weight_data_2[1]), 
    .w3(weight_data_2[2]), 
    .w4(weight_data_2[3]), 
    .w5(weight_data_2[4]), 
    .w6(weight_data_2[5]), 
    .w7(weight_data_2[6]), 
    .w8(weight_data_2[7]), 
    .w9(weight_data_2[8]), // 3x3 filter
    .bias(bias[1]),       // Bias value
    .convValue(convOut[1]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32), .DSP_STYLE("yes"), .PIPELINED(1)) c3(
    .clk(clk), // Clock 
    .en(en_c1),  // Enable 
    .rst_n(rst_n),
    .in1(convIn[0]), 
    .in2(convIn[1]), 
    .in3(convIn[2]), 
    .in4(convIn[3]), 
    .in5(convIn[4]), 
    .in6(convIn[5]), 
    .in7(convIn[6]), 
    .in8(convIn[7]), 
    .in9(convIn[8]),
    .w1(weight_data_3[0]), 
    .w2(weight_data_3[1]), 
    .w3(weight_data_3[2]), 
    .w4(weight_data_3[3]), 
    .w5(weight_data_3[4]), 
    .w6(weight_data_3[5]), 
    .w7(weight_data_3[6]), 
    .w8(weight_data_3[7]), 
    .w9(weight_data_3[8]), // 3x3 filter
    .bias(bias[2]),       // Bias value
    .convValue(convOut[2]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32), .DSP_STYLE("yes"), .PIPELINED(1)) c4(
    .clk(clk), // Clock 
    .en(en_c1),  // Enable 
    .rst_n(rst_n),
    .in1(convIn[0]), 
    .in2(convIn[1]), 
    .in3(convIn[2]), 
    .in4(convIn[3]), 
    .in5(convIn[4]), 
    .in6(convIn[5]), 
    .in7(convIn[6]), 
    .in8(convIn[7]), 
    .in9(convIn[8]),
    .w1(weight_data_4[0]), 
    .w2(weight_data_4[1]), 
    .w3(weight_data_4[2]), 
    .w4(weight_data_4[3]), 
    .w5(weight_data_4[4]), 
    .w6(weight_data_4[5]), 
    .w7(weight_data_4[6]), 
    .w8(weight_data_4[7]), 
    .w9(weight_data_4[8]), // 3x3 filter
    .bias(bias[3]),       // Bias value
    .convValue(convOut[3]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32), .DSP_STYLE("yes"), .PIPELINED(1)) c5(
    .clk(clk), // Clock 
    .en(en_c1),  // Enable 
    .rst_n(rst_n),
    .in1(convIn[0]), 
    .in2(convIn[1]), 
    .in3(convIn[2]), 
    .in4(convIn[3]), 
    .in5(convIn[4]), 
    .in6(convIn[5]), 
    .in7(convIn[6]), 
    .in8(convIn[7]), 
    .in9(convIn[8]),
    .w1(weight_data_5[0]), 
    .w2(weight_data_5[1]), 
    .w3(weight_data_5[2]), 
    .w4(weight_data_5[3]), 
    .w5(weight_data_5[4]), 
    .w6(weight_data_5[5]), 
    .w7(weight_data_5[6]), 
    .w8(weight_data_5[7]), 
    .w9(weight_data_5[8]), // 3x3 filter
    .bias(bias[4]),       // Bias value
    .convValue(convOut[4]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32), .DSP_STYLE("yes"), .PIPELINED(1)) c6(
    .clk(clk), // Clock 
    .en(en_c1),  // Enable 
    .rst_n(rst_n),
    .in1(convIn[0]), 
    .in2(convIn[1]), 
    .in3(convIn[2]), 
    .in4(convIn[3]), 
    .in5(convIn[4]), 
    .in6(convIn[5]), 
    .in7(convIn[6]), 
    .in8(convIn[7]), 
    .in9(convIn[8]),
    .w1(weight_data_6[0]), 
    .w2(weight_data_6[1]), 
    .w3(weight_data_6[2]), 
    .w4(weight_data_6[3]), 
    .w5(weight_data_6[4]), 
    .w6(weight_data_6[5]), 
    .w7(weight_data_6[6]), 
    .w8(weight_data_6[7]), 
    .w9(weight_data_6[8]), // 3x3 filter
    .bias(bias[5]),       // Bias value
    .convValue(convOut[5]) // Output value
);

wire [7:0] reluOut [0:5];  
//input:32bits , output:8bits
ReLU #(.BIT_WIDTH(BIT_WIDTH_32), .SHIFT(11)) r1(
	.in(convOut[0]),
	.out(reluOut[0])
);
ReLU #(.BIT_WIDTH(BIT_WIDTH_32), .SHIFT(11)) r2(
	.in(convOut[1]),
	.out(reluOut[1])
);
ReLU #(.BIT_WIDTH(BIT_WIDTH_32), .SHIFT(11)) r3(
	.in(convOut[2]),
	.out(reluOut[2])
);
ReLU #(.BIT_WIDTH(BIT_WIDTH_32), .SHIFT(11)) r4(
	.in(convOut[3]),
	.out(reluOut[3])
);
ReLU #(.BIT_WIDTH(BIT_WIDTH_32), .SHIFT(11)) r5(
	.in(convOut[4]),
	.out(reluOut[4])
);
ReLU #(.BIT_WIDTH(BIT_WIDTH_32), .SHIFT(11)) r6(
	.in(convOut[5]),
	.out(reluOut[5])
);

wire [7:0] maxPoolingIn1 [0:3];
wire [7:0] maxPoolingIn2 [0:3];
wire [7:0] maxPoolingIn3 [0:3];
wire [7:0] maxPoolingIn4 [0:3];
wire [7:0] maxPoolingIn5 [0:3];
wire [7:0] maxPoolingIn6 [0:3];
//maxpooling
Pooling_buffer_1 p1(
    .clk(clk),
    .en(en_bf_max_d),
    .rst_n(rst_n),
    .in_data(reluOut[0]),
    .out1(maxPoolingIn1[0]), 
    .out2(maxPoolingIn1[1]), 
    .out3(maxPoolingIn1[2]), 
    .out4(maxPoolingIn1[3])
);
Pooling_buffer_1 p2(
    .clk(clk),
    .en(en_bf_max_d),
    .rst_n(rst_n),
    .in_data(reluOut[1]),
    .out1(maxPoolingIn2[0]), 
    .out2(maxPoolingIn2[1]), 
    .out3(maxPoolingIn2[2]), 
    .out4(maxPoolingIn2[3])
);
Pooling_buffer_1 p3(
    .clk(clk),
    .en(en_bf_max_d),
    .rst_n(rst_n),
    .in_data(reluOut[2]),
    .out1(maxPoolingIn3[0]), 
    .out2(maxPoolingIn3[1]), 
    .out3(maxPoolingIn3[2]), 
    .out4(maxPoolingIn3[3])
);
Pooling_buffer_1 p4(
    .clk(clk),
    .en(en_bf_max_d),
    .rst_n(rst_n),
    .in_data(reluOut[3]),
    .out1(maxPoolingIn4[0]), 
    .out2(maxPoolingIn4[1]), 
    .out3(maxPoolingIn4[2]), 
    .out4(maxPoolingIn4[3])
);
Pooling_buffer_1 p5(
    .clk(clk),
    .en(en_bf_max_d),
    .rst_n(rst_n),
    .in_data(reluOut[4]),
    .out1(maxPoolingIn5[0]), 
    .out2(maxPoolingIn5[1]), 
    .out3(maxPoolingIn5[2]), 
    .out4(maxPoolingIn5[3])
);
Pooling_buffer_1 p6(
    .clk(clk),
    .en(en_bf_max_d),
    .rst_n(rst_n),
    .in_data(reluOut[5]),
    .out1(maxPoolingIn6[0]), 
    .out2(maxPoolingIn6[1]), 
    .out3(maxPoolingIn6[2]), 
    .out4(maxPoolingIn6[3])
);

//out:14*14*6
maxpooling #(.BIT_WIDTH(BIT_WIDTH_8))m1(
	.clk(clk),
	.en(en_max2_d),
	.rst_n(rst_n),
	.in1(maxPoolingIn1[0]), 
    .in2(maxPoolingIn1[1]), 
    .in3(maxPoolingIn1[2]), 
    .in4(maxPoolingIn1[3]),
	.max(out1)
);
maxpooling #(.BIT_WIDTH(BIT_WIDTH_8))m2(
	.clk(clk),
	.en(en_max2_d),
	.rst_n(rst_n),
	.in1(maxPoolingIn2[0]), 
    .in2(maxPoolingIn2[1]), 
    .in3(maxPoolingIn2[2]), 
    .in4(maxPoolingIn2[3]),
	.max(out2)
);
maxpooling #(.BIT_WIDTH(BIT_WIDTH_8))m3(
	.clk(clk),
	.en(en_max2_d),
	.rst_n(rst_n),
	.in1(maxPoolingIn3[0]), 
    .in2(maxPoolingIn3[1]), 
    .in3(maxPoolingIn3[2]), 
    .in4(maxPoolingIn3[3]),
	.max(out3)
);
maxpooling #(.BIT_WIDTH(BIT_WIDTH_8))m4(
	.clk(clk),
	.en(en_max2_d),
	.rst_n(rst_n),
	.in1(maxPoolingIn4[0]), 
    .in2(maxPoolingIn4[1]), 
    .in3(maxPoolingIn4[2]), 
    .in4(maxPoolingIn4[3]),
	.max(out4)
);
maxpooling #(.BIT_WIDTH(BIT_WIDTH_8))m5(
	.clk(clk),
	.en(en_max2_d),
	.rst_n(rst_n),
	.in1(maxPoolingIn5[0]), 
    .in2(maxPoolingIn5[1]), 
    .in3(maxPoolingIn5[2]), 
    .in4(maxPoolingIn5[3]),
	.max(out5)
);
maxpooling #(.BIT_WIDTH(BIT_WIDTH_8))m6(
	.clk(clk),
	.en(en_max2_d),
	.rst_n(rst_n),
	.in1(maxPoolingIn6[0]), 
    .in2(maxPoolingIn6[1]), 
    .in3(maxPoolingIn6[2]), 
    .in4(maxPoolingIn6[3]),
	.max(out6)
);
////////////////////////////////////load_weight///////////////////////
//reg [13:0] addra_picture;
//reg [7:0] douta_picture;
//reg [5:0] addra_c1;
//reg [7:0] douta_c1;
integer j, k;
integer load_reset_index;
reg [13:0] offset;
reg [13:0] i;
reg [2:0] load_group;
reg [3:0] load_offset;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (load_reset_index = 0; load_reset_index < 900; load_reset_index = load_reset_index + 1) begin
            picture_data[load_reset_index] <= 0;
        end
        for (load_reset_index = 0; load_reset_index < 9; load_reset_index = load_reset_index + 1) begin
            weight_data_1[load_reset_index] <= 0;
            weight_data_2[load_reset_index] <= 0;
            weight_data_3[load_reset_index] <= 0;
            weight_data_4[load_reset_index] <= 0;
            weight_data_5[load_reset_index] <= 0;
            weight_data_6[load_reset_index] <= 0;
        end
        for (load_reset_index = 0; load_reset_index < 6; load_reset_index = load_reset_index + 1) begin
            bias[load_reset_index] <= 0;
        end
        // Reset must produce deterministic hardware state. Selecting another
        // image by inspecting a register while it is being reset is undefined.
        offset <= 0;

        ena_picture <= 0;
        ena_c1 <= 0;
        addra_picture <= 0;
        addra_c1 <= 0;
        load_group <= 0;
        load_offset <= 0;
        i <= 0;

    end else if (load_weight)begin    //60 cycle LOAD
        ena_picture <= (i < 900);
        ena_c1 <= (i < 60);
        if (i < 900) addra_picture <= i + offset;
        if (i < 60) addra_c1 <= i;
        if((i < 903) && (i > 2))begin
            picture_data[i-3] <= douta_picture;
        end
        if((i < 63) && (i > 2))begin
            if (load_offset == 9) begin
                bias[load_group] <= douta_c1;
                load_offset <= 0;
                load_group <= load_group + 1;
            end else begin
                case (load_group)
                    3'd0: weight_data_1[load_offset] <= douta_c1;
                    3'd1: weight_data_2[load_offset] <= douta_c1;
                    3'd2: weight_data_3[load_offset] <= douta_c1;
                    3'd3: weight_data_4[load_offset] <= douta_c1;
                    3'd4: weight_data_5[load_offset] <= douta_c1;
                    3'd5: weight_data_6[load_offset] <= douta_c1;
                    default: ;
                endcase
                load_offset <= load_offset + 1;
            end
        end
        i <= i + 1;
    end else begin
        ena_picture <= 0;
        ena_c1 <= 0;
    end
end
//inputBuffer: (30 + 30 + 3)cycle 開始送資料 1個cycle送一筆
//conv33: 28*28 + 1bias (+1reset) = 785+1cycle
//maxBuffer: (28 + 2)cycle 開始送資料 2個cycle送一筆  //63+1+1+30=95
//maxpooling: 14*14 = 196

reg [5:0] cycle_counter;
reg stall;

always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // 初始化
            en_c1 <= 0;
            en_bf_max <= 0;
            j <= 0;
            cycle_counter <= 0;
            stall <= 0;
            in_data <= 0;

        end else if (en) begin
            if (j < 902 ) begin        
                if( j < 900 && !start)in_data <= picture_data[j];        
                if (j > 62) begin
                    if (stall) begin
                        cycle_counter <= cycle_counter + 1;
                        if (cycle_counter == 1) begin
                            stall <= 0;
                            cycle_counter <= 0;
                        end
                    end else begin
                        if (cycle_counter == 27) begin
                            stall <= 1;
                            cycle_counter <= 0;
                        end else begin
                            cycle_counter <= cycle_counter + 1;
                        end
                    end

                    if (!stall) begin
                        if(en_c1) en_bf_max <= 1;
                        en_c1 <= 1; // c1 每12個週期 stall 2週期

                    end else begin
                        if(!en_c1) en_bf_max <= 0;
                        en_c1 <= 0;
                
                    end
                end
                j = j + 1;
            end else begin
                if(!en_c1) en_bf_max <= 0;
                en_c1 <= 0;
            end
        end
    end

reg [5:0] en_max2_counter;
reg en_max2_stall;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
    begin
        en_bf_max_d <= 0;
        en_max2_d <= 0;
        en_max2_stall_d1 <= 0;
        en_max2_stall_d2 <= 0;
    end else begin
        en_bf_max_d <= en_bf_max;
        en_max2_d <= en_max2;
        en_max2_stall_d1 <= en_max2_stall;
        en_max2_stall_d2 <= en_max2_stall_d1;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        en_max2 <= 0;
        en_max2_counter <= 0;
        en_max2_stall <= 0;
        ready <= 0;
        start <= 0;
        k <= 0;
    end else begin
    if (en) begin
        if(k > 905)begin
            start <= 1;           //stall 14+2
        end
        if (k > 95 && !start) begin
            if (en_max2_stall) begin
                en_max2_counter <= en_max2_counter + 1;
                if (en_max2_counter == 31) begin //27+4
                    en_max2_stall <= 0;
                    en_max2_counter <= 0;
                end
            end else begin
                if (en_max2_counter == 27) begin
                    en_max2_stall <= 1;
                    en_max2_counter <= 0;
                end else begin
                    en_max2_counter <= en_max2_counter + 1;
                end
            end

            if (!en_max2_stall) begin
                en_max2 = ~en_max2; // 準備 max2 的下一個週期
                if(en_max2_d)begin
                    ready = 1;
                end
            end
        end else if (!en_c1) begin
            en_max2 <= 0; // 延遲
        end 
        k = k + 1;
    end
    stall_out <= en_max2_stall_d2;
    end
end

endmodule
