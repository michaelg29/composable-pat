
bit=${1}
[ ! -f $bit ] && bit="${bit}.bit"
[ ! -f $bit ] && echo "Could not find bitstream ${bit}" && exit

device=${2}
[ -z "$device" ] && device="xc7z020"

fpga_host=${3}
[ -z "$fpga_host" ] && fpga_host="localhost"

port=${4}
[ -z "$port" ] && port="3121"

# invoke vivado
vivado -mode batch -quiet -notrace -source ${CP_DIR}/execution/bitstreams/program.tcl -tclargs $fpga_host $port $device $bit
