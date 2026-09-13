if {[llength $argv] != 1} {
    error "Expected repository root as the only Tcl argument"
}

set root_dir [lindex $argv 0]
set report_dir [file join $root_dir build reports]
open_checkpoint [file join $report_dir optimized_synth.dcp]
read_xdc [file join $root_dir constraints multicycle.xdc]
set ce2_regs [get_cells -hierarchical -filter {
    IS_SEQUENTIAL == 1 &&
    (NAME =~ l2/c*/g_unpipelined.convValue_reg* ||
     NAME =~ l2/O*/AccumulatorValue_reg*)
}]
if {[llength $ce2_regs] == 0} {
    error "CE2 multicycle constraint matched no layer_2 arithmetic registers"
}
puts "INFO: CE2 multicycle endpoint registers: [llength $ce2_regs]"

set ce4_regs [get_cells -hierarchical -filter {
    IS_SEQUENTIAL == 1 &&
    (NAME =~ l3/c*/convValue_reg* || NAME =~ l3/fc*/Value_reg*)
}]
if {[llength $ce4_regs] == 0} {
    error "CE4 multicycle constraint matched no layer_3 arithmetic registers"
}
puts "INFO: CE4 multicycle endpoint registers: [llength $ce4_regs]"
set load_weight_reg [get_cells -hierarchical -filter {
    IS_SEQUENTIAL == 1 && NAME == load_weight_reg
}]
if {[llength $load_weight_reg] != 1} {
    error "Expected one load_weight source register, found [llength $load_weight_reg]"
}
puts "INFO: load_weight multicycle source registers: [llength $load_weight_reg]"
report_exceptions -file [file join $report_dir exceptions_synth.rpt]
report_timing_summary -file [file join $report_dir timing_constrained_synth.rpt]
puts "PASS: constrained timing report completed"
