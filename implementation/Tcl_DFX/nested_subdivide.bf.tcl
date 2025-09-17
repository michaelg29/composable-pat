
set part xc7z020clg400-1

# top design
set top "top_dpr"
set top_module "design_2_wrapper"

# first-level reconfigurable module
set top_rm "bitfusion_acc"
set top_rm_module "systolic_array"
set top_rm_cell {design_2_i/bitfusion_acc_0/inst/u_fu/bit_acc}

# nested reconfigurable modules
set nested_rm "bitbrick"
set nested_rm_module "bitbrick"
set nested_rms [list]
set scs [list]

# black-box cells
set fu_cells [list]
set cu_cells [list]
set bb_cells [list]

# build hierarchy
set bb_c "design_2_i/bitfusion_acc_0/inst/u_fu/bit_acc/bb"
lappend nested_rms [list $nested_rm $bb_c "pblock_slot_0_0"]
lappend scs $bb_c
lappend bb_cells $bb_c

#for {set fu_i 0} {$fu_i < 4} {incr fu_i} {
#  set fu_c "design_2_i/bitfusion_acc_0/inst/u_fu/bit_acc/fu_${fu_i}"
#  lappend nested_rms [list $nested_rm $fu_c "pblock_slot_0_${fu_i}"]
#  lappend scs $fu_c
#  lappend fu_cells $fu_c
#  for {set cu_i 1} {$cu_i < 5} {incr cu_i} {
#    set cu_c "${fu_c}/CU_${cu_i}"
#    lappend cu_cells $cu_c
#    for {set bb_i 1} {$bb_i < 5} {incr bb_i} {
#      set bb_c "${cu_c}/bitbrick_${bb_i}"
#      lappend bb_cells $bb_c
#    }
#  }
#}

open_checkpoint ./Implement/${top}/${top_module}_route_design.dcp
pr_subdivide -cell $top_rm_cell -subcells $scs ./Synth/${top_rm}/${top_rm_module}_synth.dcp
write_checkpoint -force ./Implement/${top_rm}/${top_rm_module}_static.dcp

