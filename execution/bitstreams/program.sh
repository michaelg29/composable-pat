
[ -z "${CP_DIR}" ] && echo "Could not find environment variable CP_DIR. Please source the env.sh script" && exit 1

bit=${1}
[ ! -f $bit ] && bit="${bit}.bit"
[ ! -f $bit ] && echo "Could not find bitstream ${bit}" && exit 1

device=${2}
[ -z "$device" ] && device="xc7z020"

fpga_host=${3}
[ -z "$fpga_host" ] && fpga_host="localhost"

port=${4}
[ -z "$port" ] && port="3121"

# invoke vivado
vivado -mode batch -quiet -notrace -source ${CP_DIR}/execution/bitstreams/program.tcl -tclargs $fpga_host $port $device $bit
