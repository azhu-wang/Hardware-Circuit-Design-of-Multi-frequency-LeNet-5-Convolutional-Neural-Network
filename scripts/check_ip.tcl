set root_dir [file join [file dirname [info script]] ..]
set build_dir [file join $root_dir build ipcheck]
create_project -force lenet_ip $build_dir -part $::env(LENET_PART)
set xci_files [glob [file join $root_dir ip * *.xci]]
read_ip $xci_files
set ips [get_ips]
if {[llength $ips] != 5} {
    error "Expected five Block Memory Generator IPs, found [llength $ips]: $ips"
}

set locked_ips [get_ips -filter {IS_LOCKED == 1}]
if {[llength $locked_ips] > 0} {
    upgrade_ip $locked_ips
}
set locked_ips [get_ips -filter {IS_LOCKED == 1}]
if {[llength $locked_ips] > 0} {
    error "IP files remain locked after upgrade attempt: $locked_ips"
}

generate_target all [get_ips]
foreach ip [get_ips] {
    set run_name ${ip}_synth_1
    if {[llength [get_runs -quiet $run_name]] > 0} {
        launch_runs $run_name
    }
}
foreach ip [get_ips] {
    set run_name ${ip}_synth_1
    if {[llength [get_runs -quiet $run_name]] > 0} {
        wait_on_run $run_name
        if {[get_property PROGRESS [get_runs $run_name]] ne "100%"} {
            error "IP synthesis did not complete for $ip"
        }
    }
}

puts "PASS: generated all Block Memory Generator targets from repository COE files"
close_project
