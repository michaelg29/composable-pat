
set part xc7z020clg400-1

# top design
set top "design_2_wrapper"

# first-level reconfigurable module
set top_rm "bitfusion_acc"
set top_rm_module "systolic_array"
set top_rm_cell {design_2_i/bitfusion_acc_0/inst/u_fu/bit_acc}

# nested reconfigurable modules
set nested_rm "bitbrick_shifted"
set nested_rm_module "bitbrick"
set nested_rm_pblock "pblock_slot_0_0"
set nested_rm_cell {design_2_i/bitfusion_acc_0/inst/u_fu/bit_acc/bb}
set nested_rms [list \
  [list $nested_rm $nested_rm_cell $nested_rm_pblock] \
]

open_checkpoint Implement/${top_rm}/${top}_route_design.dcp
source [get_property REPOSITORY [get_ipdefs *dfx_controller:1.0]]/xilinx/dfx_controller_v1_0/tcl/api.tcl

# write bitstreams for nested regions
foreach nrm $nested_rms {
  lassign $nrm name cell pblock
  write_bitstream -force -cell $cell -bin_file Bitstreams/${top_rm_module}_${pblock}_${name}_partial
  #dfx_controller_v1_0::format_bin_for_icap -i Bitstreams/${top_rm_module}_${pblock}_partial.bin -o Bitstreams/${top_rm}.${name}.icap.bin -bs 1
}

# write new version of top-level reconfigurable module with recombined static checkpoint
open_checkpoint ./Checkpoint/${top}_${top_rm}_recombined_route_design.dcp
write_bitstream -force -cell $top_rm_cell -bin_file Bitstreams/${top_rm_module}
