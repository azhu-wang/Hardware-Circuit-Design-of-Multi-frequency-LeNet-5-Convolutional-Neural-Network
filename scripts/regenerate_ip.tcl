set root_dir [file join [file dirname [info script]] ..]
set project_dir [file join $root_dir build ipregen]
create_project -force lenet_ip_regen $project_dir -part $::env(LENET_PART)
set ip_root [file join $root_dir ip]
file mkdir $ip_root

set specifications {
    blk_mem_gen_c1      60   kernel_c1.coe
    blk_mem_gen_c2      660  kernel_c3.coe
    blk_mem_gen_c3      26   kernel_c5.coe
    blk_mem_gen_fc      730  weights_fc.coe
    blk_mem_gen_picture 9000 quantized_images.coe
}

foreach {module_name depth coe_name} $specifications {
    create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 \
        -module_name $module_name -dir $ip_root
    set_property -dict [list \
        CONFIG.Memory_Type {Single_Port_ROM} \
        CONFIG.Write_Width_A {8} \
        CONFIG.Write_Depth_A $depth \
        CONFIG.Enable_A {Use_ENA_Pin} \
        CONFIG.Register_PortA_Output_of_Memory_Primitives {true} \
        CONFIG.Register_PortA_Output_of_Memory_Core {false} \
        CONFIG.Load_Init_File {true} \
        CONFIG.Coe_File [file join $root_dir weights $coe_name] \
    ] [get_ips $module_name]
    generate_target all [get_ips $module_name]
}

puts "PASS: regenerated five Block Memory Generator IPs with Vivado 2025.1"
close_project
