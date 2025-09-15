set fpga_host [lindex $argv 0]
set port [lindex $argv 1]
set part [lindex $argv 2]
set bit [lindex $argv 3]

open_hw_manager
connect_hw_server -url $fpga_host:$port
puts "Connected to $fpga_host:$port"
puts "Searching for $part..."

foreach cable [get_hw_targets ] {
	open_hw_target $cable
	set l [get_hw_devices ${part}*]
	if { [llength $l] > 0 } {
	  set dev [lindex $l 0]
    puts "Programming $part ..."
    set_property PROGRAM.FILE $bit $dev
    program_hw_devices $dev
    close_hw_target
    disconnect_hw_server
    close_hw
    exit
	} else {
    puts "Cannot find device with pattern '${part}*'"
	}

	close_hw_target
}

disconnect_hw_server
close_hw
error "ERROR: $part not found at host $fpga_host"
