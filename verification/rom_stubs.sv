// Black-box declarations used by scripts/synth.tcl when the generated Block Memory
// products are unavailable. They verify the complete RTL hierarchy without silently
// replacing the ROMs with constant data.
(* black_box *) module blk_mem_gen_picture(
    input wire clka, input wire ena, input wire [13:0] addra, output wire [7:0] douta
); endmodule
(* black_box *) module blk_mem_gen_c1(
    input wire clka, input wire ena, input wire [5:0] addra, output wire [7:0] douta
); endmodule
(* black_box *) module blk_mem_gen_c2(
    input wire clka, input wire ena, input wire [9:0] addra, output wire [7:0] douta
); endmodule
(* black_box *) module blk_mem_gen_c3(
    input wire clka, input wire ena, input wire [4:0] addra, output wire [7:0] douta
); endmodule
(* black_box *) module blk_mem_gen_fc(
    input wire clka, input wire ena, input wire [9:0] addra, output wire [7:0] douta
); endmodule
