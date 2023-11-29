if [ $# -eq 0 ]; then
    # No arguments
    cd
elif [ ! -f "$1" ] && [ ! -d "$1" ]; then
    # File doesn't exist
    echo "cd: $1: No such file or directory" >&2
elif [ -d "$1" ]; then
    # Argument is a directory
    cd "$(readlink -f "$1")"
else
    # Argument is not a directory
    cd "$(dirname $(readlink -f "$1"))"
fi
