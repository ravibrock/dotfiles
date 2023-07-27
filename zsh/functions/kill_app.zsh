IFS=$'\n'
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
normal=$(tput sgr0)

if [ -z "$1" ] || [ "$1" = "--help" ]; then
    printf "%s\n" "Usage: kill_app string"
    return 0
fi
printf "%s\n" "Finding processes that match “$1”…"
processes=($(pgrep -afil "$1"))
if [ ${#processes[@]} -eq 0 ]; then
    printf "%s\n" "No apps found"
    return 0
else
    printf "${red}Kill${normal} ${#processes[@]} processes detected for $argv[1]? (${green}no${normal}/${yellow}list${normal}/${red}yes${normal})\n"
    read -r answer
    if [ "$answer" = "yes" ]; then
        printf "%s\n" "Killing found apps…"
        for process in "${processes[@]}"; do
            echo $process | awk '{print $1}' | xargs sudo kill 2>&1 | grep -v "No such process"
        done
        printf "%s\n" "Done"
        return 0
    fi
    if [ "$answer" = "list" ]; then
        for process in "${processes[@]}"; do
            echo $process
        done
        return 0
    fi
fi
