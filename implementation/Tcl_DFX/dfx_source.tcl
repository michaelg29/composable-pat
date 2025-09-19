
##### Environment #####
if { ![info exists ::env(CP_DIR)] } {
   set errMsg "\nERROR: Could not find environment variable CP_DIR."
   lappend errMsg "\nPlease source the env.sh script for this repository."
   error $errMsg
}
set cpDir $::env(CP_DIR)

##### TCL imports #####
set tclParams [list hd.visual 1]
set tclHome "${cpDir}/implementation/Tcl_HD"
set tclDir $tclHome
#source $tclDir/design_utils.tcl
source $tclDir/log_utils.tcl
source $tclDir/synth_utils.tcl
source $tclDir/impl_utils.tcl
source $tclDir/dfx_utils.tcl
source $tclDir/hd_utils.tcl

##### Output Directories #####
set synthDir  $projDir/Synth
set implDir   $projDir/Implement
set dcpDir    $projDir/Checkpoint
set bitDir    $projDir/Bitstreams

##### Input Directories #####
set srcDir     $projDir/Sources
set rtlDir     $srcDir/hdl
set prjDir     $srcDir/project
set xdcDir     $srcDir/xdc
set coreDir    $srcDir/cores
set netlistDir $srcDir/netlist

##### Project source #####
set vivadoDir $designDir/vivado
