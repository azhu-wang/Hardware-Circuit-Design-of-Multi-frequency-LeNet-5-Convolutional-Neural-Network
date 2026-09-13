module layer_3 (    //in:6*6*12 out:10
    input clk,
    input en,
    input rst_n,
    input load_weight,
    input signed [7:0]map1,map2,map3,map4,map5,map6,map7,map8,map9,map10,map11,map12,
    output ready,
    output signed [31:0] out1, out2, out3, out4, out5, out6, out7, out8, out9, out10
);
parameter BIT_WIDTH = 8;
parameter BIT_WIDTH_32 = 32;

reg signed[7:0] weight_data_1[0:11];  //weight 12x2=24
reg signed[7:0] weight_data_2[0:11];
reg signed[7:0]bias[0:1];  //2
                                        //weight 36*2*10 //需要更新
reg signed[7:0] weight_data_fc1[0:9];
reg signed[7:0] weight_data_fc2[0:9];

reg signed[7:0] weight_data_fc1_all[0:359];  //總權重
reg signed[7:0] weight_data_fc2_all[0:359];
reg signed[7:0]bias_fc[0:9];  //10

wire ce_4;

// The layer-1 DSP pipeline shifts the layer-2 pooled outputs by two master
// cycles.  Keep the quarter-rate enable on the same edge as those outputs so
// layer 3 observes the same sample sequence as the unpipelined design.
div4 #(.RESET_COUNT(2'd2)) d1(
	.clk(clk),
	.rst_n(rst_n),
	.o_clk(ce_4)
);
////////////////////////////////////////////////////Load Data ///////////////////////////////////////////
reg [4:0] addra_c3;
wire [7:0] douta_c3;
reg  ena_c3;
blk_mem_gen_c3 bc3(
    .clka(clk),
    .ena(ena_c3),
    .addra(addra_c3),
    .douta(douta_c3)
);

reg [9:0] addra_fc;
wire [7:0] douta_fc;
reg  ena_fc;
blk_mem_gen_fc bfc(
    .clka(clk),
    .ena(ena_fc),
    .addra(addra_fc),
    .douta(douta_fc)
);
////////////////////////////////////////////////////////////////////////////////////////////////////////
reg en_c1;  //控制c
reg en_fc;
reg signed [7:0] map_q [0:11];
wire [31:0]convOut[0:1];     //每個map輸入一致
//C1   2層
///////////////////////////////////////////////////////////////////////////////////////////////////////////
conv11 #(.BIT_WIDTH(BIT_WIDTH), .OUT_WIDTH(BIT_WIDTH_32)) c1(  //並行卷積需要兩個
    .clk(clk), // Clock
    .en(en_c1 && ce_4),  // Enable
    .rst_n(rst_n), //reset
    .in1(map_q[0]),
    .in2(map_q[1]),
    .in3(map_q[2]),
    .in4(map_q[3]),
    .in5(map_q[4]),
    .in6(map_q[5]),
    .in7(map_q[6]),
    .in8(map_q[7]),
    .in9(map_q[8]),
    .in10(map_q[9]),
    .in11(map_q[10]),
    .in12(map_q[11]), //36次
    .w1(weight_data_1[0]),
    .w2(weight_data_1[1]),
    .w3(weight_data_1[2]),
    .w4(weight_data_1[3]),
    .w5(weight_data_1[4]),
    .w6(weight_data_1[5]),
    .w7(weight_data_1[6]),
    .w8(weight_data_1[7]),
    .w9(weight_data_1[8]),
    .w10(weight_data_1[9]),
    .w11(weight_data_1[10]),
    .w12(weight_data_1[11]),             // 1x1 filter  //累加器72次
    .bias(bias[0]),
    .convValue(convOut[0]) // Output value       6*6 map
);
conv11 #(.BIT_WIDTH(BIT_WIDTH), .OUT_WIDTH(BIT_WIDTH_32)) c2(
    .clk(clk), // Clock
    .en(en_c1 && ce_4),  // Enable
    .rst_n(rst_n), //reset
    .in1(map_q[0]),
    .in2(map_q[1]),
    .in3(map_q[2]),
    .in4(map_q[3]),
    .in5(map_q[4]),
    .in6(map_q[5]),
    .in7(map_q[6]),
    .in8(map_q[7]),
    .in9(map_q[8]),
    .in10(map_q[9]),
    .in11(map_q[10]),
    .in12(map_q[11]), //36次
    .w1(weight_data_2[0]),
    .w2(weight_data_2[1]),
    .w3(weight_data_2[2]),
    .w4(weight_data_2[3]),
    .w5(weight_data_2[4]),
    .w6(weight_data_2[5]),
    .w7(weight_data_2[6]),
    .w8(weight_data_2[7]),
    .w9(weight_data_2[8]),
    .w10(weight_data_2[9]),
    .w11(weight_data_2[10]),
    .w12(weight_data_2[11]),             // 1x1 filter  //累加器72次
    .bias(bias[1]),
    .convValue(convOut[1]) // Output value       6*6 map
);
///////////////////////////////////////////ReLU////////////////////////////////////////////////////////////
wire [7:0] reluOut [0:1];
//input:32bits , output:8bits
ReLU #(.BIT_WIDTH(BIT_WIDTH_32), .SHIFT(7)) r1(
	.in(convOut[0]),
	.out(reluOut[0])
);
ReLU #(.BIT_WIDTH(BIT_WIDTH_32), .SHIFT(7)) r2(
	.in(convOut[1]),
	.out(reluOut[1])
);
//////////////////////////////////////////////FC////////////////////////////////////////////////////////////
//input:8bits , output:32bits
fully_connected #(.BIT_WIDTH(8),.OUT_WIDTH(32)) fc1(
    .clk(clk), // Clock
    .en(en_fc && ce_4),  // Enable
    .rst_n(rst_n),
    .in1(reluOut[0]),
    .in2(reluOut[1]),
    .weight1(weight_data_fc1[0]),
    .weight2(weight_data_fc2[0]),
    .bias(bias_fc[0]),   // Bias value
    .ready(ready),
    .Value(out1) // Output value
);
fully_connected #(.BIT_WIDTH(8),.OUT_WIDTH(32)) fc2(
    .clk(clk), // Clock
    .en(en_fc && ce_4),  // Enable
    .rst_n(rst_n),
    .in1(reluOut[0]),
    .in2(reluOut[1]),
    .weight1(weight_data_fc1[1]),
    .weight2(weight_data_fc2[1]),
    .bias(bias_fc[1]),   // Bias value
    .ready(),
    .Value(out2) // Output value
);
fully_connected #(.BIT_WIDTH(8),.OUT_WIDTH(32)) fc3(
    .clk(clk), // Clock
    .en(en_fc && ce_4),  // Enable
    .rst_n(rst_n),
    .in1(reluOut[0]),
    .in2(reluOut[1]),
    .weight1(weight_data_fc1[2]),
    .weight2(weight_data_fc2[2]),
    .bias(bias_fc[2]),   // Bias value
    .ready(),
    .Value(out3) // Output value
);
fully_connected #(.BIT_WIDTH(8),.OUT_WIDTH(32)) fc4(
    .clk(clk), // Clock
    .en(en_fc && ce_4),  // Enable
    .rst_n(rst_n),
    .in1(reluOut[0]),
    .in2(reluOut[1]),
    .weight1(weight_data_fc1[3]),
    .weight2(weight_data_fc2[3]),
    .bias(bias_fc[3]),   // Bias value
    .ready(),
    .Value(out4) // Output value
);
fully_connected #(.BIT_WIDTH(8),.OUT_WIDTH(32)) fc5(
    .clk(clk), // Clock
    .en(en_fc && ce_4),  // Enable
    .rst_n(rst_n),
    .in1(reluOut[0]),
    .in2(reluOut[1]),
    .weight1(weight_data_fc1[4]),
    .weight2(weight_data_fc2[4]),
    .bias(bias_fc[4]),   // Bias value
    .ready(),
    .Value(out5) // Output value
);
fully_connected #(.BIT_WIDTH(8),.OUT_WIDTH(32)) fc6(
    .clk(clk), // Clock
    .en(en_fc && ce_4),  // Enable
    .rst_n(rst_n),
    .in1(reluOut[0]),
    .in2(reluOut[1]),
    .weight1(weight_data_fc1[5]),
    .weight2(weight_data_fc2[5]),
    .bias(bias_fc[5]),   // Bias value
    .ready(),
    .Value(out6) // Output value
);
fully_connected #(.BIT_WIDTH(8),.OUT_WIDTH(32)) fc7(
    .clk(clk), // Clock
    .en(en_fc && ce_4),  // Enable
    .rst_n(rst_n),
    .in1(reluOut[0]),
    .in2(reluOut[1]),
    .weight1(weight_data_fc1[6]),
    .weight2(weight_data_fc2[6]),
    .bias(bias_fc[6]),   // Bias value
    .ready(),
    .Value(out7) // Output value
);
fully_connected #(.BIT_WIDTH(8),.OUT_WIDTH(32)) fc8(
    .clk(clk), // Clock
    .en(en_fc && ce_4),  // Enable
    .rst_n(rst_n),
    .in1(reluOut[0]),
    .in2(reluOut[1]),
    .weight1(weight_data_fc1[7]),
    .weight2(weight_data_fc2[7]),
    .bias(bias_fc[7]),   // Bias value
    .ready(),
    .Value(out8) // Output value
);
fully_connected #(.BIT_WIDTH(8),.OUT_WIDTH(32)) fc9(
    .clk(clk), // Clock
    .en(en_fc && ce_4),  // Enable
    .rst_n(rst_n),
    .in1(reluOut[0]),
    .in2(reluOut[1]),
    .weight1(weight_data_fc1[8]),
    .weight2(weight_data_fc2[8]),
    .bias(bias_fc[8]),   // Bias value
    .ready(),
    .Value(out9) // Output value
);
fully_connected #(.BIT_WIDTH(8),.OUT_WIDTH(32)) fc10(
    .clk(clk), // Clock
    .en(en_fc && ce_4),  // Enable
    .rst_n(rst_n),
    .in1(reluOut[0]),
    .in2(reluOut[1]),
    .weight1(weight_data_fc1[9]),
    .weight2(weight_data_fc2[9]),
    .bias(bias_fc[9]),   // Bias value
    .ready(),
    .Value(out10) // Output value
);

integer i, j, q, m;
integer load_reset_index;
parameter NUM_SEGMENTS = 20;
parameter SEGMENT_LENGTH = 36;
localparam TOTAL_LENGTH = NUM_SEGMENTS * 2 * SEGMENT_LENGTH;
//////////////////////////////////////////Load Data/////////////////////////////////////////////////////////
//reg signed[7:0] weight_data_1[0:11];  //weight 12x2=24
//reg signed[7:0] weight_data_2[0:11];
//reg signed[7:0]bias[0:1];  //2

//reg signed[7:0] weight_data_fc1[0:359];  //weight 36*2*10 //需要更新
//reg signed[7:0] weight_data_fc2[0:359];
//reg signed[7:0]bias_fc[0:9];  //10

//reg signed[7:0] weight_data_fc1_all[0:359];  //總權重 36*10
//reg signed[7:0] weight_data_fc2_all[0:359];

//reg signed[7:0] weight_data_fc1[0:9];        //塞入10個權重
//reg signed[7:0] weight_data_fc2[0:9];
reg [5:0]counter_weight;
reg c3_load_group;
reg [3:0] c3_load_offset;
reg [3:0] fc_load_class;
reg [6:0] fc_load_offset;
reg [8:0] fc1_load_index;
reg [8:0] fc2_load_index;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (load_reset_index = 0; load_reset_index < 10; load_reset_index = load_reset_index + 1) begin
            bias_fc[load_reset_index] <= 0;
        end
        for (load_reset_index = 0; load_reset_index < 360; load_reset_index = load_reset_index + 1) begin
            weight_data_fc1_all[load_reset_index] <= 0;
            weight_data_fc2_all[load_reset_index] <= 0;
        end
        for (load_reset_index = 0; load_reset_index < 2; load_reset_index = load_reset_index + 1) begin
            bias[load_reset_index] <= 0;
        end
        ena_c3 <= 0;
        ena_fc <= 0;
        addra_c3 <= 0;
        addra_fc <= 0;
        c3_load_group <= 0;
        c3_load_offset <= 0;
        fc_load_class <= 0;
        fc_load_offset <= 0;
        fc1_load_index <= 0;
        fc2_load_index <= 0;
        i <= 0;

    end else begin
    if (load_weight)begin    //60 cycle LOAD
        ena_c3 <= (i < 26);
        ena_fc <= (i < 730);
        if (i < 26) addra_c3 <= i;
        if (i < 730) addra_fc <= i;

        if((i < 29) && (i > 2)) begin
            if (c3_load_offset < 12) begin
                if (c3_load_group == 0)
                    weight_data_1[c3_load_offset] <= douta_c3;
                else
                    weight_data_2[c3_load_offset] <= douta_c3;
                c3_load_offset <= c3_load_offset + 1;
            end else begin
                bias[c3_load_group] <= douta_c3;
                c3_load_offset <= 0;
                c3_load_group <= c3_load_group + 1;
            end
        end

        if((i < 733) && (i > 2)) begin
            if (fc_load_offset < 36) begin
                weight_data_fc1_all[fc1_load_index] <= douta_fc;
                fc1_load_index <= fc1_load_index + 1;
                fc_load_offset <= fc_load_offset + 1;
            end else if (fc_load_offset < 72) begin
                weight_data_fc2_all[fc2_load_index] <= douta_fc;
                fc2_load_index <= fc2_load_index + 1;
                fc_load_offset <= fc_load_offset + 1;
            end else begin
                bias_fc[fc_load_class] <= douta_fc;
                fc_load_offset <= 0;
                fc_load_class <= fc_load_class + 1;
            end
        end
        i <= i + 1;
    end else begin
        ena_c3 <= 0;
        ena_fc <= 0;
    end
    end
end
//////////////////////////////////////////////////////////////////////////////////////傳送資料
always @(posedge clk or negedge rst_n) begin
if (!rst_n) begin
        for (q = 0; q < 10; q = q + 1) begin
            weight_data_fc1[q] <= 0;
            weight_data_fc2[q] <= 0;
        end
        counter_weight <= 0;
    end else if (ce_4) begin
    if(en_c1)begin
        weight_data_fc1[0] <= weight_data_fc1_all[counter_weight];
        weight_data_fc1[1] <= weight_data_fc1_all[36 + counter_weight];
        weight_data_fc1[2] <= weight_data_fc1_all[72 + counter_weight];
        weight_data_fc1[3] <= weight_data_fc1_all[108 + counter_weight];
        weight_data_fc1[4] <= weight_data_fc1_all[144 + counter_weight];
        weight_data_fc1[5] <= weight_data_fc1_all[180 + counter_weight];
        weight_data_fc1[6] <= weight_data_fc1_all[216 + counter_weight];
        weight_data_fc1[7] <= weight_data_fc1_all[252 + counter_weight];
        weight_data_fc1[8] <= weight_data_fc1_all[288 + counter_weight];
        weight_data_fc1[9] <= weight_data_fc1_all[324 + counter_weight];

        weight_data_fc2[0] <= weight_data_fc2_all[counter_weight];
        weight_data_fc2[1] <= weight_data_fc2_all[36 + counter_weight];
        weight_data_fc2[2] <= weight_data_fc2_all[72 + counter_weight];
        weight_data_fc2[3] <= weight_data_fc2_all[108 + counter_weight];
        weight_data_fc2[4] <= weight_data_fc2_all[144 + counter_weight];
        weight_data_fc2[5] <= weight_data_fc2_all[180 + counter_weight];
        weight_data_fc2[6] <= weight_data_fc2_all[216 + counter_weight];
        weight_data_fc2[7] <= weight_data_fc2_all[252 + counter_weight];
        weight_data_fc2[8] <= weight_data_fc2_all[288 + counter_weight];
        weight_data_fc2[9] <= weight_data_fc2_all[324 + counter_weight];
        counter_weight = counter_weight + 1;
    end
end
end

//reset
//conv11: 6*6 = 36cycle
//fc: 36 (並行兩層*10) +1 bias

always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            en_c1 <= 0;
            j <= 0;
            for (m = 0; m < 12; m = m + 1) map_q[m] <= 0;
        end else if (ce_4) begin
            // Layer 2 already presents one pooled value per valid pulse.  The
            // old divided-clock version added another 6-on/5-off schedule;
            // retaining it with a clock enable drops inputs and prevents the
            // 36-entry fully-connected accumulator from ever completing.
            if (en && j < 36 && !ready) begin
                map_q[0] <= map1;
                map_q[1] <= map2;
                map_q[2] <= map3;
                map_q[3] <= map4;
                map_q[4] <= map5;
                map_q[5] <= map6;
                map_q[6] <= map7;
                map_q[7] <= map8;
                map_q[8] <= map9;
                map_q[9] <= map10;
                map_q[10] <= map11;
                map_q[11] <= map12;
                en_c1 <= 1;
                j = j + 1;
            end else begin
                en_c1 <= 0;
            end
    end
end

//////////////////////////////////////////////////////////////////////////////
always @(posedge clk or negedge rst_n) begin  //controll fc
    if(!rst_n)begin
        en_fc <= 0;
    end else if (ce_4) begin
    if(en_c1)begin
        en_fc <= 1;
    end else begin
        en_fc <= 0;
    end
    end
end

endmodule
