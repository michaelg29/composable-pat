
# root directory
s=$0
[[ "$s" =~ .*sh.* ]] && s=${BASH_SOURCE[0]}
realpath --version &> /dev/null
[ $? -ne 0 ] && CP_DIR="$(pwd)/$(dirname $s)" || CP_DIR="$(realpath $(pwd)/$(dirname $s))"
export CP_DIR

# check Vivado
vivado -version &> /dev/null
[ $? -ne 0 ] && echo "Could not find Vivado" && return
