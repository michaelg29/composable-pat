
# source parameters
source ../design.tcl

# create project
create_project ${projName} ./ -part ${part}

# setup sources
set_property ip_repo_paths [list ${cpDir}/implementation/ip_repo ${ipDir}] [current_project]
source ${cpDir}/implementation/ip_repo/dfx_icap_wrapper_1_0/ttcl/dfx_controller.tcl
update_ip_catalog

# create block diagram
create_bd_design "${projName}"
update_compile_order -fileset sources_1

close_project

# user then creates their design...
puts "At this point, your project is created. Perform the following steps:"

puts "1. Add your sources as needed."
puts "2. Create your block diagram."
puts "  2.a. Assign addresses to all modules."
puts "  2.b. Create an HDL wrapper for the block diagram."
puts "3. Set that as the top-level module."
puts "4. Then run vivado with run.tcl to synthesize the top level design."

exit
