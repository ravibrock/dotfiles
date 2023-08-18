#!/bin/zsh

# Updates formulae, casks, and App Store apps
$BREW_PREFIX/bin/brew upgrade
$BREW_PREFIX/bin/brew upgrade --cask
$BREW_PREFIX/bin/mas upgrade

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
