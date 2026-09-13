module layer_2 (    //in:14*14*6  out:6*6*12
    input clk,
    input en,
    input rst_n,
    input load_weight,
    input signed [7:0]map1,map2,map3,map4,map5,map6,
    output reg start,
    output  stall_out,
    output reg ready,
    output signed [7:0] out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12
);
parameter BIT_WIDTH_8 = 8;
// A 3x3 dot product needs 19 signed bits.  Six such channels plus bias
// need 22 bits; one guard bit is retained at each boundary.
parameter BIT_WIDTH_32 = 20;
parameter BIT_WIDTH_ACC = 23;

reg signed[7:0] weight_data_1[0:53];  //weight2 (6maps*(3*3) weights + 1bias) * 12 * 8bits
reg signed[7:0] weight_data_2[0:53];
reg signed[7:0] weight_data_3[0:53];
reg signed[7:0] weight_data_4[0:53];
reg signed[7:0] weight_data_5[0:53];
reg signed[7:0] weight_data_6[0:53];
reg signed[7:0] weight_data_7[0:53];
reg signed[7:0] weight_data_8[0:53];
reg signed[7:0] weight_data_9[0:53];
reg signed[7:0] weight_data_10[0:53];
reg signed[7:0] weight_data_11[0:53];
reg signed[7:0] weight_data_12[0:53];

reg signed[7:0]bias[0:11]; //12

wire ce_2;

//降頻器.因為第一層的maxpooling stride為2.此電路都用降頻訊號
//外部一樣用clk
div2 d1(
	.clk(clk),
	.rst_n(rst_n),
	.o_clk(ce_2)
);

wire [7:0]convIn1[0:8];
wire [7:0]convIn2[0:8];
wire [7:0]convIn3[0:8];
wire [7:0]convIn4[0:8];
wire [7:0]convIn5[0:8];
wire [7:0]convIn6[0:8];
////
reg en_c2;
reg en_max2; //控制m2
reg en_OutputAccumulator;
reg en_bf;
reg en_bf_max;
//////////////////////////////LOAD Data////////////////////////////////////////////////////////////////////

reg [9:0] addra_c2;
wire [7:0] douta_c2;
reg  ena_c2;

blk_mem_gen_c2 bc1(
    .clka(clk),
    .ena(ena_c2),
    .addra(addra_c2),
    .douta(douta_c2)
);

//////////////////////////////////////////////////////////////////////////////////////////////////////////

//C2
// cycel:14*14+3=31
input_buffer_2 i1(
    .clk(clk),
    .rst_n(rst_n),
    .en(en_bf && ce_2),
    .in_data(map1),
    .out1(convIn1[0]),
    .out2(convIn1[1]),
    .out3(convIn1[2]),
    .out4(convIn1[3]),
    .out5(convIn1[4]),
    .out6(convIn1[5]),
    .out7(convIn1[6]),
    .out8(convIn1[7]),
    .out9(convIn1[8])
);
input_buffer_2 i2(
    .clk(clk),
    .rst_n(rst_n),
    .en(en_bf && ce_2),
    .in_data(map2),
    .out1(convIn2[0]),
    .out2(convIn2[1]),
    .out3(convIn2[2]),
    .out4(convIn2[3]),
    .out5(convIn2[4]),
    .out6(convIn2[5]),
    .out7(convIn2[6]),
    .out8(convIn2[7]),
    .out9(convIn2[8])
);
input_buffer_2 i3(
    .clk(clk),
    .rst_n(rst_n),
    .en(en_bf && ce_2),
    .in_data(map3),
    .out1(convIn3[0]),
    .out2(convIn3[1]),
    .out3(convIn3[2]),
    .out4(convIn3[3]),
    .out5(convIn3[4]),
    .out6(convIn3[5]),
    .out7(convIn3[6]),
    .out8(convIn3[7]),
    .out9(convIn3[8])
);
input_buffer_2 i4(
    .clk(clk),
    .rst_n(rst_n),
    .en(en_bf && ce_2),
    .in_data(map4),
    .out1(convIn4[0]),
    .out2(convIn4[1]),
    .out3(convIn4[2]),
    .out4(convIn4[3]),
    .out5(convIn4[4]),
    .out6(convIn4[5]),
    .out7(convIn4[6]),
    .out8(convIn4[7]),
    .out9(convIn4[8])
);
input_buffer_2 i5(
    .clk(clk),
    .rst_n(rst_n),
    .en(en_bf && ce_2),
    .in_data(map5),
    .out1(convIn5[0]),
    .out2(convIn5[1]),
    .out3(convIn5[2]),
    .out4(convIn5[3]),
    .out5(convIn5[4]),
    .out6(convIn5[5]),
    .out7(convIn5[6]),
    .out8(convIn5[7]),
    .out9(convIn5[8])
);
input_buffer_2 i6(
    .clk(clk),
    .rst_n(rst_n),
    .en(en_bf && ce_2),
    .in_data(map6),
    .out1(convIn6[0]),
    .out2(convIn6[1]),
    .out3(convIn6[2]),
    .out4(convIn6[3]),
    .out5(convIn6[4]),
    .out6(convIn6[5]),
    .out7(convIn6[6]),
    .out8(convIn6[7]),
    .out9(convIn6[8])
);

wire [BIT_WIDTH_32-1:0]convOut1[0:5];
wire [BIT_WIDTH_32-1:0]convOut2[0:5];
wire [BIT_WIDTH_32-1:0]convOut3[0:5];
wire [BIT_WIDTH_32-1:0]convOut4[0:5];
wire [BIT_WIDTH_32-1:0]convOut5[0:5];
wire [BIT_WIDTH_32-1:0]convOut6[0:5];
wire [BIT_WIDTH_32-1:0]convOut7[0:5];
wire [BIT_WIDTH_32-1:0]convOut8[0:5];
wire [BIT_WIDTH_32-1:0]convOut9[0:5];
wire [BIT_WIDTH_32-1:0]convOut10[0:5];
wire [BIT_WIDTH_32-1:0]convOut11[0:5];
wire [BIT_WIDTH_32-1:0]convOut12[0:5];

wire [BIT_WIDTH_ACC-1:0]AccumulatorValue1;
wire [BIT_WIDTH_ACC-1:0]AccumulatorValue2;
wire [BIT_WIDTH_ACC-1:0]AccumulatorValue3;
wire [BIT_WIDTH_ACC-1:0]AccumulatorValue4;
wire [BIT_WIDTH_ACC-1:0]AccumulatorValue5;
wire [BIT_WIDTH_ACC-1:0]AccumulatorValue6;
wire [BIT_WIDTH_ACC-1:0]AccumulatorValue7;
wire [BIT_WIDTH_ACC-1:0]AccumulatorValue8;
wire [BIT_WIDTH_ACC-1:0]AccumulatorValue9;
wire [BIT_WIDTH_ACC-1:0]AccumulatorValue10;
wire [BIT_WIDTH_ACC-1:0]AccumulatorValue11;
wire [BIT_WIDTH_ACC-1:0]AccumulatorValue12;

wire [7:0] reluOut1;
wire [7:0] reluOut2;
wire [7:0] reluOut3;
wire [7:0] reluOut4;
wire [7:0] reluOut5;
wire [7:0] reluOut6;
wire [7:0] reluOut7;
wire [7:0] reluOut8;
wire [7:0] reluOut9;
wire [7:0] reluOut10;
wire [7:0] reluOut11;
wire [7:0] reluOut12;

//16+log784=26bit 不會溢位
//cycle:14*14+1reset+1bias+1acc = 199 ,6 maps -> 12map
///////////////////////////////////////////////////////////////////////////////////////////////c2-1
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c11(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn1[0]),
    .in2(convIn1[1]),
    .in3(convIn1[2]),
    .in4(convIn1[3]),
    .in5(convIn1[4]),
    .in6(convIn1[5]),
    .in7(convIn1[6]),
    .in8(convIn1[7]),
    .in9(convIn1[8]),
    .w1(weight_data_1[0]),
    .w2(weight_data_1[1]),
    .w3(weight_data_1[2]),
    .w4(weight_data_1[3]),
    .w5(weight_data_1[4]),
    .w6(weight_data_1[5]),
    .w7(weight_data_1[6]),
    .w8(weight_data_1[7]),
    .w9(weight_data_1[8]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut1[0]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c12(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn2[0]),
    .in2(convIn2[1]),
    .in3(convIn2[2]),
    .in4(convIn2[3]),
    .in5(convIn2[4]),
    .in6(convIn2[5]),
    .in7(convIn2[6]),
    .in8(convIn2[7]),
    .in9(convIn2[8]),
    .w1(weight_data_1[9]),
    .w2(weight_data_1[10]),
    .w3(weight_data_1[11]),
    .w4(weight_data_1[12]),
    .w5(weight_data_1[13]),
    .w6(weight_data_1[14]),
    .w7(weight_data_1[15]),
    .w8(weight_data_1[16]),
    .w9(weight_data_1[17]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut1[1]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c13(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn3[0]),
    .in2(convIn3[1]),
    .in3(convIn3[2]),
    .in4(convIn3[3]),
    .in5(convIn3[4]),
    .in6(convIn3[5]),
    .in7(convIn3[6]),
    .in8(convIn3[7]),
    .in9(convIn3[8]),
    .w1(weight_data_1[18]),
    .w2(weight_data_1[19]),
    .w3(weight_data_1[20]),
    .w4(weight_data_1[21]),
    .w5(weight_data_1[22]),
    .w6(weight_data_1[23]),
    .w7(weight_data_1[24]),
    .w8(weight_data_1[25]),
    .w9(weight_data_1[26]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut1[2]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c14(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn4[0]),
    .in2(convIn4[1]),
    .in3(convIn4[2]),
    .in4(convIn4[3]),
    .in5(convIn4[4]),
    .in6(convIn4[5]),
    .in7(convIn4[6]),
    .in8(convIn4[7]),
    .in9(convIn4[8]),
    .w1(weight_data_1[27]),
    .w2(weight_data_1[28]),
    .w3(weight_data_1[29]),
    .w4(weight_data_1[30]),
    .w5(weight_data_1[31]),
    .w6(weight_data_1[32]),
    .w7(weight_data_1[33]),
    .w8(weight_data_1[34]),
    .w9(weight_data_1[35]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut1[3]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c15(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn5[0]),
    .in2(convIn5[1]),
    .in3(convIn5[2]),
    .in4(convIn5[3]),
    .in5(convIn5[4]),
    .in6(convIn5[5]),
    .in7(convIn5[6]),
    .in8(convIn5[7]),
    .in9(convIn5[8]),
    .w1(weight_data_1[36]),
    .w2(weight_data_1[37]),
    .w3(weight_data_1[38]),
    .w4(weight_data_1[39]),
    .w5(weight_data_1[40]),
    .w6(weight_data_1[41]),
    .w7(weight_data_1[42]),
    .w8(weight_data_1[43]),
    .w9(weight_data_1[44]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut1[4]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c16(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn6[0]),
    .in2(convIn6[1]),
    .in3(convIn6[2]),
    .in4(convIn6[3]),
    .in5(convIn6[4]),
    .in6(convIn6[5]),
    .in7(convIn6[6]),
    .in8(convIn6[7]),
    .in9(convIn6[8]),
    .w1(weight_data_1[45]),
    .w2(weight_data_1[46]),
    .w3(weight_data_1[47]),
    .w4(weight_data_1[48]),
    .w5(weight_data_1[49]),
    .w6(weight_data_1[50]),
    .w7(weight_data_1[51]),
    .w8(weight_data_1[52]),
    .w9(weight_data_1[53]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut1[5]) // Output value
);
OutputAccumulator #(.BIT_WIDTH(BIT_WIDTH_32), .OUT_WIDTH(BIT_WIDTH_ACC)) O1(
    .clk(clk), // Clock
    .en(en_OutputAccumulator && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convOut1[0]),
    .in2(convOut1[1]),
    .in3(convOut1[2]),
    .in4(convOut1[3]),
    .in5(convOut1[4]),
    .in6(convOut1[5]),
    .bias(bias[0]),
    .AccumulatorValue(AccumulatorValue1) // Output value
);
//input:35bits , output:8bits
ReLU #(.BIT_WIDTH(BIT_WIDTH_ACC), .SHIFT(9)) r1(
	.in(AccumulatorValue1),
	.out(reluOut1)
);

///////////////////////////////////////////////////////////////////////////////////////////////c2-2
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c21(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn1[0]),
    .in2(convIn1[1]),
    .in3(convIn1[2]),
    .in4(convIn1[3]),
    .in5(convIn1[4]),
    .in6(convIn1[5]),
    .in7(convIn1[6]),
    .in8(convIn1[7]),
    .in9(convIn1[8]),
    .w1(weight_data_2[0]),
    .w2(weight_data_2[1]),
    .w3(weight_data_2[2]),
    .w4(weight_data_2[3]),
    .w5(weight_data_2[4]),
    .w6(weight_data_2[5]),
    .w7(weight_data_2[6]),
    .w8(weight_data_2[7]),
    .w9(weight_data_2[8]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut2[0]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c22(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn2[0]),
    .in2(convIn2[1]),
    .in3(convIn2[2]),
    .in4(convIn2[3]),
    .in5(convIn2[4]),
    .in6(convIn2[5]),
    .in7(convIn2[6]),
    .in8(convIn2[7]),
    .in9(convIn2[8]),
    .w1(weight_data_2[9]),
    .w2(weight_data_2[10]),
    .w3(weight_data_2[11]),
    .w4(weight_data_2[12]),
    .w5(weight_data_2[13]),
    .w6(weight_data_2[14]),
    .w7(weight_data_2[15]),
    .w8(weight_data_2[16]),
    .w9(weight_data_2[17]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut2[1]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c23(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn3[0]),
    .in2(convIn3[1]),
    .in3(convIn3[2]),
    .in4(convIn3[3]),
    .in5(convIn3[4]),
    .in6(convIn3[5]),
    .in7(convIn3[6]),
    .in8(convIn3[7]),
    .in9(convIn3[8]),
    .w1(weight_data_2[18]),
    .w2(weight_data_2[19]),
    .w3(weight_data_2[20]),
    .w4(weight_data_2[21]),
    .w5(weight_data_2[22]),
    .w6(weight_data_2[23]),
    .w7(weight_data_2[24]),
    .w8(weight_data_2[25]),
    .w9(weight_data_2[26]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut2[2]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c24(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn4[0]),
    .in2(convIn4[1]),
    .in3(convIn4[2]),
    .in4(convIn4[3]),
    .in5(convIn4[4]),
    .in6(convIn4[5]),
    .in7(convIn4[6]),
    .in8(convIn4[7]),
    .in9(convIn4[8]),
    .w1(weight_data_2[27]),
    .w2(weight_data_2[28]),
    .w3(weight_data_2[29]),
    .w4(weight_data_2[30]),
    .w5(weight_data_2[31]),
    .w6(weight_data_2[32]),
    .w7(weight_data_2[33]),
    .w8(weight_data_2[34]),
    .w9(weight_data_2[35]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut2[3]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c25(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn5[0]),
    .in2(convIn5[1]),
    .in3(convIn5[2]),
    .in4(convIn5[3]),
    .in5(convIn5[4]),
    .in6(convIn5[5]),
    .in7(convIn5[6]),
    .in8(convIn5[7]),
    .in9(convIn5[8]),
    .w1(weight_data_2[36]),
    .w2(weight_data_2[37]),
    .w3(weight_data_2[38]),
    .w4(weight_data_2[39]),
    .w5(weight_data_2[40]),
    .w6(weight_data_2[41]),
    .w7(weight_data_2[42]),
    .w8(weight_data_2[43]),
    .w9(weight_data_2[44]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut2[4]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c26(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn6[0]),
    .in2(convIn6[1]),
    .in3(convIn6[2]),
    .in4(convIn6[3]),
    .in5(convIn6[4]),
    .in6(convIn6[5]),
    .in7(convIn6[6]),
    .in8(convIn6[7]),
    .in9(convIn6[8]),
    .w1(weight_data_2[45]),
    .w2(weight_data_2[46]),
    .w3(weight_data_2[47]),
    .w4(weight_data_2[48]),
    .w5(weight_data_2[49]),
    .w6(weight_data_2[50]),
    .w7(weight_data_2[51]),
    .w8(weight_data_2[52]),
    .w9(weight_data_2[53]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut2[5]) // Output value
);
OutputAccumulator #(.BIT_WIDTH(BIT_WIDTH_32), .OUT_WIDTH(BIT_WIDTH_ACC)) O2(
    .clk(clk), // Clock
    .en(en_OutputAccumulator && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convOut2[0]),
    .in2(convOut2[1]),
    .in3(convOut2[2]),
    .in4(convOut2[3]),
    .in5(convOut2[4]),
    .in6(convOut2[5]),
    .bias(bias[1]),
    .AccumulatorValue(AccumulatorValue2) // Output value
);
//input:35bits , output:8bits
ReLU #(.BIT_WIDTH(BIT_WIDTH_ACC), .SHIFT(9)) r2(
	.in(AccumulatorValue2),
	.out(reluOut2)
);
///////////////////////////////////////////////////////////////////////////////////////////////c2-3
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c31(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn1[0]),
    .in2(convIn1[1]),
    .in3(convIn1[2]),
    .in4(convIn1[3]),
    .in5(convIn1[4]),
    .in6(convIn1[5]),
    .in7(convIn1[6]),
    .in8(convIn1[7]),
    .in9(convIn1[8]),
    .w1(weight_data_3[0]),
    .w2(weight_data_3[1]),
    .w3(weight_data_3[2]),
    .w4(weight_data_3[3]),
    .w5(weight_data_3[4]),
    .w6(weight_data_3[5]),
    .w7(weight_data_3[6]),
    .w8(weight_data_3[7]),
    .w9(weight_data_3[8]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut3[0]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c32(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn2[0]),
    .in2(convIn2[1]),
    .in3(convIn2[2]),
    .in4(convIn2[3]),
    .in5(convIn2[4]),
    .in6(convIn2[5]),
    .in7(convIn2[6]),
    .in8(convIn2[7]),
    .in9(convIn2[8]),
    .w1(weight_data_3[9]),
    .w2(weight_data_3[10]),
    .w3(weight_data_3[11]),
    .w4(weight_data_3[12]),
    .w5(weight_data_3[13]),
    .w6(weight_data_3[14]),
    .w7(weight_data_3[15]),
    .w8(weight_data_3[16]),
    .w9(weight_data_3[17]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut3[1]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c33(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn3[0]),
    .in2(convIn3[1]),
    .in3(convIn3[2]),
    .in4(convIn3[3]),
    .in5(convIn3[4]),
    .in6(convIn3[5]),
    .in7(convIn3[6]),
    .in8(convIn3[7]),
    .in9(convIn3[8]),
    .w1(weight_data_3[18]),
    .w2(weight_data_3[19]),
    .w3(weight_data_3[20]),
    .w4(weight_data_3[21]),
    .w5(weight_data_3[22]),
    .w6(weight_data_3[23]),
    .w7(weight_data_3[24]),
    .w8(weight_data_3[25]),
    .w9(weight_data_3[26]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut3[2]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c34(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn4[0]),
    .in2(convIn4[1]),
    .in3(convIn4[2]),
    .in4(convIn4[3]),
    .in5(convIn4[4]),
    .in6(convIn4[5]),
    .in7(convIn4[6]),
    .in8(convIn4[7]),
    .in9(convIn4[8]),
    .w1(weight_data_3[27]),
    .w2(weight_data_3[28]),
    .w3(weight_data_3[29]),
    .w4(weight_data_3[30]),
    .w5(weight_data_3[31]),
    .w6(weight_data_3[32]),
    .w7(weight_data_3[33]),
    .w8(weight_data_3[34]),
    .w9(weight_data_3[35]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut3[3]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c35(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn5[0]),
    .in2(convIn5[1]),
    .in3(convIn5[2]),
    .in4(convIn5[3]),
    .in5(convIn5[4]),
    .in6(convIn5[5]),
    .in7(convIn5[6]),
    .in8(convIn5[7]),
    .in9(convIn5[8]),
    .w1(weight_data_3[36]),
    .w2(weight_data_3[37]),
    .w3(weight_data_3[38]),
    .w4(weight_data_3[39]),
    .w5(weight_data_3[40]),
    .w6(weight_data_3[41]),
    .w7(weight_data_3[42]),
    .w8(weight_data_3[43]),
    .w9(weight_data_3[44]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut3[4]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c36(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn6[0]),
    .in2(convIn6[1]),
    .in3(convIn6[2]),
    .in4(convIn6[3]),
    .in5(convIn6[4]),
    .in6(convIn6[5]),
    .in7(convIn6[6]),
    .in8(convIn6[7]),
    .in9(convIn6[8]),
    .w1(weight_data_3[45]),
    .w2(weight_data_3[46]),
    .w3(weight_data_3[47]),
    .w4(weight_data_3[48]),
    .w5(weight_data_3[49]),
    .w6(weight_data_3[50]),
    .w7(weight_data_3[51]),
    .w8(weight_data_3[52]),
    .w9(weight_data_3[53]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut3[5]) // Output value
);
OutputAccumulator #(.BIT_WIDTH(BIT_WIDTH_32), .OUT_WIDTH(BIT_WIDTH_ACC)) O3(
    .clk(clk), // Clock
    .en(en_OutputAccumulator && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convOut3[0]),
    .in2(convOut3[1]),
    .in3(convOut3[2]),
    .in4(convOut3[3]),
    .in5(convOut3[4]),
    .in6(convOut3[5]),
    .bias(bias[2]),
    .AccumulatorValue(AccumulatorValue3) // Output value
);
//input:35bits , output:8bits
ReLU #(.BIT_WIDTH(BIT_WIDTH_ACC), .SHIFT(9)) r3(
	.in(AccumulatorValue3),
	.out(reluOut3)
);
///////////////////////////////////////////////////////////////////////////////////////////////c2-4
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c41(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn1[0]),
    .in2(convIn1[1]),
    .in3(convIn1[2]),
    .in4(convIn1[3]),
    .in5(convIn1[4]),
    .in6(convIn1[5]),
    .in7(convIn1[6]),
    .in8(convIn1[7]),
    .in9(convIn1[8]),
    .w1(weight_data_4[0]),
    .w2(weight_data_4[1]),
    .w3(weight_data_4[2]),
    .w4(weight_data_4[3]),
    .w5(weight_data_4[4]),
    .w6(weight_data_4[5]),
    .w7(weight_data_4[6]),
    .w8(weight_data_4[7]),
    .w9(weight_data_4[8]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut4[0]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c42(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn2[0]),
    .in2(convIn2[1]),
    .in3(convIn2[2]),
    .in4(convIn2[3]),
    .in5(convIn2[4]),
    .in6(convIn2[5]),
    .in7(convIn2[6]),
    .in8(convIn2[7]),
    .in9(convIn2[8]),
    .w1(weight_data_4[9]),
    .w2(weight_data_4[10]),
    .w3(weight_data_4[11]),
    .w4(weight_data_4[12]),
    .w5(weight_data_4[13]),
    .w6(weight_data_4[14]),
    .w7(weight_data_4[15]),
    .w8(weight_data_4[16]),
    .w9(weight_data_4[17]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut4[1]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c43(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn3[0]),
    .in2(convIn3[1]),
    .in3(convIn3[2]),
    .in4(convIn3[3]),
    .in5(convIn3[4]),
    .in6(convIn3[5]),
    .in7(convIn3[6]),
    .in8(convIn3[7]),
    .in9(convIn3[8]),
    .w1(weight_data_4[18]),
    .w2(weight_data_4[19]),
    .w3(weight_data_4[20]),
    .w4(weight_data_4[21]),
    .w5(weight_data_4[22]),
    .w6(weight_data_4[23]),
    .w7(weight_data_4[24]),
    .w8(weight_data_4[25]),
    .w9(weight_data_4[26]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut4[2]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c44(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn4[0]),
    .in2(convIn4[1]),
    .in3(convIn4[2]),
    .in4(convIn4[3]),
    .in5(convIn4[4]),
    .in6(convIn4[5]),
    .in7(convIn4[6]),
    .in8(convIn4[7]),
    .in9(convIn4[8]),
    .w1(weight_data_4[27]),
    .w2(weight_data_4[28]),
    .w3(weight_data_4[29]),
    .w4(weight_data_4[30]),
    .w5(weight_data_4[31]),
    .w6(weight_data_4[32]),
    .w7(weight_data_4[33]),
    .w8(weight_data_4[34]),
    .w9(weight_data_4[35]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut4[3]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c45(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn5[0]),
    .in2(convIn5[1]),
    .in3(convIn5[2]),
    .in4(convIn5[3]),
    .in5(convIn5[4]),
    .in6(convIn5[5]),
    .in7(convIn5[6]),
    .in8(convIn5[7]),
    .in9(convIn5[8]),
    .w1(weight_data_4[36]),
    .w2(weight_data_4[37]),
    .w3(weight_data_4[38]),
    .w4(weight_data_4[39]),
    .w5(weight_data_4[40]),
    .w6(weight_data_4[41]),
    .w7(weight_data_4[42]),
    .w8(weight_data_4[43]),
    .w9(weight_data_4[44]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut4[4]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c46(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn6[0]),
    .in2(convIn6[1]),
    .in3(convIn6[2]),
    .in4(convIn6[3]),
    .in5(convIn6[4]),
    .in6(convIn6[5]),
    .in7(convIn6[6]),
    .in8(convIn6[7]),
    .in9(convIn6[8]),
    .w1(weight_data_4[45]),
    .w2(weight_data_4[46]),
    .w3(weight_data_4[47]),
    .w4(weight_data_4[48]),
    .w5(weight_data_4[49]),
    .w6(weight_data_4[50]),
    .w7(weight_data_4[51]),
    .w8(weight_data_4[52]),
    .w9(weight_data_4[53]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut4[5]) // Output value
);
OutputAccumulator #(.BIT_WIDTH(BIT_WIDTH_32), .OUT_WIDTH(BIT_WIDTH_ACC)) O4(
    .clk(clk), // Clock
    .en(en_OutputAccumulator && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convOut4[0]),
    .in2(convOut4[1]),
    .in3(convOut4[2]),
    .in4(convOut4[3]),
    .in5(convOut4[4]),
    .in6(convOut4[5]),
    .bias(bias[3]),
    .AccumulatorValue(AccumulatorValue4) // Output value
);
//input:35bits , output:8bits
ReLU #(.BIT_WIDTH(BIT_WIDTH_ACC), .SHIFT(9)) r4(
	.in(AccumulatorValue4),
	.out(reluOut4)
);
///////////////////////////////////////////////////////////////////////////////////////////////c2-5
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c51(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn1[0]),
    .in2(convIn1[1]),
    .in3(convIn1[2]),
    .in4(convIn1[3]),
    .in5(convIn1[4]),
    .in6(convIn1[5]),
    .in7(convIn1[6]),
    .in8(convIn1[7]),
    .in9(convIn1[8]),
    .w1(weight_data_5[0]),
    .w2(weight_data_5[1]),
    .w3(weight_data_5[2]),
    .w4(weight_data_5[3]),
    .w5(weight_data_5[4]),
    .w6(weight_data_5[5]),
    .w7(weight_data_5[6]),
    .w8(weight_data_5[7]),
    .w9(weight_data_5[8]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut5[0]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c52(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn2[0]),
    .in2(convIn2[1]),
    .in3(convIn2[2]),
    .in4(convIn2[3]),
    .in5(convIn2[4]),
    .in6(convIn2[5]),
    .in7(convIn2[6]),
    .in8(convIn2[7]),
    .in9(convIn2[8]),
    .w1(weight_data_5[9]),
    .w2(weight_data_5[10]),
    .w3(weight_data_5[11]),
    .w4(weight_data_5[12]),
    .w5(weight_data_5[13]),
    .w6(weight_data_5[14]),
    .w7(weight_data_5[15]),
    .w8(weight_data_5[16]),
    .w9(weight_data_5[17]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut5[1]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c53(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn3[0]),
    .in2(convIn3[1]),
    .in3(convIn3[2]),
    .in4(convIn3[3]),
    .in5(convIn3[4]),
    .in6(convIn3[5]),
    .in7(convIn3[6]),
    .in8(convIn3[7]),
    .in9(convIn3[8]),
    .w1(weight_data_5[18]),
    .w2(weight_data_5[19]),
    .w3(weight_data_5[20]),
    .w4(weight_data_5[21]),
    .w5(weight_data_5[22]),
    .w6(weight_data_5[23]),
    .w7(weight_data_5[24]),
    .w8(weight_data_5[25]),
    .w9(weight_data_5[26]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut5[2]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c54(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn4[0]),
    .in2(convIn4[1]),
    .in3(convIn4[2]),
    .in4(convIn4[3]),
    .in5(convIn4[4]),
    .in6(convIn4[5]),
    .in7(convIn4[6]),
    .in8(convIn4[7]),
    .in9(convIn4[8]),
    .w1(weight_data_5[27]),
    .w2(weight_data_5[28]),
    .w3(weight_data_5[29]),
    .w4(weight_data_5[30]),
    .w5(weight_data_5[31]),
    .w6(weight_data_5[32]),
    .w7(weight_data_5[33]),
    .w8(weight_data_5[34]),
    .w9(weight_data_5[35]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut5[3]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c55(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn5[0]),
    .in2(convIn5[1]),
    .in3(convIn5[2]),
    .in4(convIn5[3]),
    .in5(convIn5[4]),
    .in6(convIn5[5]),
    .in7(convIn5[6]),
    .in8(convIn5[7]),
    .in9(convIn5[8]),
    .w1(weight_data_5[36]),
    .w2(weight_data_5[37]),
    .w3(weight_data_5[38]),
    .w4(weight_data_5[39]),
    .w5(weight_data_5[40]),
    .w6(weight_data_5[41]),
    .w7(weight_data_5[42]),
    .w8(weight_data_5[43]),
    .w9(weight_data_5[44]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut5[4]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c56(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn6[0]),
    .in2(convIn6[1]),
    .in3(convIn6[2]),
    .in4(convIn6[3]),
    .in5(convIn6[4]),
    .in6(convIn6[5]),
    .in7(convIn6[6]),
    .in8(convIn6[7]),
    .in9(convIn6[8]),
    .w1(weight_data_5[45]),
    .w2(weight_data_5[46]),
    .w3(weight_data_5[47]),
    .w4(weight_data_5[48]),
    .w5(weight_data_5[49]),
    .w6(weight_data_5[50]),
    .w7(weight_data_5[51]),
    .w8(weight_data_5[52]),
    .w9(weight_data_5[53]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut5[5]) // Output value
);
OutputAccumulator #(.BIT_WIDTH(BIT_WIDTH_32), .OUT_WIDTH(BIT_WIDTH_ACC)) O5(
    .clk(clk), // Clock
    .en(en_OutputAccumulator && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convOut5[0]),
    .in2(convOut5[1]),
    .in3(convOut5[2]),
    .in4(convOut5[3]),
    .in5(convOut5[4]),
    .in6(convOut5[5]),
    .bias(bias[4]),
    .AccumulatorValue(AccumulatorValue5) // Output value
);
//input:35bits , output:8bits
ReLU #(.BIT_WIDTH(BIT_WIDTH_ACC), .SHIFT(9)) r5(
	.in(AccumulatorValue5),
	.out(reluOut5)
);
///////////////////////////////////////////////////////////////////////////////////////////////c2-6
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c61(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn1[0]),
    .in2(convIn1[1]),
    .in3(convIn1[2]),
    .in4(convIn1[3]),
    .in5(convIn1[4]),
    .in6(convIn1[5]),
    .in7(convIn1[6]),
    .in8(convIn1[7]),
    .in9(convIn1[8]),
    .w1(weight_data_6[0]),
    .w2(weight_data_6[1]),
    .w3(weight_data_6[2]),
    .w4(weight_data_6[3]),
    .w5(weight_data_6[4]),
    .w6(weight_data_6[5]),
    .w7(weight_data_6[6]),
    .w8(weight_data_6[7]),
    .w9(weight_data_6[8]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut6[0]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c62(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn2[0]),
    .in2(convIn2[1]),
    .in3(convIn2[2]),
    .in4(convIn2[3]),
    .in5(convIn2[4]),
    .in6(convIn2[5]),
    .in7(convIn2[6]),
    .in8(convIn2[7]),
    .in9(convIn2[8]),
    .w1(weight_data_6[9]),
    .w2(weight_data_6[10]),
    .w3(weight_data_6[11]),
    .w4(weight_data_6[12]),
    .w5(weight_data_6[13]),
    .w6(weight_data_6[14]),
    .w7(weight_data_6[15]),
    .w8(weight_data_6[16]),
    .w9(weight_data_6[17]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut6[1]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c63(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn3[0]),
    .in2(convIn3[1]),
    .in3(convIn3[2]),
    .in4(convIn3[3]),
    .in5(convIn3[4]),
    .in6(convIn3[5]),
    .in7(convIn3[6]),
    .in8(convIn3[7]),
    .in9(convIn3[8]),
    .w1(weight_data_6[18]),
    .w2(weight_data_6[19]),
    .w3(weight_data_6[20]),
    .w4(weight_data_6[21]),
    .w5(weight_data_6[22]),
    .w6(weight_data_6[23]),
    .w7(weight_data_6[24]),
    .w8(weight_data_6[25]),
    .w9(weight_data_6[26]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut6[2]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c64(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn4[0]),
    .in2(convIn4[1]),
    .in3(convIn4[2]),
    .in4(convIn4[3]),
    .in5(convIn4[4]),
    .in6(convIn4[5]),
    .in7(convIn4[6]),
    .in8(convIn4[7]),
    .in9(convIn4[8]),
    .w1(weight_data_6[27]),
    .w2(weight_data_6[28]),
    .w3(weight_data_6[29]),
    .w4(weight_data_6[30]),
    .w5(weight_data_6[31]),
    .w6(weight_data_6[32]),
    .w7(weight_data_6[33]),
    .w8(weight_data_6[34]),
    .w9(weight_data_6[35]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut6[3]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c65(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn5[0]),
    .in2(convIn5[1]),
    .in3(convIn5[2]),
    .in4(convIn5[3]),
    .in5(convIn5[4]),
    .in6(convIn5[5]),
    .in7(convIn5[6]),
    .in8(convIn5[7]),
    .in9(convIn5[8]),
    .w1(weight_data_6[36]),
    .w2(weight_data_6[37]),
    .w3(weight_data_6[38]),
    .w4(weight_data_6[39]),
    .w5(weight_data_6[40]),
    .w6(weight_data_6[41]),
    .w7(weight_data_6[42]),
    .w8(weight_data_6[43]),
    .w9(weight_data_6[44]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut6[4]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c66(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn6[0]),
    .in2(convIn6[1]),
    .in3(convIn6[2]),
    .in4(convIn6[3]),
    .in5(convIn6[4]),
    .in6(convIn6[5]),
    .in7(convIn6[6]),
    .in8(convIn6[7]),
    .in9(convIn6[8]),
    .w1(weight_data_6[45]),
    .w2(weight_data_6[46]),
    .w3(weight_data_6[47]),
    .w4(weight_data_6[48]),
    .w5(weight_data_6[49]),
    .w6(weight_data_6[50]),
    .w7(weight_data_6[51]),
    .w8(weight_data_6[52]),
    .w9(weight_data_6[53]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut6[5]) // Output value
);
OutputAccumulator #(.BIT_WIDTH(BIT_WIDTH_32), .OUT_WIDTH(BIT_WIDTH_ACC)) O6(
    .clk(clk), // Clock
    .en(en_OutputAccumulator && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convOut6[0]),
    .in2(convOut6[1]),
    .in3(convOut6[2]),
    .in4(convOut6[3]),
    .in5(convOut6[4]),
    .in6(convOut6[5]),
    .bias(bias[5]),
    .AccumulatorValue(AccumulatorValue6) // Output value
);
//input:35bits , output:8bits
ReLU #(.BIT_WIDTH(BIT_WIDTH_ACC), .SHIFT(9)) r6(
	.in(AccumulatorValue6),
	.out(reluOut6)
);
///////////////////////////////////////////////////////////////////////////////////////////////c2-7
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c71(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn1[0]),
    .in2(convIn1[1]),
    .in3(convIn1[2]),
    .in4(convIn1[3]),
    .in5(convIn1[4]),
    .in6(convIn1[5]),
    .in7(convIn1[6]),
    .in8(convIn1[7]),
    .in9(convIn1[8]),
    .w1(weight_data_7[0]),
    .w2(weight_data_7[1]),
    .w3(weight_data_7[2]),
    .w4(weight_data_7[3]),
    .w5(weight_data_7[4]),
    .w6(weight_data_7[5]),
    .w7(weight_data_7[6]),
    .w8(weight_data_7[7]),
    .w9(weight_data_7[8]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut7[0]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c72(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn2[0]),
    .in2(convIn2[1]),
    .in3(convIn2[2]),
    .in4(convIn2[3]),
    .in5(convIn2[4]),
    .in6(convIn2[5]),
    .in7(convIn2[6]),
    .in8(convIn2[7]),
    .in9(convIn2[8]),
    .w1(weight_data_7[9]),
    .w2(weight_data_7[10]),
    .w3(weight_data_7[11]),
    .w4(weight_data_7[12]),
    .w5(weight_data_7[13]),
    .w6(weight_data_7[14]),
    .w7(weight_data_7[15]),
    .w8(weight_data_7[16]),
    .w9(weight_data_7[17]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut7[1]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c73(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn3[0]),
    .in2(convIn3[1]),
    .in3(convIn3[2]),
    .in4(convIn3[3]),
    .in5(convIn3[4]),
    .in6(convIn3[5]),
    .in7(convIn3[6]),
    .in8(convIn3[7]),
    .in9(convIn3[8]),
    .w1(weight_data_7[18]),
    .w2(weight_data_7[19]),
    .w3(weight_data_7[20]),
    .w4(weight_data_7[21]),
    .w5(weight_data_7[22]),
    .w6(weight_data_7[23]),
    .w7(weight_data_7[24]),
    .w8(weight_data_7[25]),
    .w9(weight_data_7[26]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut7[2]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c74(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn4[0]),
    .in2(convIn4[1]),
    .in3(convIn4[2]),
    .in4(convIn4[3]),
    .in5(convIn4[4]),
    .in6(convIn4[5]),
    .in7(convIn4[6]),
    .in8(convIn4[7]),
    .in9(convIn4[8]),
    .w1(weight_data_7[27]),
    .w2(weight_data_7[28]),
    .w3(weight_data_7[29]),
    .w4(weight_data_7[30]),
    .w5(weight_data_7[31]),
    .w6(weight_data_7[32]),
    .w7(weight_data_7[33]),
    .w8(weight_data_7[34]),
    .w9(weight_data_7[35]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut7[3]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c75(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn5[0]),
    .in2(convIn5[1]),
    .in3(convIn5[2]),
    .in4(convIn5[3]),
    .in5(convIn5[4]),
    .in6(convIn5[5]),
    .in7(convIn5[6]),
    .in8(convIn5[7]),
    .in9(convIn5[8]),
    .w1(weight_data_7[36]),
    .w2(weight_data_7[37]),
    .w3(weight_data_7[38]),
    .w4(weight_data_7[39]),
    .w5(weight_data_7[40]),
    .w6(weight_data_7[41]),
    .w7(weight_data_7[42]),
    .w8(weight_data_7[43]),
    .w9(weight_data_7[44]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut7[4]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c76(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn6[0]),
    .in2(convIn6[1]),
    .in3(convIn6[2]),
    .in4(convIn6[3]),
    .in5(convIn6[4]),
    .in6(convIn6[5]),
    .in7(convIn6[6]),
    .in8(convIn6[7]),
    .in9(convIn6[8]),
    .w1(weight_data_7[45]),
    .w2(weight_data_7[46]),
    .w3(weight_data_7[47]),
    .w4(weight_data_7[48]),
    .w5(weight_data_7[49]),
    .w6(weight_data_7[50]),
    .w7(weight_data_7[51]),
    .w8(weight_data_7[52]),
    .w9(weight_data_7[53]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut7[5]) // Output value
);
OutputAccumulator #(.BIT_WIDTH(BIT_WIDTH_32), .OUT_WIDTH(BIT_WIDTH_ACC)) O7(
    .clk(clk), // Clock
    .en(en_OutputAccumulator && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convOut7[0]),
    .in2(convOut7[1]),
    .in3(convOut7[2]),
    .in4(convOut7[3]),
    .in5(convOut7[4]),
    .in6(convOut7[5]),
    .bias(bias[6]),
    .AccumulatorValue(AccumulatorValue7) // Output value
);
//input:35bits , output:8bits
ReLU #(.BIT_WIDTH(BIT_WIDTH_ACC), .SHIFT(9)) r7(
	.in(AccumulatorValue7),
	.out(reluOut7)
);
///////////////////////////////////////////////////////////////////////////////////////////////c2-8
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c81(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn1[0]),
    .in2(convIn1[1]),
    .in3(convIn1[2]),
    .in4(convIn1[3]),
    .in5(convIn1[4]),
    .in6(convIn1[5]),
    .in7(convIn1[6]),
    .in8(convIn1[7]),
    .in9(convIn1[8]),
    .w1(weight_data_8[0]),
    .w2(weight_data_8[1]),
    .w3(weight_data_8[2]),
    .w4(weight_data_8[3]),
    .w5(weight_data_8[4]),
    .w6(weight_data_8[5]),
    .w7(weight_data_8[6]),
    .w8(weight_data_8[7]),
    .w9(weight_data_8[8]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut8[0]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c82(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn2[0]),
    .in2(convIn2[1]),
    .in3(convIn2[2]),
    .in4(convIn2[3]),
    .in5(convIn2[4]),
    .in6(convIn2[5]),
    .in7(convIn2[6]),
    .in8(convIn2[7]),
    .in9(convIn2[8]),
    .w1(weight_data_8[9]),
    .w2(weight_data_8[10]),
    .w3(weight_data_8[11]),
    .w4(weight_data_8[12]),
    .w5(weight_data_8[13]),
    .w6(weight_data_8[14]),
    .w7(weight_data_8[15]),
    .w8(weight_data_8[16]),
    .w9(weight_data_8[17]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut8[1]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c83(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn3[0]),
    .in2(convIn3[1]),
    .in3(convIn3[2]),
    .in4(convIn3[3]),
    .in5(convIn3[4]),
    .in6(convIn3[5]),
    .in7(convIn3[6]),
    .in8(convIn3[7]),
    .in9(convIn3[8]),
    .w1(weight_data_8[18]),
    .w2(weight_data_8[19]),
    .w3(weight_data_8[20]),
    .w4(weight_data_8[21]),
    .w5(weight_data_8[22]),
    .w6(weight_data_8[23]),
    .w7(weight_data_8[24]),
    .w8(weight_data_8[25]),
    .w9(weight_data_8[26]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut8[2]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c84(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn4[0]),
    .in2(convIn4[1]),
    .in3(convIn4[2]),
    .in4(convIn4[3]),
    .in5(convIn4[4]),
    .in6(convIn4[5]),
    .in7(convIn4[6]),
    .in8(convIn4[7]),
    .in9(convIn4[8]),
    .w1(weight_data_8[27]),
    .w2(weight_data_8[28]),
    .w3(weight_data_8[29]),
    .w4(weight_data_8[30]),
    .w5(weight_data_8[31]),
    .w6(weight_data_8[32]),
    .w7(weight_data_8[33]),
    .w8(weight_data_8[34]),
    .w9(weight_data_8[35]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut8[3]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c85(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn5[0]),
    .in2(convIn5[1]),
    .in3(convIn5[2]),
    .in4(convIn5[3]),
    .in5(convIn5[4]),
    .in6(convIn5[5]),
    .in7(convIn5[6]),
    .in8(convIn5[7]),
    .in9(convIn5[8]),
    .w1(weight_data_8[36]),
    .w2(weight_data_8[37]),
    .w3(weight_data_8[38]),
    .w4(weight_data_8[39]),
    .w5(weight_data_8[40]),
    .w6(weight_data_8[41]),
    .w7(weight_data_8[42]),
    .w8(weight_data_8[43]),
    .w9(weight_data_8[44]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut8[4]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c86(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn6[0]),
    .in2(convIn6[1]),
    .in3(convIn6[2]),
    .in4(convIn6[3]),
    .in5(convIn6[4]),
    .in6(convIn6[5]),
    .in7(convIn6[6]),
    .in8(convIn6[7]),
    .in9(convIn6[8]),
    .w1(weight_data_8[45]),
    .w2(weight_data_8[46]),
    .w3(weight_data_8[47]),
    .w4(weight_data_8[48]),
    .w5(weight_data_8[49]),
    .w6(weight_data_8[50]),
    .w7(weight_data_8[51]),
    .w8(weight_data_8[52]),
    .w9(weight_data_8[53]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut8[5]) // Output value
);
OutputAccumulator #(.BIT_WIDTH(BIT_WIDTH_32), .OUT_WIDTH(BIT_WIDTH_ACC)) O8(
    .clk(clk), // Clock
    .en(en_OutputAccumulator && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convOut8[0]),
    .in2(convOut8[1]),
    .in3(convOut8[2]),
    .in4(convOut8[3]),
    .in5(convOut8[4]),
    .in6(convOut8[5]),
    .bias(bias[7]),
    .AccumulatorValue(AccumulatorValue8) // Output value
);
//input:35bits , output:8bits
ReLU #(.BIT_WIDTH(BIT_WIDTH_ACC), .SHIFT(9)) r8(
	.in(AccumulatorValue8),
	.out(reluOut8)
);
///////////////////////////////////////////////////////////////////////////////////////////////c2-9
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c91(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn1[0]),
    .in2(convIn1[1]),
    .in3(convIn1[2]),
    .in4(convIn1[3]),
    .in5(convIn1[4]),
    .in6(convIn1[5]),
    .in7(convIn1[6]),
    .in8(convIn1[7]),
    .in9(convIn1[8]),
    .w1(weight_data_9[0]),
    .w2(weight_data_9[1]),
    .w3(weight_data_9[2]),
    .w4(weight_data_9[3]),
    .w5(weight_data_9[4]),
    .w6(weight_data_9[5]),
    .w7(weight_data_9[6]),
    .w8(weight_data_9[7]),
    .w9(weight_data_9[8]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut9[0]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c92(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn2[0]),
    .in2(convIn2[1]),
    .in3(convIn2[2]),
    .in4(convIn2[3]),
    .in5(convIn2[4]),
    .in6(convIn2[5]),
    .in7(convIn2[6]),
    .in8(convIn2[7]),
    .in9(convIn2[8]),
    .w1(weight_data_9[9]),
    .w2(weight_data_9[10]),
    .w3(weight_data_9[11]),
    .w4(weight_data_9[12]),
    .w5(weight_data_9[13]),
    .w6(weight_data_9[14]),
    .w7(weight_data_9[15]),
    .w8(weight_data_9[16]),
    .w9(weight_data_9[17]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut9[1]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c93(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn3[0]),
    .in2(convIn3[1]),
    .in3(convIn3[2]),
    .in4(convIn3[3]),
    .in5(convIn3[4]),
    .in6(convIn3[5]),
    .in7(convIn3[6]),
    .in8(convIn3[7]),
    .in9(convIn3[8]),
    .w1(weight_data_9[18]),
    .w2(weight_data_9[19]),
    .w3(weight_data_9[20]),
    .w4(weight_data_9[21]),
    .w5(weight_data_9[22]),
    .w6(weight_data_9[23]),
    .w7(weight_data_9[24]),
    .w8(weight_data_9[25]),
    .w9(weight_data_9[26]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut9[2]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c94(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn4[0]),
    .in2(convIn4[1]),
    .in3(convIn4[2]),
    .in4(convIn4[3]),
    .in5(convIn4[4]),
    .in6(convIn4[5]),
    .in7(convIn4[6]),
    .in8(convIn4[7]),
    .in9(convIn4[8]),
    .w1(weight_data_9[27]),
    .w2(weight_data_9[28]),
    .w3(weight_data_9[29]),
    .w4(weight_data_9[30]),
    .w5(weight_data_9[31]),
    .w6(weight_data_9[32]),
    .w7(weight_data_9[33]),
    .w8(weight_data_9[34]),
    .w9(weight_data_9[35]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut9[3]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c95(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn5[0]),
    .in2(convIn5[1]),
    .in3(convIn5[2]),
    .in4(convIn5[3]),
    .in5(convIn5[4]),
    .in6(convIn5[5]),
    .in7(convIn5[6]),
    .in8(convIn5[7]),
    .in9(convIn5[8]),
    .w1(weight_data_9[36]),
    .w2(weight_data_9[37]),
    .w3(weight_data_9[38]),
    .w4(weight_data_9[39]),
    .w5(weight_data_9[40]),
    .w6(weight_data_9[41]),
    .w7(weight_data_9[42]),
    .w8(weight_data_9[43]),
    .w9(weight_data_9[44]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut9[4]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c96(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn6[0]),
    .in2(convIn6[1]),
    .in3(convIn6[2]),
    .in4(convIn6[3]),
    .in5(convIn6[4]),
    .in6(convIn6[5]),
    .in7(convIn6[6]),
    .in8(convIn6[7]),
    .in9(convIn6[8]),
    .w1(weight_data_9[45]),
    .w2(weight_data_9[46]),
    .w3(weight_data_9[47]),
    .w4(weight_data_9[48]),
    .w5(weight_data_9[49]),
    .w6(weight_data_9[50]),
    .w7(weight_data_9[51]),
    .w8(weight_data_9[52]),
    .w9(weight_data_9[53]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut9[5]) // Output value
);
OutputAccumulator #(.BIT_WIDTH(BIT_WIDTH_32), .OUT_WIDTH(BIT_WIDTH_ACC)) O9(
    .clk(clk), // Clock
    .en(en_OutputAccumulator && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convOut9[0]),
    .in2(convOut9[1]),
    .in3(convOut9[2]),
    .in4(convOut9[3]),
    .in5(convOut9[4]),
    .in6(convOut9[5]),
    .bias(bias[8]),
    .AccumulatorValue(AccumulatorValue9) // Output value
);
//input:35bits , output:8bits
ReLU #(.BIT_WIDTH(BIT_WIDTH_ACC), .SHIFT(9)) r9(
	.in(AccumulatorValue9),
	.out(reluOut9)
);
///////////////////////////////////////////////////////////////////////////////////////////////c2-10
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c101(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn1[0]),
    .in2(convIn1[1]),
    .in3(convIn1[2]),
    .in4(convIn1[3]),
    .in5(convIn1[4]),
    .in6(convIn1[5]),
    .in7(convIn1[6]),
    .in8(convIn1[7]),
    .in9(convIn1[8]),
    .w1(weight_data_10[0]),
    .w2(weight_data_10[1]),
    .w3(weight_data_10[2]),
    .w4(weight_data_10[3]),
    .w5(weight_data_10[4]),
    .w6(weight_data_10[5]),
    .w7(weight_data_10[6]),
    .w8(weight_data_10[7]),
    .w9(weight_data_10[8]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut10[0]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c102(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn2[0]),
    .in2(convIn2[1]),
    .in3(convIn2[2]),
    .in4(convIn2[3]),
    .in5(convIn2[4]),
    .in6(convIn2[5]),
    .in7(convIn2[6]),
    .in8(convIn2[7]),
    .in9(convIn2[8]),
    .w1(weight_data_10[9]),
    .w2(weight_data_10[10]),
    .w3(weight_data_10[11]),
    .w4(weight_data_10[12]),
    .w5(weight_data_10[13]),
    .w6(weight_data_10[14]),
    .w7(weight_data_10[15]),
    .w8(weight_data_10[16]),
    .w9(weight_data_10[17]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut10[1]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c103(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn3[0]),
    .in2(convIn3[1]),
    .in3(convIn3[2]),
    .in4(convIn3[3]),
    .in5(convIn3[4]),
    .in6(convIn3[5]),
    .in7(convIn3[6]),
    .in8(convIn3[7]),
    .in9(convIn3[8]),
    .w1(weight_data_10[18]),
    .w2(weight_data_10[19]),
    .w3(weight_data_10[20]),
    .w4(weight_data_10[21]),
    .w5(weight_data_10[22]),
    .w6(weight_data_10[23]),
    .w7(weight_data_10[24]),
    .w8(weight_data_10[25]),
    .w9(weight_data_10[26]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut10[2]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c104(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn4[0]),
    .in2(convIn4[1]),
    .in3(convIn4[2]),
    .in4(convIn4[3]),
    .in5(convIn4[4]),
    .in6(convIn4[5]),
    .in7(convIn4[6]),
    .in8(convIn4[7]),
    .in9(convIn4[8]),
    .w1(weight_data_10[27]),
    .w2(weight_data_10[28]),
    .w3(weight_data_10[29]),
    .w4(weight_data_10[30]),
    .w5(weight_data_10[31]),
    .w6(weight_data_10[32]),
    .w7(weight_data_10[33]),
    .w8(weight_data_10[34]),
    .w9(weight_data_10[35]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut10[3]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c105(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn5[0]),
    .in2(convIn5[1]),
    .in3(convIn5[2]),
    .in4(convIn5[3]),
    .in5(convIn5[4]),
    .in6(convIn5[5]),
    .in7(convIn5[6]),
    .in8(convIn5[7]),
    .in9(convIn5[8]),
    .w1(weight_data_10[36]),
    .w2(weight_data_10[37]),
    .w3(weight_data_10[38]),
    .w4(weight_data_10[39]),
    .w5(weight_data_10[40]),
    .w6(weight_data_10[41]),
    .w7(weight_data_10[42]),
    .w8(weight_data_10[43]),
    .w9(weight_data_10[44]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut10[4]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c106(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn6[0]),
    .in2(convIn6[1]),
    .in3(convIn6[2]),
    .in4(convIn6[3]),
    .in5(convIn6[4]),
    .in6(convIn6[5]),
    .in7(convIn6[6]),
    .in8(convIn6[7]),
    .in9(convIn6[8]),
    .w1(weight_data_10[45]),
    .w2(weight_data_10[46]),
    .w3(weight_data_10[47]),
    .w4(weight_data_10[48]),
    .w5(weight_data_10[49]),
    .w6(weight_data_10[50]),
    .w7(weight_data_10[51]),
    .w8(weight_data_10[52]),
    .w9(weight_data_10[53]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut10[5]) // Output value
);
OutputAccumulator #(.BIT_WIDTH(BIT_WIDTH_32), .OUT_WIDTH(BIT_WIDTH_ACC)) O10(
    .clk(clk), // Clock
    .en(en_OutputAccumulator && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convOut10[0]),
    .in2(convOut10[1]),
    .in3(convOut10[2]),
    .in4(convOut10[3]),
    .in5(convOut10[4]),
    .in6(convOut10[5]),
    .bias(bias[9]),
    .AccumulatorValue(AccumulatorValue10) // Output value
);
//input:35bits , output:8bits
ReLU #(.BIT_WIDTH(BIT_WIDTH_ACC), .SHIFT(9)) r10(
	.in(AccumulatorValue10),
	.out(reluOut10)
);
///////////////////////////////////////////////////////////////////////////////////////////////c2-11
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c111(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn1[0]),
    .in2(convIn1[1]),
    .in3(convIn1[2]),
    .in4(convIn1[3]),
    .in5(convIn1[4]),
    .in6(convIn1[5]),
    .in7(convIn1[6]),
    .in8(convIn1[7]),
    .in9(convIn1[8]),
    .w1(weight_data_11[0]),
    .w2(weight_data_11[1]),
    .w3(weight_data_11[2]),
    .w4(weight_data_11[3]),
    .w5(weight_data_11[4]),
    .w6(weight_data_11[5]),
    .w7(weight_data_11[6]),
    .w8(weight_data_11[7]),
    .w9(weight_data_11[8]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut11[0]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c112(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn2[0]),
    .in2(convIn2[1]),
    .in3(convIn2[2]),
    .in4(convIn2[3]),
    .in5(convIn2[4]),
    .in6(convIn2[5]),
    .in7(convIn2[6]),
    .in8(convIn2[7]),
    .in9(convIn2[8]),
    .w1(weight_data_11[9]),
    .w2(weight_data_11[10]),
    .w3(weight_data_11[11]),
    .w4(weight_data_11[12]),
    .w5(weight_data_11[13]),
    .w6(weight_data_11[14]),
    .w7(weight_data_11[15]),
    .w8(weight_data_11[16]),
    .w9(weight_data_11[17]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut11[1]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c113(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn3[0]),
    .in2(convIn3[1]),
    .in3(convIn3[2]),
    .in4(convIn3[3]),
    .in5(convIn3[4]),
    .in6(convIn3[5]),
    .in7(convIn3[6]),
    .in8(convIn3[7]),
    .in9(convIn3[8]),
    .w1(weight_data_11[18]),
    .w2(weight_data_11[19]),
    .w3(weight_data_11[20]),
    .w4(weight_data_11[21]),
    .w5(weight_data_11[22]),
    .w6(weight_data_11[23]),
    .w7(weight_data_11[24]),
    .w8(weight_data_11[25]),
    .w9(weight_data_11[26]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut11[2]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c114(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn4[0]),
    .in2(convIn4[1]),
    .in3(convIn4[2]),
    .in4(convIn4[3]),
    .in5(convIn4[4]),
    .in6(convIn4[5]),
    .in7(convIn4[6]),
    .in8(convIn4[7]),
    .in9(convIn4[8]),
    .w1(weight_data_11[27]),
    .w2(weight_data_11[28]),
    .w3(weight_data_11[29]),
    .w4(weight_data_11[30]),
    .w5(weight_data_11[31]),
    .w6(weight_data_11[32]),
    .w7(weight_data_11[33]),
    .w8(weight_data_11[34]),
    .w9(weight_data_11[35]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut11[3]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c115(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn5[0]),
    .in2(convIn5[1]),
    .in3(convIn5[2]),
    .in4(convIn5[3]),
    .in5(convIn5[4]),
    .in6(convIn5[5]),
    .in7(convIn5[6]),
    .in8(convIn5[7]),
    .in9(convIn5[8]),
    .w1(weight_data_11[36]),
    .w2(weight_data_11[37]),
    .w3(weight_data_11[38]),
    .w4(weight_data_11[39]),
    .w5(weight_data_11[40]),
    .w6(weight_data_11[41]),
    .w7(weight_data_11[42]),
    .w8(weight_data_11[43]),
    .w9(weight_data_11[44]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut11[4]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c116(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn6[0]),
    .in2(convIn6[1]),
    .in3(convIn6[2]),
    .in4(convIn6[3]),
    .in5(convIn6[4]),
    .in6(convIn6[5]),
    .in7(convIn6[6]),
    .in8(convIn6[7]),
    .in9(convIn6[8]),
    .w1(weight_data_11[45]),
    .w2(weight_data_11[46]),
    .w3(weight_data_11[47]),
    .w4(weight_data_11[48]),
    .w5(weight_data_11[49]),
    .w6(weight_data_11[50]),
    .w7(weight_data_11[51]),
    .w8(weight_data_11[52]),
    .w9(weight_data_11[53]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut11[5]) // Output value
);
OutputAccumulator #(.BIT_WIDTH(BIT_WIDTH_32), .OUT_WIDTH(BIT_WIDTH_ACC)) O11(
    .clk(clk), // Clock
    .en(en_OutputAccumulator && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convOut11[0]),
    .in2(convOut11[1]),
    .in3(convOut11[2]),
    .in4(convOut11[3]),
    .in5(convOut11[4]),
    .in6(convOut11[5]),
    .bias(bias[10]),
    .AccumulatorValue(AccumulatorValue11) // Output value
);
//input:35bits , output:8bits
ReLU #(.BIT_WIDTH(BIT_WIDTH_ACC), .SHIFT(9)) r11(
	.in(AccumulatorValue11),
	.out(reluOut11)
);
///////////////////////////////////////////////////////////////////////////////////////////////c2-12
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c121(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn1[0]),
    .in2(convIn1[1]),
    .in3(convIn1[2]),
    .in4(convIn1[3]),
    .in5(convIn1[4]),
    .in6(convIn1[5]),
    .in7(convIn1[6]),
    .in8(convIn1[7]),
    .in9(convIn1[8]),
    .w1(weight_data_12[0]),
    .w2(weight_data_12[1]),
    .w3(weight_data_12[2]),
    .w4(weight_data_12[3]),
    .w5(weight_data_12[4]),
    .w6(weight_data_12[5]),
    .w7(weight_data_12[6]),
    .w8(weight_data_12[7]),
    .w9(weight_data_12[8]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut12[0]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c122(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn2[0]),
    .in2(convIn2[1]),
    .in3(convIn2[2]),
    .in4(convIn2[3]),
    .in5(convIn2[4]),
    .in6(convIn2[5]),
    .in7(convIn2[6]),
    .in8(convIn2[7]),
    .in9(convIn2[8]),
    .w1(weight_data_12[9]),
    .w2(weight_data_12[10]),
    .w3(weight_data_12[11]),
    .w4(weight_data_12[12]),
    .w5(weight_data_12[13]),
    .w6(weight_data_12[14]),
    .w7(weight_data_12[15]),
    .w8(weight_data_12[16]),
    .w9(weight_data_12[17]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut12[1]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c123(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn3[0]),
    .in2(convIn3[1]),
    .in3(convIn3[2]),
    .in4(convIn3[3]),
    .in5(convIn3[4]),
    .in6(convIn3[5]),
    .in7(convIn3[6]),
    .in8(convIn3[7]),
    .in9(convIn3[8]),
    .w1(weight_data_12[18]),
    .w2(weight_data_12[19]),
    .w3(weight_data_12[20]),
    .w4(weight_data_12[21]),
    .w5(weight_data_12[22]),
    .w6(weight_data_12[23]),
    .w7(weight_data_12[24]),
    .w8(weight_data_12[25]),
    .w9(weight_data_12[26]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut12[2]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c124(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn4[0]),
    .in2(convIn4[1]),
    .in3(convIn4[2]),
    .in4(convIn4[3]),
    .in5(convIn4[4]),
    .in6(convIn4[5]),
    .in7(convIn4[6]),
    .in8(convIn4[7]),
    .in9(convIn4[8]),
    .w1(weight_data_12[27]),
    .w2(weight_data_12[28]),
    .w3(weight_data_12[29]),
    .w4(weight_data_12[30]),
    .w5(weight_data_12[31]),
    .w6(weight_data_12[32]),
    .w7(weight_data_12[33]),
    .w8(weight_data_12[34]),
    .w9(weight_data_12[35]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut12[3]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c125(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn5[0]),
    .in2(convIn5[1]),
    .in3(convIn5[2]),
    .in4(convIn5[3]),
    .in5(convIn5[4]),
    .in6(convIn5[5]),
    .in7(convIn5[6]),
    .in8(convIn5[7]),
    .in9(convIn5[8]),
    .w1(weight_data_12[36]),
    .w2(weight_data_12[37]),
    .w3(weight_data_12[38]),
    .w4(weight_data_12[39]),
    .w5(weight_data_12[40]),
    .w6(weight_data_12[41]),
    .w7(weight_data_12[42]),
    .w8(weight_data_12[43]),
    .w9(weight_data_12[44]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut12[4]) // Output value
);
conv33 #(.BIT_WIDTH(BIT_WIDTH_8), .OUT_WIDTH(BIT_WIDTH_32)) c126(
    .clk(clk), // Clock
    .en(en_c2 && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convIn6[0]),
    .in2(convIn6[1]),
    .in3(convIn6[2]),
    .in4(convIn6[3]),
    .in5(convIn6[4]),
    .in6(convIn6[5]),
    .in7(convIn6[6]),
    .in8(convIn6[7]),
    .in9(convIn6[8]),
    .w1(weight_data_12[45]),
    .w2(weight_data_12[46]),
    .w3(weight_data_12[47]),
    .w4(weight_data_12[48]),
    .w5(weight_data_12[49]),
    .w6(weight_data_12[50]),
    .w7(weight_data_12[51]),
    .w8(weight_data_12[52]),
    .w9(weight_data_12[53]), // 3x3 filter
    .bias(8'b0),       // Bias value
    .convValue(convOut12[5]) // Output value
);
OutputAccumulator #(.BIT_WIDTH(BIT_WIDTH_32), .OUT_WIDTH(BIT_WIDTH_ACC)) O12(
    .clk(clk), // Clock
    .en(en_OutputAccumulator && ce_2),  // Enable
    .rst_n(rst_n),
    .in1(convOut12[0]),
    .in2(convOut12[1]),
    .in3(convOut12[2]),
    .in4(convOut12[3]),
    .in5(convOut12[4]),
    .in6(convOut12[5]),
    .bias(bias[11]),
    .AccumulatorValue(AccumulatorValue12) // Output value
);
//input:35bits , output:8bits
ReLU #(.BIT_WIDTH(BIT_WIDTH_ACC), .SHIFT(9)) r12(
	.in(AccumulatorValue12),
	.out(reluOut12)
);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////    maxpooling   buffer/////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
wire [7:0] maxPoolingIn1 [0:3];
wire [7:0] maxPoolingIn2 [0:3];
wire [7:0] maxPoolingIn3 [0:3];
wire [7:0] maxPoolingIn4 [0:3];
wire [7:0] maxPoolingIn5 [0:3];
wire [7:0] maxPoolingIn6 [0:3];
wire [7:0] maxPoolingIn7 [0:3];
wire [7:0] maxPoolingIn8 [0:3];
wire [7:0] maxPoolingIn9 [0:3];
wire [7:0] maxPoolingIn10 [0:3];
wire [7:0] maxPoolingIn11 [0:3];
wire [7:0] maxPoolingIn12 [0:3];
//
Pooling_buffer_2 p1(
    .clk(clk),
    .rst_n(rst_n),
    .en(en_bf_max && ce_2),
    .in_data(reluOut1),
    .out1(maxPoolingIn1[0]),
    .out2(maxPoolingIn1[1]),
    .out3(maxPoolingIn1[2]),
    .out4(maxPoolingIn1[3])
);
Pooling_buffer_2 p2(
    .clk(clk),
    .rst_n(rst_n),
    .en(en_bf_max && ce_2),
    .in_data(reluOut2),
    .out1(maxPoolingIn2[0]),
    .out2(maxPoolingIn2[1]),
    .out3(maxPoolingIn2[2]),
    .out4(maxPoolingIn2[3])
);
Pooling_buffer_2 p3(
    .clk(clk),
    .rst_n(rst_n),
    .en(en_bf_max && ce_2),
    .in_data(reluOut3),
    .out1(maxPoolingIn3[0]),
    .out2(maxPoolingIn3[1]),
    .out3(maxPoolingIn3[2]),
    .out4(maxPoolingIn3[3])
);
Pooling_buffer_2 p4(
    .clk(clk),
    .rst_n(rst_n),
    .en(en_bf_max && ce_2),
    .in_data(reluOut4),
    .out1(maxPoolingIn4[0]),
    .out2(maxPoolingIn4[1]),
    .out3(maxPoolingIn4[2]),
    .out4(maxPoolingIn4[3])
);
Pooling_buffer_2 p5(
    .clk(clk),
    .rst_n(rst_n),
    .en(en_bf_max && ce_2),
    .in_data(reluOut5),
    .out1(maxPoolingIn5[0]),
    .out2(maxPoolingIn5[1]),
    .out3(maxPoolingIn5[2]),
    .out4(maxPoolingIn5[3])
);
Pooling_buffer_2 p6(
    .clk(clk),
    .rst_n(rst_n),
    .en(en_bf_max && ce_2),
    .in_data(reluOut6),
    .out1(maxPoolingIn6[0]),
    .out2(maxPoolingIn6[1]),
    .out3(maxPoolingIn6[2]),
    .out4(maxPoolingIn6[3])
);
Pooling_buffer_2 p7(
    .clk(clk),
    .rst_n(rst_n),
    .en(en_bf_max && ce_2),
    .in_data(reluOut7),
    .out1(maxPoolingIn7[0]),
    .out2(maxPoolingIn7[1]),
    .out3(maxPoolingIn7[2]),
    .out4(maxPoolingIn7[3])
);
Pooling_buffer_2 p8(
    .clk(clk),
    .rst_n(rst_n),
    .en(en_bf_max && ce_2),
    .in_data(reluOut8),
    .out1(maxPoolingIn8[0]),
    .out2(maxPoolingIn8[1]),
    .out3(maxPoolingIn8[2]),
    .out4(maxPoolingIn8[3])
);
Pooling_buffer_2 p9(
    .clk(clk),
    .rst_n(rst_n),
    .en(en_bf_max && ce_2),
    .in_data(reluOut9),
    .out1(maxPoolingIn9[0]),
    .out2(maxPoolingIn9[1]),
    .out3(maxPoolingIn9[2]),
    .out4(maxPoolingIn9[3])
);
Pooling_buffer_2 p10(
    .clk(clk),
    .rst_n(rst_n),
    .en(en_bf_max && ce_2),
    .in_data(reluOut10),
    .out1(maxPoolingIn10[0]),
    .out2(maxPoolingIn10[1]),
    .out3(maxPoolingIn10[2]),
    .out4(maxPoolingIn10[3])
);
Pooling_buffer_2 p11(
    .clk(clk),
    .rst_n(rst_n),
    .en(en_bf_max && ce_2),
    .in_data(reluOut11),
    .out1(maxPoolingIn11[0]),
    .out2(maxPoolingIn11[1]),
    .out3(maxPoolingIn11[2]),
    .out4(maxPoolingIn11[3])
);
Pooling_buffer_2 p12(
    .clk(clk),
    .rst_n(rst_n),
    .en(en_bf_max && ce_2),
    .in_data(reluOut12),
    .out1(maxPoolingIn12[0]),
    .out2(maxPoolingIn12[1]),
    .out3(maxPoolingIn12[2]),
    .out4(maxPoolingIn12[3])
);
////////////////////////////////////////////////////maxpooling//////////////////////////////////////////////
//out:6*6*12
maxpooling #(.BIT_WIDTH(BIT_WIDTH_8))m1(
	.clk(clk),
	.en(en_max2 && ce_2),
	.rst_n(rst_n),
	.in1(maxPoolingIn1[0]),
    .in2(maxPoolingIn1[1]),
    .in3(maxPoolingIn1[2]),
    .in4(maxPoolingIn1[3]),
	.max(out1)
);
maxpooling #(.BIT_WIDTH(BIT_WIDTH_8))m2(
	.clk(clk),
	.en(en_max2 && ce_2),
	.rst_n(rst_n),
	.in1(maxPoolingIn2[0]),
    .in2(maxPoolingIn2[1]),
    .in3(maxPoolingIn2[2]),
    .in4(maxPoolingIn2[3]),
	.max(out2)
);
maxpooling #(.BIT_WIDTH(BIT_WIDTH_8))m3(
	.clk(clk),
	.en(en_max2 && ce_2),
	.rst_n(rst_n),
	.in1(maxPoolingIn3[0]),
    .in2(maxPoolingIn3[1]),
    .in3(maxPoolingIn3[2]),
    .in4(maxPoolingIn3[3]),
	.max(out3)
);
maxpooling #(.BIT_WIDTH(BIT_WIDTH_8))m4(
	.clk(clk),
	.en(en_max2 && ce_2),
	.rst_n(rst_n),
	.in1(maxPoolingIn4[0]),
    .in2(maxPoolingIn4[1]),
    .in3(maxPoolingIn4[2]),
    .in4(maxPoolingIn4[3]),
	.max(out4)
);
maxpooling #(.BIT_WIDTH(BIT_WIDTH_8))m5(
	.clk(clk),
	.en(en_max2 && ce_2),
	.rst_n(rst_n),
	.in1(maxPoolingIn5[0]),
    .in2(maxPoolingIn5[1]),
    .in3(maxPoolingIn5[2]),
    .in4(maxPoolingIn5[3]),
	.max(out5)
);
maxpooling #(.BIT_WIDTH(BIT_WIDTH_8))m6(
	.clk(clk),
	.en(en_max2 && ce_2),
	.rst_n(rst_n),
	.in1(maxPoolingIn6[0]),
    .in2(maxPoolingIn6[1]),
    .in3(maxPoolingIn6[2]),
    .in4(maxPoolingIn6[3]),
	.max(out6)
);
maxpooling #(.BIT_WIDTH(BIT_WIDTH_8))m7(
	.clk(clk),
	.en(en_max2 && ce_2),
	.rst_n(rst_n),
	.in1(maxPoolingIn7[0]),
    .in2(maxPoolingIn7[1]),
    .in3(maxPoolingIn7[2]),
    .in4(maxPoolingIn7[3]),
	.max(out7)
);
maxpooling #(.BIT_WIDTH(BIT_WIDTH_8))m8(
	.clk(clk),
	.en(en_max2 && ce_2),
	.rst_n(rst_n),
	.in1(maxPoolingIn8[0]),
    .in2(maxPoolingIn8[1]),
    .in3(maxPoolingIn8[2]),
    .in4(maxPoolingIn8[3]),
	.max(out8)
);
maxpooling #(.BIT_WIDTH(BIT_WIDTH_8))m9(
	.clk(clk),
	.en(en_max2 && ce_2),
	.rst_n(rst_n),
	.in1(maxPoolingIn9[0]),
    .in2(maxPoolingIn9[1]),
    .in3(maxPoolingIn9[2]),
    .in4(maxPoolingIn9[3]),
	.max(out9)
);
maxpooling #(.BIT_WIDTH(BIT_WIDTH_8))m10(
	.clk(clk),
	.en(en_max2 && ce_2),
	.rst_n(rst_n),
	.in1(maxPoolingIn10[0]),
    .in2(maxPoolingIn10[1]),
    .in3(maxPoolingIn10[2]),
    .in4(maxPoolingIn10[3]),
	.max(out10)
);
maxpooling #(.BIT_WIDTH(BIT_WIDTH_8))m11(
	.clk(clk),
	.en(en_max2 && ce_2),
	.rst_n(rst_n),
	.in1(maxPoolingIn11[0]),
    .in2(maxPoolingIn11[1]),
    .in3(maxPoolingIn11[2]),
    .in4(maxPoolingIn11[3]),
	.max(out11)
);
maxpooling #(.BIT_WIDTH(BIT_WIDTH_8))m12(
	.clk(clk),
	.en(en_max2 && ce_2),
	.rst_n(rst_n),
	.in1(maxPoolingIn12[0]),
    .in2(maxPoolingIn12[1]),
    .in3(maxPoolingIn12[2]),
    .in4(maxPoolingIn12[3]),
	.max(out12)
);

integer i, j;
integer load_reset_index;
reg [3:0] load_group;
reg [5:0] load_offset;
reg [9:0] cycle_counter;
reg [2:0] delayCount;
reg delayCount_acc;
reg stall;

//////////////////////////////////////////////////////Load Data/////////////////////////////////////////////
//reg [9:0] addra_c2;
//wire [7:0] douta_c2;
//reg  ena_c2;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (load_reset_index = 0; load_reset_index < 54; load_reset_index = load_reset_index + 1) begin
                weight_data_1[load_reset_index] <= 0;
                weight_data_2[load_reset_index] <= 0;
                weight_data_3[load_reset_index] <= 0;
                weight_data_4[load_reset_index] <= 0;
                weight_data_5[load_reset_index] <= 0;
                weight_data_6[load_reset_index] <= 0;
                weight_data_7[load_reset_index] <= 0;
                weight_data_8[load_reset_index] <= 0;
                weight_data_9[load_reset_index] <= 0;
                weight_data_10[load_reset_index] <= 0;
                weight_data_11[load_reset_index] <= 0;
                weight_data_12[load_reset_index] <= 0;
            end
            for (load_reset_index = 0; load_reset_index < 12; load_reset_index = load_reset_index + 1) begin
                bias[load_reset_index] <= 0;
            end
        ena_c2 <= 0;
        addra_c2 <= 0;
        load_group <= 0;
        load_offset <= 0;
        i <= 0;

    end else begin
    if(load_weight)begin
        ena_c2 <= (i < 660);
        if(i < 660) begin
            addra_c2 <= i;
        end
        if((i < 663) && (i > 2)) begin
            if (load_offset == 54) begin
                bias[load_group] <= douta_c2;
                load_offset <= 0;
                load_group <= load_group + 1;
            end else begin
                case (load_group)
                    4'd0:  weight_data_1[load_offset] <= douta_c2;
                    4'd1:  weight_data_2[load_offset] <= douta_c2;
                    4'd2:  weight_data_3[load_offset] <= douta_c2;
                    4'd3:  weight_data_4[load_offset] <= douta_c2;
                    4'd4:  weight_data_5[load_offset] <= douta_c2;
                    4'd5:  weight_data_6[load_offset] <= douta_c2;
                    4'd6:  weight_data_7[load_offset] <= douta_c2;
                    4'd7:  weight_data_8[load_offset] <= douta_c2;
                    4'd8:  weight_data_9[load_offset] <= douta_c2;
                    4'd9:  weight_data_10[load_offset] <= douta_c2;
                    4'd10: weight_data_11[load_offset] <= douta_c2;
                    4'd11: weight_data_12[load_offset] <= douta_c2;
                    default: ;
                endcase
                load_offset <= load_offset + 1;
            end
        end
        i <= i + 1;
    end else begin
        ena_c2 <= 0;
    end
    end
end

///////////////////////////////////////////////////////////////////////////////////////////////////////////

//inputBuffer: (14 + 14 + 3)cycle 開始送資料 1個cycle送一筆
//conv33: 12*12 + 1bias (+1reset) = 145 + 1cycle
//acc: 1 cycle
//maxBuffer: (12 + 2)cycle 開始送資料 2個cycle送一筆
//maxpooling: size 6*6 = 36次
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        en_bf <= 0;
    end else begin
    if (en) begin
            if (j < 197 && !start) begin
                en_bf <= 1;
            end else begin
                en_bf <= 0;
            end
    end
    end
end
always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            j <= 0;
            cycle_counter <= 0;
            stall <= 0;
            en_c2 <= 0;
            en_OutputAccumulator <= 0;
            //en_bf <= 0;
            delayCount <= 3;
            start <= 0;

        end else if (ce_2 && en) begin
            if (j < 197 && !start) begin
                //en_bf <= 1;
                delayCount_acc <= 1;
                if (j > 29) begin
                    if (stall) begin
                        cycle_counter <= cycle_counter + 1;
                        if (cycle_counter == 1) begin  //18*2
                            stall <= 0;
                            cycle_counter <= 0;
                        end
                    end else begin
                        if (cycle_counter == 11) begin  //12
                            stall <= 1;
                            cycle_counter <= 0;
                        end else begin
                            cycle_counter <= cycle_counter + 1;
                        end
                    end
                    if (en_c2) begin
                            en_OutputAccumulator <= 1; // 準備
                    end else begin
                        en_OutputAccumulator <= 0;
                    end
                    if (!stall) begin
                        en_c2 <= 1; // c1 每12個週期 stall 2週期
                    end else begin
                        en_c2 <= 0;
                    end
                end
            end else begin
                   // en_bf <= 0;
                    en_c2 <= 0;
                    en_OutputAccumulator <= 0;
                end
            j = j + 1;
        end else if (ce_2) begin      ////處理時序問題
            if( (j>29) && (delayCount_acc == 1))begin
                en_OutputAccumulator <= 1;
            end else if((j > 193) && (delayCount > 2))begin
                en_OutputAccumulator <= 1;
            end else begin
                en_OutputAccumulator <= 0;
            end
            if((j > 193) && (delayCount > 3))begin
                en_c2 <= 1;
            end else begin
                en_c2 <= 0;
            end
            //en_bf <= 0;
            if( (j > 29) && (delayCount_acc > 0) ) delayCount_acc <= delayCount_acc - 1;
            if( (j > 194) && (delayCount > 0) ) delayCount = delayCount - 1;
        end
end

always @(posedge clk or negedge rst_n) begin  //controll maxpooling buffer
    if(!rst_n)begin
        en_bf_max <= 0;
    end else if (ce_2) begin
    if(en_OutputAccumulator)begin
        en_bf_max <= 1;
    end else begin
        en_bf_max <= 0;
    end
    end
end

assign stall_out = en_bf_max;

reg [3:0] en_max2_counter;      //14個dalay後開始
reg [3:0] en_max2_stall_counter;   //12後換排
reg [3:0] en_max2_stall_delay_counter;  //進行12個delay
//reg max2_stall;

always @(posedge clk or negedge rst_n) begin  //controll max
    if(!rst_n)begin
        ready <= 0;
        en_max2 <= 0;
        en_max2_counter <= 12 ;
        en_max2_stall_counter <= 12;
        en_max2_stall_delay_counter <= 11;
    end else if (ce_2) begin
    if(en_bf_max)begin
        if(en_max2_stall_counter == 0)begin
            en_max2 <= 0;
            en_max2_stall_delay_counter <= en_max2_stall_delay_counter - 1;
            if (en_max2_stall_delay_counter == 0)begin
                en_max2_stall_counter <= 12;
                en_max2_stall_delay_counter <= 11;
            end
        end else if(en_max2_counter == 0) begin
            en_max2 = ~en_max2;
            en_max2_stall_counter = en_max2_stall_counter - 1;
            if(en_max2) ready <= 1;
        end
        if(en_max2_counter > 0) begin
            en_max2_counter <= en_max2_counter - 1;
        end

    end else begin
        en_max2 <= 0;
    end
    end
end

endmodule
