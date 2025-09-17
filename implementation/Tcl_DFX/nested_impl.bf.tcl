
####### Environment #######
if { ![info exists ::env(CP_DIR)] } {
   set errMsg "\nERROR: Could not find environment variable CP_DIR."
   lappend errMsg "\nPlease source the env.sh script for this repository."
   error $errMsg
}
set cpDir $::env(CP_DIR)

####### TCL imports #######
set tclParams [list hd.visual 1]
set tclHome "${cpDir}/Tcl"
set tclDir $tclHome
set projDir "${cpDir}/noesp_pynq/vivado_dpr"
set ipDir "${cpDir}/noesp/ip_repo"
source $tclDir/design_utils.tcl
source $tclDir/log_utils.tcl
source $tclDir/synth_utils.tcl
source $tclDir/impl_utils.tcl
source $tclDir/dfx_utils.tcl
source $tclDir/hd_utils.tcl

####### FPGA type #######
set part xc7z020clg400-1
check_part $part
set run.topSynth         0
set run.rmSynth          0
set run.dfxImpl          1
set run.greyboxImpl      1
set run.prVerify         1
set run.writeBitstream   0
####Report and DCP controls - values: 0-required min; 1-few extra; 2-all
set verbose      1
set dcpLevel     1

####Output Directories
set synthDir  $projDir/Synth
set implDir   $projDir/Implement
set dcpDir    $projDir/Checkpoint
set bitDir    $projDir/Bitstreams

####Input Directories
set srcDir     $projDir/Sources
set rtlDir     $srcDir/hdl
set prjDir     $srcDir/project
set xdcDir     $srcDir/xdc
set coreDir    $srcDir/cores
set netlistDir $srcDir/netlist

####################################################################
### Top Module Definitions
####################################################################

# top hierarchy (customize)
set top "design_2_wrapper"
set top_impl "top_dpr"
set static "Static"
set top_rm "bitfusion_acc"
set top_rm_module "systolic_array"
set top_rm_cell {design_2_i/bitfusion_acc_0/inst/u_fu/bit_acc}
set top_rm_partitions [list \
  [list bitbrick_shifted design_2_i/bitfusion_acc_0/inst/u_fu/bit_acc/bb implement] \
]

# files from hierarchy
set pblock_file "$projDir/pblocks.xdc"
set subdivided_static_routed_dcp "$dcpDir/${top_rm}_${top_rm_module}_static_routed.dcp"
if { [file exists $subdivided_static_routed_dcp] } {
  set subdivided_static_dcp $subdivided_static_routed_dcp
} else {
  set subdivided_static_dcp "$dcpDir/${top_rm}_${top_rm_module}_static.dcp"
}

add_module $static
set_attribute module $static moduleName    $top
set_attribute module $static top_level     1
set_attribute module $static synthCheckpoint $subdivided_static_dcp

####################################################################
### RP Module Definitions
####################################################################

# top-level reconfigurable module
add_module ${top_rm}
set_attribute module ${top_rm} moduleName ${top_rm_module}
set_attribute module ${top_rm} top_level 0
#set_attribute module ${top_rm} synthCheckpoint $subdivided_static_dcp
set_attribute module $static synthCheckpoint $subdivided_static_dcp

# nested reconfigurable module (customize)
add_module bitbrick
set_attribute module bitbrick moduleName bitbrick

add_module bitbrick_shifted
set_attribute module bitbrick_shifted moduleName bitbrick

####################################################################
### Implementation
####################################################################

set partitions [list \
  [list $static $top import "" "" "" $subdivided_static_dcp] \
  [list bitfusion_acc design_2_i/bitfusion_acc_0/inst/u_fu/bit_acc flatten]
]
foreach p $top_rm_partitions {
  lappend partitions $p
}
puts "Partitions are $partitions"

# import systolic_array_static.dcp after subdividing
add_implementation bitfusion_acc
set_attribute impl bitfusion_acc top          $top
set_attribute impl bitfusion_acc dfx.impl     1
set_attribute impl bitfusion_acc dfx.force_bb 0
set_attribute impl bitfusion_acc implXDC      [list [ list $pblock_file ] ]
set_attribute impl bitfusion_acc partitions   ${partitions}
set_attribute impl bitfusion_acc impl         ${run.dfxImpl}
set_attribute impl bitfusion_acc verify       ${run.prVerify}
set_attribute impl bitfusion_acc bitstream    ${run.writeBitstream}
set_attribute impl bitfusion_acc cfgmem.icap  1
set_attribute impl bitfusion_acc place.pre    [list ${projDir}/attach_nested_pblocks.tcl]

# run implementation
source $tclDir/run.tcl
file copy ${implDir}/bitfusion_acc/${top}_static.dcp $subdivided_static_routed_dcp

# recombine nested partitions
set subdivided_routed_dcp "$implDir/bitfusion_acc/${top}_route_design.dcp"
set recombined_routed_dcp "$dcpDir/${top}_bitfusion_acc_recombined_route_design.dcp"
if { [file exists $subdivided_routed_dcp] && ![file exists $recombined_routed_dcp] } {
   puts "Recombining reconfigurable partition from $subdivided_routed_dcp"
   open_checkpoint $subdivided_routed_dcp
   #read_xdc $pblock_file
   set_property HD.RECONFIGURABLE_CONTAINER true [get_cells $top_rm_cell]
   add_cells_to_pblock [get_pblocks pblock_slot_0] [get_cells $top_rm_cell]
   pr_recombine -cell $top_rm_cell
   write_checkpoint -force $recombined_routed_dcp
   close_project
} else {
   puts "Recombined checkpoint found at $recombined_routed_dcp"
}

exit
