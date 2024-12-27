if [ $# -eq 0 ]; then
    # No arguments
    z
elif [ ! -f "$*" ] && [ ! -d "$*" ]; then
    # Use zoxide heuristic
    z $*
elif [ -d "$*" ]; then
    # Argument is a directory
    z "$(readlink -f "$*")"
else
    # Argument is not a directory
    z "$(dirname $(readlink -f "$*"))"
fi
