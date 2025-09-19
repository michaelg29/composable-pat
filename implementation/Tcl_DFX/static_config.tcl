
source ${tclDir_dfx}/dfx_source.tcl

# add checkpoint
add_files ${vivadoDir}/${projName}.runs/synth_1/${top}.dcp

# add IP sources
set ips [glob ${vivadoDir}/${projName}.srcs/sources_1/bd/${projName}/ip/*/*.xci]
foreach ip $ips {
    puts "Reading IP source @ $ip"
    read_ip -quiet $ip
}
read_ip -quiet ${vivadoDir}/${projName}.srcs/sources_1/ip/processing_system7/processing_system7.xci

# link design and write checkpoint to start DFX flow
link_design -top ${top} -part ${part}
write_checkpoint -force ./Synth/${static}/${top}_synth.dcp
