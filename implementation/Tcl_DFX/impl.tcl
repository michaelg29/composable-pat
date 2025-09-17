set tclParams [list hd.visual 1]
set tclHome "/home/mgrieco/src/noesp/Tcl"
set tclDir $tclHome
set projDir "/home/mgrieco/src/noesp/noesp_pynq/vivado_dpr"
set ipDir "/home/mgrieco/src/noesp/ip_repo"
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
  [list bitbrick design_2_i/bitfusion_acc_0/inst/u_fu/bit_acc/bb implement] \
]

# files from hierarchy
set pblock_file "$projDir/pblocks.xdc"
set subdivided_static_dcp "$dcpDir/${top_rm}_${top_rm_module}_static.dcp"

set top "design_2_wrapper"
set static "Static"
add_module $static
set_attribute module $static moduleName    $top
set_attribute module $static top_level     1
#set_attribute module $static synthCheckpoint $synthDir/$static/top_synth.dcp
####################################################################
### RP Module Definitions
####################################################################
#add_module pipeline_rtl_2
#set_attribute module pipeline_rtl_2 moduleName acc_top
#set_attribute module pipeline_rtl_2 prj /home/mgrieco/src/esp-nested-dfx/socs/xilinx-vc707-xc7vx485t/socketgen/dpr_srcs/acc_2_top/src.prj

#add_module bitfusion_acc
#set_attribute module bitfusion_acc moduleName example_rtl_basic_dma64

add_module bitfusion_acc
set_attribute module bitfusion_acc moduleName systolic_array

add_module fusion_unit
set_attribute module fusion_unit moduleName fusion_unit

add_module four_bitbrick
set_attribute module four_bitbrick moduleName four_bitbrick

add_module bitbrick
set_attribute module bitbrick moduleName bitbrick

####################################################################
### Implementation
####################################################################

# partition for the top and accelerator-level regions
set partitions [list [list $static $top  implement ] \
[list bitfusion_acc design_2_i/bitfusion_acc_0/inst/u_fu/bit_acc implement] \
[list bitbrick design_2_i/bitfusion_acc_0/inst/u_fu/bit_acc/bb flatten]
]
# import all nested regions
#lappend partitions [list systolic_array design_2_i/bitfusion_acc_0/inst/u_fu/bit_acc flatten]
for {set fu_i 0} {$fu_i < 4} {incr fu_i} {
  #lappend partitions [list fusion_unit design_2_i/bitfusion_acc_0/inst/u_fu/bit_acc/fu_${fu_i} flatten]
  for {set cu_i 1} {$cu_i < 5} {incr cu_i} {
    #lappend partitions [list four_bitbrick design_2_i/bitfusion_acc_0/inst/u_fu/bit_acc/fu_${fu_i}/CU_${cu_i} flatten]
    for {set bb_i 1} {$bb_i < 5} {incr bb_i} {
      #lappend partitions [list bitbrick design_2_i/bitfusion_acc_0/inst/u_fu/bit_acc/fu_${fu_i}/CU_${cu_i}/bitbrick_${bb_i} flatten]
    }
  }
}

add_implementation $top_impl
set_attribute impl $top_impl top         $top
set_attribute impl $top_impl dfx.impl    1
set_attribute impl $top_impl implXDC     [list [ list $pblock_file ] ]
set_attribute impl $top_impl partitions  $partitions
set_attribute impl $top_impl impl        ${run.dfxImpl}
set_attribute impl $top_impl verify      ${run.prVerify}
set_attribute impl $top_impl bitstream   ${run.writeBitstream}
set_attribute impl $top_impl cfgmem.icap 1

source $tclDir/run.tcl

# subdivide reconfigurable regions
set scs [list]
foreach p $top_rm_partitions {
  lappend scs [lindex $p 1]
}
if { ![file exists $subdivided_static_dcp] } {
  puts "Subdividing from checkpoint at ./Implement/${top_impl}/${top}_route_design.dcp"
  puts "  Subdividing $top_rm_cell into $scs"
  open_checkpoint ./Implement/${top_impl}/${top}_route_design.dcp
  pr_subdivide -cell $top_rm_cell -subcells $scs ./Synth/${top_rm}/${top_rm_module}_synth.dcp
  puts "MG: rps are [get_rps]"
  write_checkpoint -force $subdivided_static_dcp
  close_project
} else {
  puts "Subdivide checkpoint exists at $subdivided_static_dcp"
}

exit
