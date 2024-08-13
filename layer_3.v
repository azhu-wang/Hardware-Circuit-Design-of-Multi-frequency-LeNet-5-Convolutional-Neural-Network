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

wire o_clk;

div4  d1(                //除頻器除4 因為前兩級有兩個maxpooling
	.clk(clk),
	.rst_n(rst_n),
	.o_clk(o_clk)
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
wire [31:0]convOut[0:1];     //每個map輸入一致
//C1   2層
///////////////////////////////////////////////////////////////////////////////////////////////////////////
conv11 #(.BIT_WIDTH(BIT_WIDTH), .OUT_WIDTH(BIT_WIDTH_32)) c1(  //並行卷積需要兩個
    .clk(o_clk), // Clock 
    .en(en_c1),  // Enable 
    .rst_n(rst_n), //reset
    .in1(map1), 
    .in2(map2), 
    .in3(map3), 
    .in4(map4), 
    .in5(map5), 
    .in6(map6), 
    .in7(map7), 
    .in8(map8), 
    .in9(map9), 
    .in10(map10), 
    .in11(map11), 
    .in12(map12), //36次
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
    .clk(o_clk), // Clock 
    .en(en_c1),  // Enable 
    .rst_n(rst_n), //reset
    .in1(map1), 
    .in2(map2), 
    .in3(map3), 
    .in4(map4), 
    .in5(map5), 
    .in6(map6), 
    .in7(map7), 
    .in8(map8), 
    .in9(map9), 
    .in10(map10), 
    .in11(map11), 
    .in12(map12), //36次
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
ReLU #(.BIT_WIDTH(BIT_WIDTH_32)) r1(
	.in(convOut[0]),
	.out(reluOut[0])
);
ReLU #(.BIT_WIDTH(BIT_WIDTH_32)) r2(
	.in(convOut[1]),
	.out(reluOut[1])
);
//////////////////////////////////////////////FC////////////////////////////////////////////////////////////
//input:8bits , output:32bits
fully_connected #(.BIT_WIDTH(8),.OUT_WIDTH(32)) fc1(
    .clk(o_clk), // Clock 
    .en(en_fc),  // Enable 
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
    .clk(o_clk), // Clock 
    .en(en_fc),  // Enable 
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
    .clk(o_clk), // Clock 
    .en(en_fc),  // Enable 
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
    .clk(o_clk), // Clock 
    .en(en_fc),  // Enable 
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
    .clk(o_clk), // Clock 
    .en(en_fc),  // Enable 
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
    .clk(o_clk), // Clock 
    .en(en_fc),  // Enable 
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
    .clk(o_clk), // Clock 
    .en(en_fc),  // Enable 
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
    .clk(o_clk), // Clock 
    .en(en_fc),  // Enable 
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
    .clk(o_clk), // Clock 
    .en(en_fc),  // Enable 
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
    .clk(o_clk), // Clock 
    .en(en_fc),  // Enable 
    .rst_n(rst_n),
    .in1(reluOut[0]),
    .in2(reluOut[1]),
    .weight1(weight_data_fc1[9]), 
    .weight2(weight_data_fc2[9]),
    .bias(bias_fc[9]),   // Bias value
    .ready(),
    .Value(out10) // Output value
);

integer i, j,m;
reg [4:0] cycle_counter;
localparam TOTAL_LENGTH = NUM_SEGMENTS * 2 * SEGMENT_LENGTH;
parameter NUM_SEGMENTS = 20;
parameter SEGMENT_LENGTH = 36;
reg [15:0] index;
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

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (i = 0; i < 10; i = i + 1) begin
            weight_data_fc1[i] <= 0;
            weight_data_fc2[i] <= 0;
            bias_fc[i] <= 0;
        end
        for (i = 0; i < 360; i = i + 1) begin
            weight_data_fc1_all[i] <= 0;
            weight_data_fc2_all[i] <= 0;
        end
        for (i = 0; i < 9; i = i + 1) begin
            bias[i] <= 0;
        end
        ena_c3 <= 1;
        ena_fc <= 1;
        addra_c3 <= 0;
        addra_fc <= 0;
        m <= 0;
        index <= 0;
        i = 0 ;

    end else begin
    if (load_weight)begin    //60 cycle LOAD
        addra_c3 = i;
        addra_fc = i;

        if((i < 29) && (i > 2))begin
        case (i-3)
            0,1,2,3,4,5,6,7,8,9,10,11: weight_data_1[i-3] = douta_c3; //0~11
            13,14,15,16,17,18,19,20,21,22,23,24: weight_data_2[i-16] = douta_c3; //13~24
            12,25: bias[((i-3)/13)] = douta_c3;  //12 25
            default: ena_c3 = 0;
        endcase
        end 

        if((i < 733) && (i > 2)) begin
            if ((index % (2 * SEGMENT_LENGTH)) < SEGMENT_LENGTH) begin
                m = (index / (2 * SEGMENT_LENGTH)) * SEGMENT_LENGTH + (index % SEGMENT_LENGTH);
            end else begin
                m = (index / (2 * SEGMENT_LENGTH)) * SEGMENT_LENGTH + (index % SEGMENT_LENGTH);
            end
            if (index < TOTAL_LENGTH - 1) begin
                index = index + 1;
            end else begin
                index = 0;
            end

        case (i-3)
        // weight_data_fc1_all: 0~35, 73~108, 146~181, 219~254, 292~327, 365~400, 438~473, 511~546, 584~619, 657~692
        0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35,
        73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108,
        146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181,
        219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254,
        292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327,
        365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400,
        438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473,
        511, 512, 513, 514, 515, 516, 517, 518, 519, 520, 521, 522, 523, 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 546,
        584, 585, 586, 587, 588, 589, 590, 591, 592, 593, 594, 595, 596, 597, 598, 599, 600, 601, 602, 603, 604, 605, 606, 607, 608, 609, 610, 611, 612, 613, 614, 615, 616, 617, 618, 619,
        657, 658, 659, 660, 661, 662, 663, 664, 665, 666, 667, 668, 669, 670, 671, 672, 673, 674, 675, 676, 677, 678, 679, 680, 681, 682, 683, 684, 685, 686, 687, 688, 689, 690, 691, 692:
            weight_data_fc1_all[m] = douta_fc;

        // weight_data_fc2_all: 36~71, 109~144, 182~217, 255~290, 328~363, 401~436, 474~509, 547~582, 620~655, 693~728
        36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71,
        109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144,
        182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217,
        255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290,
        328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363,
        401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436,
        474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505, 506, 507, 508, 509,
        547, 548, 549, 550, 551, 552, 553, 554, 555, 556, 557, 558, 559, 560, 561, 562, 563, 564, 565, 566, 567, 568, 569, 570, 571, 572, 573, 574, 575, 576, 577, 578, 579, 580, 581, 582,
        620, 621, 622, 623, 624, 625, 626, 627, 628, 629, 630, 631, 632, 633, 634, 635, 636, 637, 638, 639, 640, 641, 642, 643, 644, 645, 646, 647, 648, 649, 650, 651, 652, 653, 654, 655,
        693, 694, 695, 696, 697, 698, 699, 700, 701, 702, 703, 704, 705, 706, 707, 708, 709, 710, 711, 712, 713, 714, 715, 716, 717, 718, 719, 720, 721, 722, 723, 724, 725, 726, 727, 728:
            weight_data_fc2_all[m] = douta_fc;

        // bias: 72, 145, 218, 291, 364, 437, 510, 583, 656, 729
        72, 145, 218, 291, 364, 437, 510, 583, 656, 729:
            bias_fc[((i-3)/73)] = douta_fc;
        default:ena_fc = 0;
    endcase
    end
        i = i + 1;
    end
    end
end
//////////////////////////////////////////////////////////////////////////////////////傳送資料
always @(posedge o_clk or negedge rst_n) begin
if (!rst_n) begin
        for (i = 0; i < 12; i = i + 1) begin
                weight_data_1[i] <= 0;
                weight_data_2[i] <= 0;
        end
        counter_weight <= 0;
        i = 0;
    end else begin
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

always @(posedge o_clk or negedge rst_n) begin
        if (!rst_n) begin
            // 初始化
            en_c1 <= 0;
            j <= 0;
            cycle_counter <= 0;

        end else if (en) begin
        if (cycle_counter < 6 )begin
            if (j < 100 && !ready) begin
                en_c1 <= 1;
                j = j + 1;
            end else begin
                en_c1 <= 0;
            end
            cycle_counter <= cycle_counter + 1;
        end else if (cycle_counter < 11 )begin
            en_c1 <= 0;
            cycle_counter <= cycle_counter + 1;
        end else begin
            cycle_counter <= 0;
        end
    end else begin
        en_c1 <= 0;
    end
end

//////////////////////////////////////////////////////////////////////////////
always @(posedge o_clk or negedge rst_n) begin  //controll fc
    if(!rst_n)begin
        en_fc <= 0;
    end else begin
    if(en_c1)begin
        en_fc <= 1;
    end else begin
        en_fc <= 0;
    end
    end
end

endmodule