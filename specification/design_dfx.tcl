
if { [llength $argv] > 0 } {
  set step [lindex $argv 0]
} else {
  set step "static_config"
}

##### Environment #####
source ../design.tcl
set tclDir_dfx ${cpDir}/implementation/Tcl_DFX
source ${cpDir}/implementation/Tcl_HD/design_utils.tcl

# directory structure
set projDir "${designDir}/vivado_dfx"

# hierarchy
set static "Static"

# module construction
add_module bitfusion_acc
set_attribute module bitfusion_acc moduleName systolic_array
set ip_acc "${ipDir}/bitfusion_acc_1_0/hdl"
set_attribute module bitfusion_acc vlog [list   ${ip_acc}/example_rtl_basic_dma64/bitbrick.bb.v ${ip_acc}/example_rtl_basic_dma64/systolic_array.v]
set_attribute module bitfusion_acc synth 1

add_module bitbrick
set_attribute module bitbrick moduleName bitbrick
set_attribute module bitbrick vlog [list  ${ip_acc}/example_rtl_basic_dma64/mult_bb.v ${ip_acc}/example_rtl_basic_dma64/bitbrick.v]
set_attribute module bitbrick synth 1

add_module bitbrick_shifted
set_attribute module bitbrick_shifted moduleName bitbrick
set_attribute module bitbrick_shifted vlog [list  ${ip_acc}/example_rtl_basic_dma64/mult_bb.v ${ip_acc}/example_rtl_basic_dma64/bitbrick_shifted.v]
set_attribute module bitbrick_shifted synth 1

# partition construction
if { [file exists ${tclDir_dfx}/${step}.tcl] } {
  source ${tclDir_dfx}/${step}.tcl
} else {
  error "Could not find step file for '$step'"
}
exit
