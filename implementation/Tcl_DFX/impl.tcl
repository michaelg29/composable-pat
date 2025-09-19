
source ${tclDir_dfx}/dfx_source.tcl

####### FPGA type #######
check_part $part

##### Run parameters #####
set run.topSynth         0
set run.rmSynth          0
set run.dfxImpl          1
set run.greyboxImpl      1
set run.prVerify         1
set run.writeBitstream   0

# implement modules
puts "modules are [get_modules]"
foreach m [get_modules] {
  set_attribute module $m synth 0
}

set impl_partitions $partitions
set scs [list]
if { [info exists top_rm_partitions] } {
  foreach p $top_rm_partitions {
    set module [lindex $p 0]
    set cell [lindex $p 1]
    lappend scs $cell
    lappend impl_partitions [list $module $cell flatten]
  }
}

#
#set top_rm "bitfusion_acc"
#set top_rm_module "systolic_array"
#set top_rm_cell {design_2_i/bitfusion_acc_0/inst/u_fu/bit_acc}
#set top_rm_partitions [list \
#  [list bitbrick design_2_i/bitfusion_acc_0/inst/u_fu/bit_acc/bb implement] \
#]

####################################################################
### Implementation
####################################################################

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

# construct nested hierarchy for subdivision
if { [llength $scs] > 0 } {
  set top_rm_module [get_attribute module $top_rm moduleName]
  set subdivided_static_dcp "$dcpDir/${top_rm}_${top_rm_module}_static.dcp"

  # subdivide
  if { ![file exists $subdivided_static_dcp] } {
    puts "Subdividing from checkpoint at ./Implement/${top_impl}/${top}_route_design.dcp"
    puts "  Subdividing $top_rm_cell into $scs"
    open_checkpoint $implDir/${top_impl}/${top}_route_design.dcp
    pr_subdivide -cell $top_rm_cell -subcells $scs ./Synth/${top_rm}/${top_rm_module}_synth.dcp
    write_checkpoint -force $subdivided_static_dcp
    close_project
  } else {
    puts "Subdivide checkpoint exists at $subdivided_static_dcp"
  }
}

exit
