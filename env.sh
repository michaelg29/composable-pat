
# root directory
s=$0
[[ "$s" =~ .*sh.* ]] && s=${BASH_SOURCE[0]}
export CP_DIR="$(realpath $(pwd)/$(dirname $s))"

