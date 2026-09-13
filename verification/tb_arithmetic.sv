`timescale 1ns/1ps

module tb_arithmetic;
    reg clk = 1'b0;
    reg rst_n = 1'b0;
    reg en = 1'b0;
    always #5 clk = ~clk;

    reg signed [7:0] c33_in [0:8];
    reg signed [7:0] c33_w [0:8];
    reg signed [7:0] c33_bias;
    wire signed [31:0] c33_out;

    conv33 u_conv33 (
        .clk(clk), .en(en), .rst_n(rst_n),
        .in1(c33_in[0]), .in2(c33_in[1]), .in3(c33_in[2]),
        .in4(c33_in[3]), .in5(c33_in[4]), .in6(c33_in[5]),
        .in7(c33_in[6]), .in8(c33_in[7]), .in9(c33_in[8]),
        .w1(c33_w[0]), .w2(c33_w[1]), .w3(c33_w[2]),
        .w4(c33_w[3]), .w5(c33_w[4]), .w6(c33_w[5]),
        .w7(c33_w[6]), .w8(c33_w[7]), .w9(c33_w[8]),
        .bias(c33_bias), .convValue(c33_out)
    );

    reg signed [7:0] c11_in [0:11];
    reg signed [7:0] c11_w [0:11];
    reg signed [7:0] c11_bias;
    wire signed [31:0] c11_out;

    conv11 u_conv11 (
        .clk(clk), .en(en), .rst_n(rst_n),
        .in1(c11_in[0]), .in2(c11_in[1]), .in3(c11_in[2]), .in4(c11_in[3]),
        .in5(c11_in[4]), .in6(c11_in[5]), .in7(c11_in[6]), .in8(c11_in[7]),
        .in9(c11_in[8]), .in10(c11_in[9]), .in11(c11_in[10]), .in12(c11_in[11]),
        .w1(c11_w[0]), .w2(c11_w[1]), .w3(c11_w[2]), .w4(c11_w[3]),
        .w5(c11_w[4]), .w6(c11_w[5]), .w7(c11_w[6]), .w8(c11_w[7]),
        .w9(c11_w[8]), .w10(c11_w[9]), .w11(c11_w[10]), .w12(c11_w[11]),
        .bias(c11_bias), .convValue(c11_out)
    );

    reg signed [31:0] acc_in [0:5];
    reg signed [7:0] acc_bias;
    wire signed [34:0] acc_out;
    OutputAccumulator #(.BIT_WIDTH(32), .OUT_WIDTH(35)) u_acc (
        .clk(clk), .en(en), .rst_n(rst_n),
        .in1(acc_in[0]), .in2(acc_in[1]), .in3(acc_in[2]),
        .in4(acc_in[3]), .in5(acc_in[4]), .in6(acc_in[5]),
        .bias(acc_bias), .AccumulatorValue(acc_out)
    );

    reg signed [31:0] relu_in;
    wire signed [7:0] relu_out;
    ReLU #(.BIT_WIDTH(32), .SHIFT(10)) u_relu (.in(relu_in), .out(relu_out));

    reg signed [7:0] fc_in1, fc_in2, fc_w1, fc_w2, fc_bias;
    wire fc_ready;
    wire signed [31:0] fc_value;
    fully_connected u_fc (
        .clk(clk), .en(en), .rst_n(rst_n),
        .in1(fc_in1), .in2(fc_in2), .weight1(fc_w1), .weight2(fc_w2),
        .bias(fc_bias), .ready(fc_ready), .Value(fc_value)
    );

    wire ce2, ce4;
    div2 u_div2 (.clk(clk), .rst_n(rst_n), .o_clk(ce2));
    div4 u_div4 (.clk(clk), .rst_n(rst_n), .o_clk(ce4));

    integer n;
    integer ce2_count = 0;
    integer ce4_count = 0;
    always @(posedge clk) begin
        if (rst_n) begin
            if (ce2) ce2_count <= ce2_count + 1;
            if (ce4) ce4_count <= ce4_count + 1;
        end
    end

    task automatic check(input bit condition, input string message);
        if (!condition) begin
            $error("FAIL: %s", message);
            $fatal(1);
        end
    endtask

    initial begin
        for (n = 0; n < 9; n = n + 1) begin
            c33_in[n] = 8'sd127;
            c33_w[n] = 8'sd127;
        end
        c33_bias = 8'sd127;
        for (n = 0; n < 12; n = n + 1) begin
            c11_in[n] = 8'sd127;
            c11_w[n] = 8'sd127;
        end
        c11_bias = 8'sd127;

        acc_in[0] = 32'sh7fff_ffff;
        acc_in[1] = 32'sh7fff_ffff;
        acc_in[2] = -32'sd10;
        acc_in[3] = -32'sd20;
        acc_in[4] = 32'sd30;
        acc_in[5] = 32'sd40;
        acc_bias = -8'sd5;

        fc_in1 = 8'sd1;
        fc_in2 = 8'sd2;
        fc_w1 = 8'sd3;
        fc_w2 = 8'sd4;
        fc_bias = 8'sd5;
        relu_in = 32'sd0;

        repeat (2) @(posedge clk);
        rst_n = 1'b1;
        en = 1'b1;
        @(posedge clk);
        #1;

        check(c33_out == 32'sd145288, "conv33 must accumulate without 16-bit overflow");
        check(c11_out == 32'sd193675, "conv11 must accumulate without 16-bit overflow");
        check(acc_out == 35'sd4294967329, "six-input accumulator must sign-extend before addition");

        relu_in = -32'sd1; #1;
        check(relu_out == 0, "ReLU negative clamp");
        relu_in = 32'sd65536; #1;
        check(relu_out == 8'sd64, "ReLU normal shift");
        relu_in = 32'sd129535; #1;
        check(relu_out == 8'sd126, "ReLU value before saturation");
        relu_in = 32'sd129536; #1;
        check(relu_out == 8'sd127, "ReLU saturation threshold");

        wait (fc_ready);
        #1;
        check(fc_value == 32'sd401, "FC must consume all 72 inputs and add bias once");

        repeat (5) @(posedge clk);
        #1;
        $display("clock-enable counts: ce2=%0d ce4=%0d", ce2_count, ce4_count);
        check(ce2_count == 20, "divide-by-two enable pulse count");
        check(ce4_count == 10, "divide-by-four enable pulse count");

        $display("PASS: arithmetic, requantization boundary, FC length, and clock enables");
        $finish;
    end
endmodule
