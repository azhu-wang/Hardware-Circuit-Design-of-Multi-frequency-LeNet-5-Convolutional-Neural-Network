if {[llength $argv] != 1} {
    error "Expected repository root as the only Tcl argument"
}
set root_dir [lindex $argv 0]
set report_dir [file join $root_dir build reports]
file mkdir $report_dir

set rtl_sources [list \
    top.v layer_1.v layer_2.v layer_3.v \
    input_buffer_1.v input_buffer_2.v Pooling_buffer_1.v Pooling_buffer_2.v \
    conv33.v conv11.v OutputAccumulator.v relu.v maxpooling.v \
    fully_connected.v div2.v div4.v]

foreach source $rtl_sources {
    read_verilog -sv [file join $root_dir $source]
}
read_verilog -sv [file join $root_dir verification rom_stubs.sv]
read_xdc [file join $root_dir constraints timing.xdc]

if {![info exists ::env(LENET_PART)]} {
    error "LENET_PART is not set; run scripts/run_vivado.ps1"
}
synth_design -top top -part $::env(LENET_PART) \
    -flatten_hierarchy rebuilt \
    -directive AreaOptimized_high \
    -resource_sharing on \
    -cascade_dsp tree \
    -max_dsp 220

# Replace the lightweight ROM interface stubs with the generated OOC netlists
# before implementation-only optimization.  This keeps RTL synthesis quick but
# gives opt_design a complete netlist instead of five black boxes.
read_checkpoint -cell l1/bc1 [file join $root_dir ip blk_mem_gen_c1 blk_mem_gen_c1.dcp]
read_checkpoint -cell l1/bp1 [file join $root_dir ip blk_mem_gen_picture blk_mem_gen_picture.dcp]
read_checkpoint -cell l2/bc1 [file join $root_dir ip blk_mem_gen_c2 blk_mem_gen_c2.dcp]
read_checkpoint -cell l3/bc3 [file join $root_dir ip blk_mem_gen_c3 blk_mem_gen_c3.dcp]
read_checkpoint -cell l3/bfc [file join $root_dir ip blk_mem_gen_fc blk_mem_gen_fc.dcp]
read_xdc [file join $root_dir constraints multicycle.xdc]
opt_design -directive ExploreArea

# opt_design can rebuild arithmetic registers.  Re-resolve the name-based
# collections against the optimized netlist before writing final reports.
read_xdc [file join $root_dir constraints multicycle.xdc]

set ce2_regs [get_cells -hierarchical -filter {
    IS_SEQUENTIAL == 1 &&
    (NAME =~ l2/c*/g_unpipelined.convValue_reg* ||
     NAME =~ l2/O*/AccumulatorValue_reg*)
}]
set ce4_regs [get_cells -hierarchical -filter {
    IS_SEQUENTIAL == 1 &&
    (NAME =~ l3/c*/convValue_reg* || NAME =~ l3/fc*/Value_reg*)
}]
set load_weight_regs [get_cells -hierarchical -filter {
    IS_SEQUENTIAL == 1 && NAME == load_weight_reg
}]
if {[llength $ce2_regs] != 1716} {
    error "Expected 1716 CE2 arithmetic registers, found [llength $ce2_regs]"
}
if {[llength $ce4_regs] != 384} {
    error "Expected 384 CE4 arithmetic registers, found [llength $ce4_regs]"
}
if {[llength $load_weight_regs] != 1} {
    error "Expected one load_weight source register, found [llength $load_weight_regs]"
}

write_checkpoint -force [file join $report_dir optimized_synth.dcp]
set utilization_file [file join $report_dir utilization_synth.rpt]
report_utilization -file $utilization_file
report_utilization -hierarchical -hierarchical_depth 2 \
    -file [file join $report_dir utilization_hierarchical_synth.rpt]
report_timing_summary -file [file join $report_dir timing_synth.rpt]
report_methodology -file [file join $report_dir methodology_synth.rpt]
report_drc -file [file join $report_dir drc_synth.rpt]

set utilization_handle [open $utilization_file r]
set utilization_text [read $utilization_handle]
close $utilization_handle
if {![regexp {\|\s*Slice LUTs\*\s*\|\s*([0-9]+)} $utilization_text _ slice_luts]} {
    error "Could not parse Slice LUT count from utilization report"
}
if {![regexp {\|\s*DSPs\s*\|\s*([0-9]+)} $utilization_text _ dsp_count]} {
    error "Could not parse DSP count from utilization report"
}
if {$slice_luts > 53200} {
    error "Slice LUT budget exceeded: $slice_luts / 53200"
}
if {$dsp_count != 220} {
    error "Expected all 220 DSPs to be used, found $dsp_count"
}

set worst_setup_path [get_timing_paths -quiet -delay_type max -max_paths 1]
set worst_hold_path [get_timing_paths -quiet -delay_type min -max_paths 1]
if {[llength $worst_setup_path] == 0 || [llength $worst_hold_path] == 0} {
    error "Could not obtain setup and hold timing paths"
}
set setup_slack [get_property SLACK $worst_setup_path]
set hold_slack [get_property SLACK $worst_hold_path]
if {$setup_slack < 0.0} {
    error "100 MHz setup timing failed with WNS $setup_slack ns"
}
if {$hold_slack < 0.0} {
    error "Hold timing failed with WHS $hold_slack ns"
}
puts "PASS: resources LUT=$slice_luts/53200 DSP=$dsp_count/220"
puts "PASS: 100 MHz timing WNS=$setup_slack ns WHS=$hold_slack ns"

set critical_count [llength [get_drc_violations -quiet -filter {SEVERITY == Critical}]]
if {$critical_count != 0} {
    error "Synthesis completed with $critical_count critical DRC violation(s)"
}

puts "PASS: synthesis and structural reports completed"
