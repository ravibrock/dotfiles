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
OUTDATED=$(mas outdated | awk '{print $2}')
if [[ ! -z $OUTDATED ]]; then
    killall $(echo $OUTDATED)
    tag_log "mas upgrade"
    mas upgrade
fi

# Updates Homebrew itself
tag_log "brew update"
brew update

# Dumps brewfile
tag_log "brew bundle dump --force --file=$DOTFILES/.brewfile"
brew bundle dump --force --file=$DOTFILES/.brewfile

# Cleans up old versions
tag_log "brew cleanup --prune=all"
brew cleanup --prune=all

# Updates tldr documentation
tag_log "tldr --verbose --update"
tldr --verbose --update

# Updates nvim plugins
tag_log 'nvim --headless "+Lazy! sync" +qa'
nvim --headless "+Lazy! sync" +qa
echo "" | tee /dev/stderr # Nvim doesn't add newline by default

# Updates zsh plugins if needed
cd ~/.zsh
for folder in *; do
    cd $folder
    tag_log "git pull ($folder)"
    git pull
    cd ..
done
