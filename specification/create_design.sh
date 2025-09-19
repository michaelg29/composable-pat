#!/bin/bash

# e.g. bash ${CP_DIR}/specification/create_design.sh bitfusion xc7z020clg400-1

name=$1
part=$2
dir=$(pwd)

[ -z "$name" ] || [ -z "$part" ] && echo "Must specify design name and part as first two arguments." && exit 1

[ -z "${CP_DIR}" ] && echo "Could not find environment variable CP_DIR. Please source the env.sh script" && exit 1

# create directories
mkdir -p vivado
mkdir -p vivado_dfx
mkdir -p vivado_dfx/Synth
mkdir -p vivado_dfx/Implement
mkdir -p vivado_dfx/Checkpoint
mkdir -p vivado_dfx/Bitstreams

# copy design structure specification
cp ${CP_DIR}/specification/create_project.tcl ./vivado
cp ${CP_DIR}/specification/design_dfx.tcl ./vivado_dfx
cp ${CP_DIR}/specification/design.tcl ./design.tcl
cp ${CP_DIR}/specification/synth.tcl ./vivado

# perform text replacements
sed -i -e "s+<<NAME>>+${name}+g" ./design.tcl
sed -i -e "s+<<PART>>+${part}+g" ./design.tcl
sed -i -e "s+<<PWD>>+${dir}+g" ./design.tcl

# create Vivado project
pushd ./vivado
vivado ${VIVADO_BATCH_OPT} -source ./create_project.tcl
