#!/bin/zsh

# Nicer logs
function tag_log { echo "[$(date "+%Y-%m-%d %H:%M:%S %Z")] $1" | tee /dev/stderr }

# Checks internet connection
if ! ping -q -c1 8.8.8.8 &> /dev/null; then
    tag_log "No internet connection. Aborting."
    exit 1
fi

# Updates formulae and casks
tag_log "brew upgrade"
brew upgrade
tag_log "brew cu --cleanup --no-brew-update --no-quarantine --quiet --yes"
brew cu --cleanup --no-brew-update --no-quarantine --quiet --yes

# Updates App Store apps
OUTDATED="$(mas outdated | awk '{print $2}')"
if [[ ! -z "$OUTDATED" ]]; then
    for APP in $OUTDATED; do
        if [[ ! "" == "$(pgrep -f "$APP")" ]] OPEN="$APP $OPEN"
    done
    OPEN="$(echo "$OPEN" | xargs)"
    killall "$(echo "$OUTDATED")"
    tag_log "mas upgrade"
    mas upgrade
    if [[ ! -z "$OPEN" ]]; then
        for APP in "$OPEN"; do
            open -n "/Applications/$APP.app"
        done
    fi
fi

# Updates Homebrew itself
tag_log "brew update"
brew update

# Dumps brewfile
tag_log 'brew bundle dump --force --file="$DOTFILES/.brewfile"'
brew bundle dump --force --file="$DOTFILES/.brewfile"

# Cleans up old versions
tag_log "brew cleanup --prune=all"
brew cleanup --prune=all

# Updates tldr documentation
tag_log "tldr --update"
tldr --update

# Updates nvim plugins
tag_log 'nvim --headless "+Lazy! sync" +qa'
{ # Fix newlines in output
    IFS=$'\n' read -r -d '' CAPTURED_STDERR;
    IFS=$'\n' read -r -d '' CAPTURED_STDOUT;
} < <((printf '\0%s\0' "$(nvim --headless "+Lazy! sync" +qa)" 1>&2) 2>&1)
if [[ -n "${CAPTURED_STDOUT}" && -n "${CAPTURED_STDOUT//[:space:]/}" ]] printf "$CAPTURED_STDOUT\n"
if [[ -n "${CAPTURED_STDERR}" && -n "${CAPTURED_STDERR//[:space:]/}" ]] printf "$CAPTURED_STDERR\n" >&2

# Updates zsh plugins if needed
cd ~/.zsh
for folder in *; do
    cd $folder
    tag_log "git pull ($folder)"
    git pull
    cd ..
done
