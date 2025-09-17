
[ -z "${CP_DIR}" ] && echo "Could not find environment variable CP_DIR. Please source the env.sh script" && exit 1

# create directories
mkdir -p vivado
mkdir -p vivado_dfx
mkdir -p vivado_dfx/Synth
mkdir -p vivado_dfx/Implement
mkdir -p vivado_dfx/Checkpoint
mkdir -p vivado_dfx/Bitstreams

# copy design structure specification
cp ${CP_DIR}/specification/design.tcl ./design.tcl
