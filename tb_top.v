`timescale 1ns / 1ps

module tb_top;

    // Testbench parameters
    parameter BIT_WIDTH = 8;

    // Inputs
    reg clk;
    reg en;
    reg rst_n;

    // Outputs
    wire  ready1, ready2, ready3,start1, start2,stall1,stall2;
    wire signed [31:0] out0, out1, out2, out3, out4, out5, out6, out7, out8, out9;

    // Instantiate the Unit Under Test (UUT)
    top uut (
        .clk(clk),
        .en(en),
        .rst_n(rst_n),
        .ready1(ready1),
        .ready2(ready2),
        .ready3(ready3),
        .start1(start1),
        .start2(start2),
        .stall1(stall1),
        .stall2(stall2),
        .out0(out0),
        .out1(out1),
        .out2(out2),
        .out3(out3),
        .out4(out4),
        .out5(out5),
        .out6(out6),
        .out7(out7),
        .out8(out8),
        .out9(out9)
    );

    // Clock generation
    always begin
        #1 clk = ~clk; // 10ns clock period
    end

    integer i;

    // Testbench procedure
    initial begin
        // Initialize inputs
        clk = 0;
        en = 0;
        rst_n = 1;

        // Reset the UUT
        #1;
        rst_n = 0;
        #1;
        rst_n = 1;
        en = 1;

        // Wait for result
        wait(ready3); // Adjust the delay to allow the computation to complete
        //clk = 0;
        #1;              //clk高態 rst_n要在低態
        en = 0;
        #1;
        rst_n = 0;
        #1;
        rst_n = 1;
        en = 1;

        wait(ready3);
        //clk = 0;
        #1; 
        en = 0;
        #1;
        rst_n = 0;
        #1;
        rst_n = 1;
        en = 1;

        wait(ready3);
        
        // Finish simulation
        #2;
        $finish;
    end
endmodule
