set root_dir [file join [file dirname [info script]] ..]
create_project -in_memory -part $::env(LENET_PART)
set rtl_files {
    top.v layer_1.v layer_2.v layer_3.v
    input_buffer_1.v input_buffer_2.v Pooling_buffer_1.v Pooling_buffer_2.v
    conv33.v conv11.v OutputAccumulator.v relu.v maxpooling.v
    fully_connected.v div2.v div4.v
}

foreach rtl_file $rtl_files {
    read_verilog -sv [file join $root_dir $rtl_file]
}
set xci_files [glob [file join $root_dir ip * *.xci]]
read_ip $xci_files
if {[llength [get_ips]] != 5} {
    error "Expected five Block Memory Generator IPs, found [llength [get_ips]]"
}
generate_target all [get_ips]
synth_ip [get_ips]
synth_design -rtl -top top -part $::env(LENET_PART)
puts "PASS: elaborated complete top hierarchy with five generated ROM IPs"
