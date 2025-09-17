
##### Environment #####
if { ![info exists ::env(CP_DIR)] } {
   set errMsg "\nERROR: Could not find environment variable CP_DIR."
   lappend errMsg "\nPlease source the env.sh script for this repository."
   error $errMsg
}
set cpDir $::env(CP_DIR)
set tclDir ${cpDir}/implementation/Tcl_DFX
source ${cpDir}/implementation/Tcl_HD/design_utils.tcl

# technology
set part xc7z020clg400-1

# directory structure
set projDir "/home/mgrieco/src/noesp/noesp_pynq"
set ipDir "/home/mgrieco/src/noesp/ip_repo"
set proj "noesp_pynq"

# hierarchy
set top "design_2_wrapper"
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
source ${tclDir}/ooc_syn.tcl
exit
