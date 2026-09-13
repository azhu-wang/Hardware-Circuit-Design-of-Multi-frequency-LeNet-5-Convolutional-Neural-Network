`timescale 1ns / 1ps

module tb_top_smoke;
    reg clk = 1'b0;
    reg en = 1'b0;
    reg rst_n = 1'b0;

    wire ready1, ready2, ready3, start1, start2, stall1, stall2;
    wire signed [31:0] out0, out1, out2, out3, out4;
    wire signed [31:0] out5, out6, out7, out8, out9;

    top dut (
        .clk(clk), .en(en), .rst_n(rst_n),
        .ready1(ready1), .ready2(ready2), .ready3(ready3),
        .start1(start1), .start2(start2), .stall1(stall1), .stall2(stall2),
        .out0(out0), .out1(out1), .out2(out2), .out3(out3), .out4(out4),
        .out5(out5), .out6(out6), .out7(out7), .out8(out8), .out9(out9)
    );

    always #5 clk = ~clk;

    integer best_class;
    reg signed [31:0] best_score;
    reg ready1_d = 1'b0;
    reg ready2_d = 1'b0;

    always @(posedge clk) begin
        ready1_d <= ready1;
        ready2_d <= ready2;
        if (ready1 && !ready1_d)
            $display("INFO: layer 1 first ready at %0t", $time);
        if (ready2 && !ready2_d)
            $display("INFO: layer 2 first ready at %0t", $time);
    end

    task consider;
        input integer class_id;
        input signed [31:0] score;
        begin
            if (score > best_score) begin
                best_score = score;
                best_class = class_id;
            end
        end
    endtask

    initial begin : check_rom_loading
        wait (dut.load_weight === 1'b1);
        wait (dut.load_weight === 1'b0);
        #1;
        $display("INFO: loaded samples image=%0d/%0d c1=%0d/%0d c2=%0d/%0d c3=%0d/%0d fc=%0d/%0d",
                 $signed(dut.l1.picture_data[0]), $signed(dut.l1.picture_data[899]),
                 $signed(dut.l1.weight_data_1[0]), $signed(dut.l1.weight_data_6[8]),
                 $signed(dut.l2.weight_data_1[0]), $signed(dut.l2.weight_data_12[53]),
                 $signed(dut.l3.weight_data_1[0]), $signed(dut.l3.weight_data_2[11]),
                 $signed(dut.l3.weight_data_fc1_all[0]),
                 $signed(dut.l3.weight_data_fc2_all[359]));
        if ($signed(dut.l1.picture_data[0]) != -128 ||
            $signed(dut.l1.picture_data[899]) != -128 ||
            $signed(dut.l1.weight_data_1[0]) != -41 ||
            $signed(dut.l1.weight_data_6[8]) != 16 ||
            $signed(dut.l2.weight_data_1[0]) != -26 ||
            $signed(dut.l2.weight_data_12[53]) != -1 ||
            $signed(dut.l3.weight_data_1[0]) != -19 ||
            $signed(dut.l3.weight_data_2[11]) != 46 ||
            $signed(dut.l3.weight_data_fc1_all[0]) != 13 ||
            $signed(dut.l3.weight_data_fc2_all[359]) != 42)
            $fatal(1, "FAIL: ROM-to-register loading is misaligned");
    end

    initial begin
        repeat (8) @(posedge clk);
        rst_n <= 1'b1;
        en <= 1'b1;

        fork
            begin : wait_for_result
                wait (ready3 === 1'b1);
                #1;
                if ($isunknown({out0, out1, out2, out3, out4,
                                out5, out6, out7, out8, out9})) begin
                    $fatal(1, "FAIL: top-level logits contain X or Z");
                end

                best_class = 0;
                best_score = out0;
                consider(1, out1);
                consider(2, out2);
                consider(3, out3);
                consider(4, out4);
                consider(5, out5);
                consider(6, out6);
                consider(7, out7);
                consider(8, out8);
                consider(9, out9);

                $display("INFO: logits = %0d %0d %0d %0d %0d %0d %0d %0d %0d %0d",
                         out0, out1, out2, out3, out4, out5, out6, out7, out8, out9);
                if (out0 != -1021 || out1 != -2175 || out2 != 186 ||
                    out3 != 251 || out4 != -1017 || out5 != -862 ||
                    out6 != -2614 || out7 != 787 || out8 != -749 ||
                    out9 != 371)
                    $fatal(1, "FAIL: top-level logits differ from the bit-exact reference");
                if (best_class != 7)
                    $fatal(1, "FAIL: expected class 7, got class %0d", best_class);
                $display("PASS: complete top-level inference predicted MNIST class 7");
                $finish;
            end
            begin : timeout_guard
                repeat (100000) @(posedge clk);
                $display("INFO: timeout state top_cycle=%0d en=%b%b%b ready=%b%b%b start=%b%b stall=%b%b l1_k=%0d l2_j=%0d l3_j=%0d c3_en=%b fc_en=%b fc_count=%0d weight_count=%0d",
                         dut.cycle_count, dut.en_l1, dut.en_l2, dut.en_l3,
                         ready1, ready2, ready3, start1, start2, stall1, stall2,
                         dut.l1.k, dut.l2.j, dut.l3.j, dut.l3.en_c1,
                         dut.l3.en_fc, dut.l3.fc1.reg_count, dut.l3.counter_weight);
                $fatal(1, "FAIL: top-level inference timed out");
            end
        join_any
        disable fork;
    end
endmodule
