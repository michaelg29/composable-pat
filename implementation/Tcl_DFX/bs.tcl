
set part xc7z020clg400-1

# top design
set top "design_2_wrapper"

# first-level reconfigurable module
set top_rm "top_dpr"
set top_rm_module "design_2_wrapper"
set top_rm_cell {design_2_i}

# nested reconfigurable modules
set nested_rm "bitfusion_acc"
set nested_rm_module "systolic_array"
set nested_rm_pblock "pblock_slot_0"
set nested_rm_cell {design_2_i/bitfusion_acc_0/inst/u_fu/bit_acc}
set nested_rms [list \
  [list $nested_rm $nested_rm_cell $nested_rm_pblock] \
]

open_checkpoint Implement/${top_rm}/${top_rm_module}_route_design.dcp
write_bitstream -force -no_partial_bitfile -bin_file Bitstreams/${top_rm_module}
source [get_property REPOSITORY [get_ipdefs *dfx_controller:1.0]]/xilinx/dfx_controller_v1_0/tcl/api.tcl
foreach nrm $nested_rms {
  lassign $nrm name cell pblock
  write_bitstream -force -cell $cell -bin_file Bitstreams/${top_rm_module}_${pblock}_${name}_partial
  #dfx_controller_v1_0::format_bin_for_icap -i Bitstreams/${top_rm_module}_${pblock}_partial.bin -o Bitstreams/${name}.icap.bin -bs 1
}
