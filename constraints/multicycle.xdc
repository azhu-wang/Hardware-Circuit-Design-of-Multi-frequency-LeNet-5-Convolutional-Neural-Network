# layer_2 arithmetic state advances only when ce_2 is asserted.  Its conv33
# outputs and six-channel accumulators therefore have two sys_clk periods
# between active captures.
set l2_ce2_arithmetic_regs [get_cells -hierarchical -filter {
    IS_SEQUENTIAL == 1 &&
    (NAME =~ l2/c*/g_unpipelined.convValue_reg* ||
     NAME =~ l2/O*/AccumulatorValue_reg*)
}]

set_multicycle_path -setup 2 -to $l2_ce2_arithmetic_regs
set_multicycle_path -hold 1 -to $l2_ce2_arithmetic_regs

# layer_3 arithmetic state advances only when ce_4 is asserted.  Both conv11
# outputs and fully-connected accumulators therefore have four sys_clk periods
# between active captures.  Pair setup N with hold N-1 as required by Vivado.
set l3_ce4_arithmetic_regs [get_cells -hierarchical -filter {
    IS_SEQUENTIAL == 1 &&
    (NAME =~ l3/c*/convValue_reg* || NAME =~ l3/fc*/Value_reg*)
}]

set_multicycle_path -setup 4 -to $l3_ce4_arithmetic_regs
set_multicycle_path -hold 3 -to $l3_ce4_arithmetic_regs

# load_weight is a slow mode signal generated on the falling edge.  It stays
# asserted for the entire ROM-loading interval, and every loader independently
# bounds its final write address, so a destination may safely observe either
# transition on the following rising edge.
set load_weight_source_reg [get_cells -hierarchical -filter {
    IS_SEQUENTIAL == 1 && NAME == load_weight_reg
}]

set_multicycle_path -setup 2 -from $load_weight_source_reg
set_multicycle_path -hold 1 -from $load_weight_source_reg
