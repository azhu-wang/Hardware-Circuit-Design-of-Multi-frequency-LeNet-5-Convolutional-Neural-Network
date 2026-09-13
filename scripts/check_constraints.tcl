set root_dir [file join [file dirname [info script]] ..]
create_project -in_memory -part $::env(LENET_PART)
read_verilog [file join $root_dir verification constraint_top.v]
read_xdc [file join $root_dir constraints timing.xdc]
synth_design -part $::env(LENET_PART) -top constraint_top
if {[llength [get_clocks -quiet sys_clk]] != 1} {
    error "sys_clk constraint was not created"
}
puts "PASS: parsed timing.xdc and created sys_clk"
