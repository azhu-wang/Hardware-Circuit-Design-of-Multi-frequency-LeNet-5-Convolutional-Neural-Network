module top (    //in:30*30 out:10
    input clk,
    input en,
    input rst_n,
    output  ready1,ready2,ready3,start1, start2, stall1,stall2,
    output signed[31:0] out0, out1, out2, out3, out4, out5, out6, out7, out8, out9
);

reg en_l1 , en_l2 , en_l3;
reg load_weight;

wire [7:0] out_l1 [0:5];
wire [7:0] out_l2 [0:11];


layer_1 l1(    //in:30*30 out:14*14*6
    .clk(clk),
    .en(en_l1),
    .rst_n(rst_n),
    .load_weight(load_weight),
    .stall_out(stall1),
    .start(start1),
    .ready(ready1),
    .out1(out_l1[0]), 
    .out2(out_l1[1]), 
    .out3(out_l1[2]), 
    .out4(out_l1[3]), 
    .out5(out_l1[4]), 
    .out6(out_l1[5])
);
layer_2 l2(    //in:14*14*6  out:6*6*12
    .clk(clk),
    .en(en_l2),
    .rst_n(rst_n),
    .load_weight(load_weight),
    .stall_out(stall2),
    .start(start2),
    .ready(ready2),
    .map1(out_l1[0]),
    .map2(out_l1[1]),
    .map3(out_l1[2]),
    .map4(out_l1[3]),
    .map5(out_l1[4]),
    .map6(out_l1[5]),
    .out1(out_l2[0]), 
    .out2(out_l2[1]), 
    .out3(out_l2[2]), 
    .out4(out_l2[3]), 
    .out5(out_l2[4]), 
    .out6(out_l2[5]), 
    .out7(out_l2[6]), 
    .out8(out_l2[7]), 
    .out9(out_l2[8]), 
    .out10(out_l2[9]), 
    .out11(out_l2[10]), 
    .out12(out_l2[11])
);
layer_3 l3(    //in:6*6*12 out:10
    .clk(clk),
    .en(en_l3),
    .load_weight(load_weight),
    .rst_n(rst_n),
    .ready(ready3),
    .map1(out_l2[0]),
    .map2(out_l2[1]),
    .map3(out_l2[2]),
    .map4(out_l2[3]),
    .map5(out_l2[4]),
    .map6(out_l2[5]),
    .map7(out_l2[6]),
    .map8(out_l2[7]),
    .map9(out_l2[8]),
    .map10(out_l2[9]),
    .map11(out_l2[10]),
    .map12(out_l2[11]),
    .out1(out0), 
    .out2(out1), 
    .out3(out2), 
    .out4(out3), 
    .out5(out4), 
    .out6(out5), 
    .out7(out6), 
    .out8(out7), 
    .out9(out8), 
    .out10(out9) 
);
reg [12:0]cycle_count;

always @(negedge clk or negedge rst_n ) begin
    if(!rst_n)begin
        load_weight <= 0;
        cycle_count <= 0;
        en_l1 <= 0;
        en_l2 <= 0;
        en_l3 <= 0;

    end else begin
    if(en)begin
        load_weight <= 1;
        if(cycle_count > 905)begin
            load_weight <= 0;
            en_l1 <= 1;
            if(stall1)begin
                en_l2 <= 0;
            end else if(ready1)begin
                en_l2 <= 1;
            end
            if(ready2 && stall2)begin
                en_l3 <= 1;
            end else begin
                en_l3 <= 0;
            end
            if(ready3)begin
                en_l1 <= 0;
                en_l2 <= 0;
                en_l3 <= 0;
            end
        end
        cycle_count = cycle_count + 1;
    end
    end
end


endmodule