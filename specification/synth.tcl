
# source parameters
source ../design.tcl
set projDir "${designDir}/vivado"

open_project ${projDir}/${projName}.xpr

# generate block diagram wrapper
set bdFile ${projDir}/${projName}.srcs/sources_1/bd/${projName}/${projName}.bd
if { [file exists ${bdFile}] } {
  make_wrapper -files [get_files ${bdFile}] -top
  add_files -norecurse ${projDir}/${projName}.gen/sources_1/bd/${projName}/hdl/${top}.v
  update_compile_order -fileset sources_1
  set_property TOP ${top} [get_filesets sources_1]
}

reset_runs synth_1
reset_runs impl_1
launch_runs synth_1 -jobs 16
wait_on_runs synth_1

close_project
exit
