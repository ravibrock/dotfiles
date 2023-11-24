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
$BREW_PREFIX/brew upgrade
tag_log "brew cu"
$BREW_PREFIX/brew cu --cleanup --no-brew-update --no-quarantine --quiet --yes

# Updates App Store apps
OUTDATED=$($BREW_PREFIX/mas outdated | awk '{print $2}')
if [[ ! -z $OUTDATED ]]; then
    killall $(echo $OUTDATED)
    tag_log "[mas upgrade]"
    $BREW_PREFIX/mas upgrade
fi

# Updates Homebrew itself
tag_log "brew update"
$BREW_PREFIX/brew update

# Dumps brewfile
tag_log "brew bundle dump"
$BREW_PREFIX/brew bundle dump --force --file=$DOTFILES/.brewfile

# Cleans up old versions
tag_log "brew cleanup"
$BREW_PREFIX/brew cleanup --prune=all

# Updates tldr documentation
tag_log "tldr --update"
$BREW_PREFIX/tldr --verbose --update

# Updates zsh plugins if needed
cd ~/.zsh
tag_log "zsh plugins update"
for folder in *; do
    cd $folder
    $BREW_PREFIX/git pull
    cd ..
done
