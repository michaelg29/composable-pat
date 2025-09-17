
source dfx_source.tcl

# add checkpoint
add_files ${vivadoDir}/${proj}.runs/synth_1/${top}.dcp

# add IP sources
set ips [glob ${vivadoDir}/${proj}.srcs/sources_1/bd/design_2/ip/*/*.xci]
foreach ip $ips {
    puts "Reading IP source @ $ip"
    read_ip -quiet $ip
}
read_ip -quiet ${vivadoDir}/${proj}.srcs/sources_1/ip/processing_system7/processing_system7.xci

# link design and write checkpoint to start DFX flow
link_design -top ${top} -part ${part}
write_checkpoint -force ./Synth/${static}/${top}_synth.dcp
