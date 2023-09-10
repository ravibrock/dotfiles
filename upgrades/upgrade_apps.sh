#!/bin/zsh

# Updates formulae and casks
$BREW_PREFIX/bin/brew upgrade
$BREW_PREFIX/bin/brew upgrade --cask

# Updates App Store apps
OUTDATED=$($BREW_PREFIX/bin/mas outdated | /usr/bin/awk '{print $2}')
if [[ ! -z $OUTDATED ]]; then
    /usr/bin/killall $(echo $OUTDATED)
    $BREW_PREFIX/bin/mas upgrade
    cd /Applications/
    /usr/bin/open -a $(echo $OUTDATED)
fi

# Updates Homebrew itself
$BREW_PREFIX/bin/brew update

# Cleans up old versions
$BREW_PREFIX/bin/brew cleanup --prune=all
/usr/bin/find $BREW_PREFIX/Caskroom -type f '(' -name '*.dmg' -or -name '*.pkg' ')' -delete

# Updates tldr documentation
$BREW_PREFIX/bin/tldr --verbose --update

# Updates zsh plugins if needed
cd ~/.zsh
for folder in *; do
    cd $folder
    $BREW_PREFIX/bin/git pull
    cd ..
done
